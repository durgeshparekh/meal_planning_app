import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/screens/authentication/login_screen.dart';
import 'package:meal_planning_app/utils/box_name.dart';
import '../data/api/api_client.dart';
import '../data/api/endpoints.dart';

class HomeController extends GetxController {
  var userName = ''.obs;
  var searchController = ''.obs;
  var isLoading = false.obs;
  var recipes = [].obs;
  var selectedIndex = 0.obs;
  var mealsBox = Hive.box(BoxName.mealsBox).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

  // Fetch the username of the logged-in user
  void fetchUserName() {
    var userBox = Hive.box(BoxName.userBox);
    var loggedInUser = userBox.values.firstWhere(
      (user) => user['isLogin'] == true,
      orElse: () => null,
    );

    if (loggedInUser != null) {
      userName.value = loggedInUser['name'];
    } else {
      userName.value = 'Guest';
    }
  }

  // Fetch recipes based on the search query
  void fetchRecipes(String query) async {
    try {
      debugPrint('fetchRecipes called with query: $query');
      isLoading.value = true;
      final data = await ApiClient().get(Endpoints.searchRecipes, params: {
        'query': query,
      });
      recipes.value = data['results'];
      debugPrint('Recipes fetched successfully');
    } catch (e) {
      debugPrint('Error fetching recipes: $e');
      Get.snackbar('Error', 'Failed to fetch recipes');
    } finally {
      isLoading.value = false;
      debugPrint('isLoading set to false');
    }
  }

  // Handle bottom navigation item tap
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  // Logout the user and navigate to the login screen
  void logout() async {
    debugPrint('Attempting user logout');
    var userBox = Hive.box(BoxName.userBox);
    var loggedInUser = userBox.values.firstWhere(
      (user) => user['isLogin'] == true,
      orElse: () => null,
    );

    if (loggedInUser != null) {
      loggedInUser['isLogin'] = false;
      userBox.putAt(
          userBox.values.toList().indexOf(loggedInUser), loggedInUser);
      debugPrint('User logout successful');
      Fluttertoast.showToast(msg: 'User logout successful');
      Get.offAll(() => const LoginScreen());
    } else {
      debugPrint('No logged-in user found');
    }
  }

  // Delete a meal from the meals box
  void deleteMeal(int index) {
    mealsBox.value.deleteAt(index);
    mealsBox.refresh();
  }
}
