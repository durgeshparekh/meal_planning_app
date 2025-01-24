import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeDetailsController extends GetxController {
  var selectedRecipe = {}.obs;

  void setRecipe(Map<String, dynamic> recipe) {
    debugPrint('🍲 setRecipe called with recipe: $recipe'); // Debug print with emoji
    selectedRecipe.value = recipe;
    debugPrint('✅ Recipe set successfully'); // Debug print with emoji
  }
}
