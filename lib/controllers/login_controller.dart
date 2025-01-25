import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/screens/authentication/login_screen.dart';
import 'package:meal_planning_app/utils/box_name.dart';
import 'package:meal_planning_app/screens/home_screen.dart';

class LoginController extends GetxController {
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    clearTextFields();
    debugPrint('🟢 LoginController initialized');
  }

  void clearTextFields() {
    if (nameController.text.isNotEmpty) {
      nameController.clear();
    }
    if (emailController.text.isNotEmpty) {
      emailController.clear();
    }
    if (confirmPasswordController.text.isNotEmpty) {
      confirmPasswordController.clear();
    }
    if (passwordController.text.isNotEmpty) {
      passwordController.clear();
    }
    debugPrint('🧹 Text fields cleared');
  }

  userLogin() async {
    debugPrint('🔐 Attempting user login');
    var userBox = Hive.box(BoxName.userBox);
    debugPrint(
        '📦 User box data: ${userBox.toMap()}'); // Added debug print to view user box data
    if (userBox.isEmpty) {
      Get.snackbar(
          'Error', 'No registered users found. Please register first.');
      debugPrint('❌ No registered users found');
      return;
    }

    var storedUser = userBox.values.firstWhere(
      (user) => user['email'] == emailController.text.trim(),
      orElse: () => null,
    );

    if (storedUser != null &&
        storedUser['password'] == passwordController.text.trim()) {
      debugPrint('✅ User login successful');
      Fluttertoast.showToast(msg: 'Welcome back, ${storedUser['name']}');
      storedUser['isLogin'] = true;
      userBox.putAt(userBox.values.toList().indexOf(storedUser), storedUser);
      Get.offAll(() => const HomeScreen());
    } else {
      Get.snackbar('Error', 'Invalid email or password');
      debugPrint('❌ Invalid email or password');
    }
  }

  bool validateRegistration() {
    debugPrint('📝 Validating registration');
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      debugPrint('❌ Validation failed: All fields are required');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      debugPrint('❌ Validation failed: Passwords do not match');
      return false;
    }
    debugPrint('✅ Validation successful');
    return true;
  }

  void registerUser() {
    debugPrint('🔐 Attempting user registration');
    if (validateRegistration()) {
      var userBox = Hive.box(BoxName.userBox);
      var existingUser = userBox.values.firstWhere(
        (user) => user['email'] == emailController.text.trim(),
        orElse: () => null,
      );

      if (existingUser != null) {
        Get.snackbar(
            'Error', 'Email is already registered. Please use another email.');
        debugPrint('❌ Registration failed: Email is already registered');
        return;
      }

      var user = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'isLogin': false,
      };
      userBox.add(user);
      Fluttertoast.showToast(msg: 'User registered successfully');
      debugPrint('✅ User registered successfully');
      clearTextFields();
      Get.offAll(() => const LoginScreen());
    }
  }
}
