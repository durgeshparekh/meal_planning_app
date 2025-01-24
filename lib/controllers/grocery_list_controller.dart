import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryListController extends GetxController {
  var groceryList = <String>[].obs;

  void addItem(String item) {
    debugPrint('🛒 addItem called with item: $item'); // Debug print with emoji
    if (!groceryList.contains(item)) {
      groceryList.add(item);
      debugPrint('✅ Item added: $item'); // Debug print with emoji
    } else {
      debugPrint('⚠️ Item already in list: $item'); // Debug print with emoji
    }
  }

  void removeItem(String item) {
    debugPrint('🗑️ removeItem called with item: $item'); // Debug print with emoji
    groceryList.remove(item);
    debugPrint('✅ Item removed: $item'); // Debug print with emoji
  }

  void markAsPurchased(String item) {
    debugPrint('✅ markAsPurchased called with item: $item'); // Debug print with emoji
    // Optional: Handle purchase state logic
    Get.snackbar('Purchased', '$item marked as purchased');
  }
}
