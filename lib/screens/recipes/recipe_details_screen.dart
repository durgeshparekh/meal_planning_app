import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/controllers/recipe_details_controller.dart';
import 'package:meal_planning_app/screens/grocery_list_screen.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Map<dynamic, dynamic> recipe;
  final bool shouldFetchIngridients;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
    this.shouldFetchIngridients = true,
  });

  @override
  Widget build(BuildContext context) {
    final RecipeDetailsController controller =
        Get.put(RecipeDetailsController(showFetchRecipes: false));

    debugPrint('RecipeDetailsScreen: ${recipe['id']}, $shouldFetchIngridients');

    if (shouldFetchIngridients) {
      debugPrint(
          "Fetching recipe ingredients---: $recipe, id: ${recipe['id']}");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchRecipeIngridients(recipe['id']);
      });
    } else {
      controller.selectedRecipe.value = recipe;
      controller.isLoading.value = false;
    }

    List<bool> checkedValues =
        List<bool>.filled(recipe['ingredients']?.length ?? 0, false);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  _buildIngredientsHeader(controller, checkedValues),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.error.value.isNotEmpty) {
                      return Center(child: Text('Error fetching ingredients'));
                    } else {
                      return _buildIngredientsList(controller);
                    }
                  }),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the SliverAppBar with a flexible space bar
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double appBarHeight = constraints.biggest.height;
          final bool isExpanded = appBarHeight > kToolbarHeight + 50;

          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              opacity: isExpanded ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Container(
                color: isExpanded
                    ? Colors.black.withOpacity(0.5)
                    : Colors.transparent,
                child: Text(
                  recipe['title'] ?? 'No Title',
                  style: TextStyle(
                    color: isExpanded ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  recipe['image'] ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Image not available'));
                  },
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  // Build the header for the ingredients section
  Row _buildIngredientsHeader(
      RecipeDetailsController controller, List<bool> checkedValues) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        shouldFetchIngridients
            ? _buildSaveButton(controller)
            : const SizedBox(),
      ],
    );
  }

  // Build the save button
  InkWell _buildSaveButton(RecipeDetailsController controller) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        debugPrint('Save recipe: $recipe');
        debugPrint('ingrideints recipe: ${controller.selectedRecipe}');
        await controller.saveRecipe(recipe);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
          color: Colors.white,
        ),
        child: Icon(Icons.save, color: Colors.black),
      ),
    );
  }

  // Build the grocery list button
  InkWell _buildGroceryListButton(List<bool> checkedValues) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        // Navigate to GroceryListScreen
        Get.to(() => GroceryListScreen());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
          color: Colors.white,
        ),
        child: Text(
          "Check Grocery List",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  // Build the ingredients list
  SizedBox _buildIngredientsList(RecipeDetailsController controller) {
    debugPrint('Building ingredients list: $recipe,');
    return SizedBox(
      height: (controller.selectedRecipe['ingredients']?.length ?? 0) * 70.0,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.selectedRecipe['ingredients']?.length ?? 0,
        itemBuilder: (context, index) {
          final ingredient = controller.selectedRecipe['ingredients'][index];

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${ingredient['name'] ?? 'Unknown'}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' - ${ingredient['amount'] ?? ''} ${ingredient['unit'] ?? ''}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
