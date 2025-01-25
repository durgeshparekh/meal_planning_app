import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/controllers/recipe_details_controller.dart';
import 'package:meal_planning_app/utils/widgets/rounded_text_form_field.dart';
import 'package:meal_planning_app/screens/recipes/recipe_details_screen.dart';

class SearchRecipesScreen extends StatelessWidget {
  final bool shouldFetchRecipes; // Add this line

  const SearchRecipesScreen({super.key, this.shouldFetchRecipes = true}); // Modify constructor

  @override
  Widget build(BuildContext context) {
    final RecipeDetailsController controller =
        Get.put(RecipeDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add recipes',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedTextFormField(
                hintText: 'Search Recipes',
                onChanged: (value) {
                  controller.searchRecipes(value);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.recipes.isEmpty) {
                  return Center(child: Text('No recipes found.'));
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                    ),
                    itemCount: controller.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = controller.recipes[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => RecipeDetailsScreen(recipe: recipe, shouldFetchRecipes: shouldFetchRecipes)); // Pass shouldFetchRecipes
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: recipe['image'] != null
                                        ? Image.network(
                                            recipe['image'],
                                            fit: BoxFit.cover,
                                          )
                                        : Container(color: Colors.grey),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.black54,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      recipe['title'] ?? 'No title',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
