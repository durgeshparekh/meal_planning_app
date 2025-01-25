import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meal_planning_app/data/api/http_urls.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/screens/home_screen.dart';

class RecipeDetailsController extends GetxController {
  var selectedRecipe = {}.obs;
  var recipes = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Fetch random recipes from the API
  void fetchRecipes() async {
    var queryParameters = {
      'limitLicense': 'true',
      'tags': 'indian',
      'number': '10',
      'apiKey': HttpUrls.apiKey
    };
    final uri = Uri.parse(HttpUrls.randomRecipesUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      recipes.value = data['recipes'];
    } else {
      Get.snackbar('Error', 'Failed to fetch recipes');
    }
    isLoading.value = false;
  }

  // Search for recipes based on a query
  void searchRecipes(String query) async {
    if (query.isEmpty) {
      fetchRecipes();
      return;
    }

    isLoading.value = true;
    var queryParameters = {
      'query': query,
      'number': '40',
      'apiKey': HttpUrls.apiKey
    };
    final uri = Uri.parse(HttpUrls.searchRecipesUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      recipes.value = data['results'];
    } else {
      Get.snackbar('Error', 'Failed to search recipes');
    }
    isLoading.value = false;
  }

  // Save a recipe to the Hive box
  Future<void> saveRecipe(Map<String, dynamic> recipe) async {
    var box = await Hive.openBox('meals');
    var mealData = {
      'title': recipe['title'],
      'image': recipe['image'],
      'summary': recipe['summary'],
      'extendedIngredients': recipe['extendedIngredients'],
    };
    await box.add(mealData);
    Fluttertoast.showToast(msg: "Meal saved successfully");
    Get.offAll(() => const HomeScreen());
  }
}
