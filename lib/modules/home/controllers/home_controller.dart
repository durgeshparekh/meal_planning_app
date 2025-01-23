import 'package:get/get.dart';

class HomeController extends GetxController {
  // Reactive variables
  var recipes = [].obs;
  var isLoading = false.obs;

  // Fetch recipes (example method)
  Future<void> fetchRecipes(String query) async {
    try {
      isLoading.value = true;
      // Call API (to be implemented)
      await Future.delayed(Duration(seconds: 2)); // Simulate delay
      recipes.value = []; // Assign API response here
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch recipes');
    } finally {
      isLoading.value = false;
    }
  }
}
