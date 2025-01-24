import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_details_controller.dart';
import '../controllers/grocery_list_controller.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipeDetailsController recipeController =
      Get.put(RecipeDetailsController());
  final GroceryListController groceryController = Get.put(GroceryListController());

  RecipeDetailsScreen({super.key, required Map<String, dynamic> recipe}) {
    recipeController.setRecipe(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(recipeController.selectedRecipe['title'] ?? '')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(recipeController.selectedRecipe['image'],
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Ready in ${recipeController.selectedRecipe['readyInMinutes']} mins',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                groceryController
                    .addItem(recipeController.selectedRecipe['title']);
                Get.back(result: recipeController.selectedRecipe['title']);
              },
              child: Text('Add to Grocery List'),
            ),
          ),
        ],
      ),
    );
  }
}
