import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/controllers/recipe_details_controller.dart';
import 'package:meal_planning_app/utils/widgets/custom_button.dart'; // Import the controller

class RecipeDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    if (recipe == null || recipe.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Recipe Details'),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Text('Recipe not found.'),
        ),
      );
    }

    debugPrint('🍲 Recipe: ${recipe['extendedIngredients']}');

    final RecipeDetailsController controller =
        Get.put(RecipeDetailsController());
    controller.fetchRecipes();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                          color: isExpanded
                              ? Colors.white
                              : Colors.black, // Change color based on expansion
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0, // Reduced font size
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
                      Positioned(
                        top: 16.0,
                        right: 16.0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () async {
                            await controller.saveRecipe(recipe);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(),
                              color: Colors.white,
                            ),
                            child: Icon(Icons.save, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            backgroundColor:
                Colors.transparent, // Remove background color from AppBar
            iconTheme: IconThemeData(color: Colors.black),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  SizedBox(
                    height: (recipe['extendedIngredients']?.length ?? 0) *
                        40.0, // Adjust height dynamically
                    child: ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling
                      itemCount: recipe['extendedIngredients']?.length ?? 0,
                      itemBuilder: (context, index) {
                        final ingredient = recipe['extendedIngredients'][index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ', style: TextStyle(fontSize: 16.0)),
                              Expanded(
                                child: Text(
                                  '${ingredient['name'] ?? 'Unknown'} - ${ingredient['amount'] ?? ''} ${ingredient['unit'] ?? ''}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey, // Add border color
                        width: 1.0, // Add border width
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              8.0), // Add padding inside the container
                          child: Text(
                            recipe['summary'] ?? 'No summary available',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CustomButton(
                    text: "Save this Receipe",
                    press: () async {
                      await controller.saveRecipe(recipe);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
