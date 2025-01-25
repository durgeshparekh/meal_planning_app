import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/screens/recipes/search_recipes_screen.dart';
import 'package:meal_planning_app/screens/cart_screen.dart'; // Add import for CartScreen
import '../controllers/home_controller.dart';
import 'recipes/recipe_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the HomeController
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          // Cart button
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
          // Logout button
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              // Handle logout logic
              controller.logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Display welcome message with user's name
          Obx(() => Text(
                'Welcome, ${controller.userName}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: Obx(() {
              var mealsBox = controller.mealsBox.value;
              if (mealsBox.isEmpty) {
                // Display message if no meals are created
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No meals created yet.'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => SearchRecipesScreen());
                        },
                        child: Text('Create your meal'),
                      ),
                    ],
                  ),
                );
              } else {
                // Display grid of meals
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: mealsBox.length,
                  itemBuilder: (context, index) {
                    final meal = mealsBox.getAt(index);
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => RecipeDetailsScreen(recipe: meal));
                      },
                      onLongPress: () {
                        // Show dialog to confirm meal deletion
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Meal'),
                              content: Text(
                                  'Are you sure you want to delete this meal?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.deleteMeal(index);
                                    Get.back();
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display meal image
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15.0)),
                              child: Image.network(
                                meal['image'],
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Display meal title
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                meal['title'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
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
      // Floating action button to add a new meal
      floatingActionButton: Obx(() {
        var mealsBox = controller.mealsBox.value;
        return mealsBox.isEmpty
            ? SizedBox.shrink()
            : FloatingActionButton(
                onPressed: () {
                  // Navigate to search recipes screen
                  Get.to(() => SearchRecipesScreen());
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.add, color: Colors.white),
              );
      }),
      // Removed bottom navigation bar
    );
  }
}

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Screen'),
      ),
      body: Center(
        child: Text('This is an empty screen'),
      ),
    );
  }
}
