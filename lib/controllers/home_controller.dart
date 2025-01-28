import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/screens/authentication/login_screen.dart';
import 'package:meal_planning_app/utils/box_name.dart';

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


  // Handle bottom navigation item tap
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  // Logout the user and navigate to the login screen
  void logout() async {
    var userBox = Hive.box(BoxName.userBox);
    var loggedInUser = userBox.values.firstWhere(
      (user) => user['isLogin'] == true,
      orElse: () => null,
    );

    if (loggedInUser != null) {
      // Delete user's meals and cart data
      var userId = loggedInUser['id'];
      var mealsBox = Hive.box(BoxName.mealsBox);
      var groceriesBox = Hive.box(BoxName.groceriesBox);

      mealsBox.delete(userId);
      groceriesBox.delete(userId);

      // Logout user
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

  // Delete a meal from the meals box and groceries box by recipe id
  void deleteMeal(int index) {
    var meal = mealsBox.value.getAt(index);
    var recipeId = meal['recipeId'];

    // Delete meal from meals box
    mealsBox.value.deleteAt(index);
    mealsBox.refresh();

    // Delete corresponding groceries from groceries box
    var groceriesBox = Hive.box(BoxName.groceriesBox);
    var groceriesToDelete = groceriesBox.values.where((grocery) => grocery['recipeId'] == recipeId).toList();
    for (var grocery in groceriesToDelete) {
      groceriesBox.delete(grocery['recipeId']);
    }
  }
}
