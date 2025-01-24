import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/api/api_client.dart';
import '../data/api/endpoints.dart';

class HomeController extends GetxController {
  var recipes = [].obs;
  var isLoading = false.obs;
  final searchController = ''.obs;

  void fetchRecipes(String query) async {
    try {
      debugPrint('🔍 fetchRecipes called with query: $query'); // Debug print with emoji
      isLoading.value = true;
      final data = await ApiClient().get(Endpoints.searchRecipes, params: {
        'query': query,
        // 'number': 10,
      });
      recipes.value = data['results'];
      debugPrint('✅ Recipes fetched successfully'); // Debug print with emoji
    } catch (e) {
      debugPrint('❌ Error fetching recipes: $e'); // Debug print with emoji
      Get.snackbar('Error', 'Failed to fetch recipes');
    } finally {
      isLoading.value = false;
      debugPrint('🔄 isLoading set to false'); // Debug print with emoji
    }
  }
}
