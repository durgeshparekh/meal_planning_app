import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/grocery_list_controller.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View your grocery list'),
      ),
      body: Center(
        child: Text('Grocery List Screen'),
      ),
    );
  }
}
