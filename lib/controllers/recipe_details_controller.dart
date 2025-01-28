import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meal_planning_app/api/http_urls.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/screens/home_screen.dart';

class RecipeDetailsController extends GetxController {
  var selectedRecipe = {}.obs;
  var recipes = [].obs;
  var isLoading = false.obs;
  var error = ''.obs; // Add this line

  RecipeDetailsController({bool showFetchRecipes = true}) {
    if (showFetchRecipes) {
      fetchRecipes();
    }
  }

  // Fetch random recipes from the API
  void fetchRecipes() async {
    debugPrint('Fetching recipes');
    error.value = ''; // Clear error before fetching
    var queryParameters = {
      'limitLicense': 'false',
      'include-tags': 'vegetarian, indian',
      'number': '10',
      'apiKey': HttpUrls.apiKey
    };
    final uri = Uri.parse(HttpUrls.randomRecipesUrl)
        .replace(queryParameters: queryParameters);

    final response = await http.get(uri);
    debugPrint("----1--------${response.body}----");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      recipes.value = data['recipes'];
      error.value = ''; // Clear error
    } else {
      error.value = 'Failed to fetch recipes'; // Set error message
      Get.snackbar('Error', error.value);
    }
    isLoading.value = false;
  }

  // Search for recipes based on a query
  void searchRecipes(String query) async {
    debugPrint('Searching recipes: $query');
    if (query.isEmpty) {
      fetchRecipes();
      return;
    }

    isLoading.value = true;
    error.value = ''; // Clear error before searching
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
      error.value = ''; // Clear error
    } else {
      error.value = 'Failed to search recipes'; // Set error message
      Get.snackbar('Error', error.value);
    }
    isLoading.value = false;
  }

  // Save a recipe to the Hive box
  Future<void> saveRecipe(Map<dynamic, dynamic> recipe) async {
    debugPrint("recipeeeeee: $recipe");
    var box = await Hive.openBox('meals');
    var mealData = {
      'title': recipe['title'],
      'image': recipe['image'],
      'ingredients': selectedRecipe['ingredients']?.map((ingredient) {
        var name = ingredient['name'];
        var unit = ingredient['unit'];
        // Split name and unit if they are combined
        if (name.contains(':')) {
          var parts = name.split(':');
          name = parts[0];
          unit = parts[1];
        }

        return {
          'name': name,
          'image': ingredient['image'],
          'amount': ingredient['amount'],
          'unit': unit,
          'isPurchased': ingredient['isPurchased'] ?? false,
        };
      }).toList(),
    };
    await box.add(mealData);
    Fluttertoast.showToast(msg: "Meal saved successfully");
    Get.offAll(() => const HomeScreen());
  }

  generateRecipe() {}

  void fetchRecipeIngridients(int recipeId) async {
    isLoading.value = true;
    error.value = ''; // Clear error before fetching
    var queryParameters = {
      'apiKey': HttpUrls.apiKey,
    };
    final uri = Uri.parse(HttpUrls.searchIngredientUrl
            .replaceFirst('{id}', recipeId.toString()))
        .replace(queryParameters: queryParameters);

    try {
      final response = await http.get(uri);
      debugPrint('Response-----------------: ${response.body}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        selectedRecipe.value = data;
        selectedRecipe['ingredients'] = data['ingredients']?.map((ingredient) {
              var name = ingredient['name'];
              var unit = ingredient['amount']['metric']['unit'];
              // Split name and unit if they are combined
              if (name.contains(':')) {
                var parts = name.split(':');
                name = parts[0];
                unit = parts[1];
              }
              return {
                'name': name,
                'image': ingredient['image'],
                'amount': ingredient['amount']['metric']['value'],
                'unit': unit,
              };
            }).toList() ??
            [];
        error.value = ''; // Clear error
      } else {
        error.value = 'Failed to fetch recipe ingredients'; // Set error message
        Get.snackbar('Error', error.value);
      }
    } catch (e) {
      error.value =
          'An error occurred while fetching ingredients'; // Set error message
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  searchRecipesLocally(String value) async {
    // if (value.isEmpty) {
    //   fetchRecipes();
    //   return;
    // }

    var box = await Hive.openBox('meals');
    var localRecipes = box.values.where((recipe) {
      return recipe['title'].toLowerCase().contains(value.toLowerCase());
    }).toList();

    if (localRecipes.isNotEmpty) {
      recipes.value = localRecipes;
    } else {
      searchRecipes(value);
    }
  }
}
