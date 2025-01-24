import 'package:flutter/material.dart';

class Helpers {
  static void showToast(BuildContext context, String message) {
    debugPrint('🔔 showToast called with message: $message'); // Debug print with emoji
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.teal,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    debugPrint('✅ Toast displayed'); // Debug print with emoji
  }

  static String formatIngredient(String ingredient) {
    debugPrint('🍴 formatIngredient called with ingredient: $ingredient'); // Debug print with emoji
    String formatted = ingredient[0].toUpperCase() + ingredient.substring(1).toLowerCase();
    debugPrint('✅ Ingredient formatted: $formatted'); // Debug print with emoji
    return formatted;
  }
}
