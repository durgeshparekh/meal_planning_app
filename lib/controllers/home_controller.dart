import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/screens/authentication/login_screen.dart';
import 'package:meal_planning_app/utils/box_name.dart';
import '../data/api/api_client.dart';
import '../data/api/endpoints.dart';
import '../screens/meal_plan_screen.dart';
import '../screens/search_recipes_screen.dart';
import '../screens/grocery_list_screen.dart';

class HomeController extends GetxController {
  var userName = ''.obs;
  var searchController = ''.obs;
  var isLoading = false.obs;
  var recipes = [].obs;
  var selectedIndex = 0.obs;

  static const List<Widget> widgetOptions = <Widget>[
    MealPlanScreen(),
    SearchRecipesScreen(),
    GroceryListScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

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

  void fetchRecipes(String query) async {
    try {
      debugPrint('🔍 fetchRecipes called with query: $query'); // Debug print with emoji
      isLoading.value = true;
      final data = await ApiClient().get(Endpoints.searchRecipes, params: {
        'query': query,
        // 'number': 10,
      });
      recipes.value = data['results'];
      debugPrint('✅ Recipes fetched successfully'); // Debug print with emoji
    } catch (e) {
      debugPrint('❌ Error fetching recipes: $e'); // Debug print with emoji
      Get.snackbar('Error', 'Failed to fetch recipes');
    } finally {
      isLoading.value = false;
      debugPrint('🔄 isLoading set to false'); // Debug print with emoji
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  void logout() async {
    debugPrint('🔒 Attempting user logout');
    var userBox = Hive.box(BoxName.userBox);
    var loggedInUser = userBox.values.firstWhere(
      (user) => user['isLogin'] == true,
      orElse: () => null,
    );

    if (loggedInUser != null) {
      loggedInUser['isLogin'] = false;
      userBox.putAt(
          userBox.values.toList().indexOf(loggedInUser), loggedInUser);
      debugPrint('✅ User logout successful');
      Fluttertoast.showToast(msg: 'User logout successful');
      Get.offAll(() => const LoginScreen());
    } else {
      debugPrint('❌ No logged-in user found');
    }
  }

}
