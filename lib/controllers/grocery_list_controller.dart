import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryListController extends GetxController {
  var groceryList = <String>[].obs;

  // Add an item to the grocery list if it doesn't already exist
  void addItem(String item) {
    debugPrint('addItem called with item: $item');
    if (!groceryList.contains(item)) {
      groceryList.add(item);
      debugPrint('Item added: $item');
    } else {
      debugPrint('Item already in list: $item');
    }
  }

  // Remove an item from the grocery list
  void removeItem(String item) {
    debugPrint('removeItem called with item: $item');
    groceryList.remove(item);
    debugPrint('Item removed: $item');
  }

  // Mark an item as purchased and show a snackbar notification
  void markAsPurchased(String item) {
    debugPrint('markAsPurchased called with item: $item');
    Get.snackbar('Purchased', '$item marked as purchased');
  }
}
