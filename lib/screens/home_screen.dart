import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'recipe_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: Text('Recipe Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.searchController.value = value,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () =>
                controller.fetchRecipes(controller.searchController.value),
            child: Text('Search'),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.recipes.isEmpty) {
                return Center(child: Text('No recipes found'));
              } else {
                return ListView.builder(
                  itemCount: controller.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = controller.recipes[index];
                    return ListTile(
                      leading:
                          Image.network(recipe['image'], fit: BoxFit.cover),
                      title: Text(recipe['title']),
                      onTap: () {
                        Get.to(() => RecipeDetailsScreen(recipe: recipe));
                      },
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
