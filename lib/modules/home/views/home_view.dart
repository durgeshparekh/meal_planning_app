import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/recipe_card.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) => controller.fetchRecipes(query),
            ),
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
                    return RecipeCard(recipe: controller.recipes[index]);
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
