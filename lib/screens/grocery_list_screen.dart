import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/grocery_list_controller.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroceryListController controller = Get.put(GroceryListController());

    return Scaffold(
      appBar: AppBar(title: Text('Grocery List')),
      body: Obx(() {
        if (controller.groceryList.isEmpty) {
          return Center(child: Text('No items in the grocery list.'));
        } else {
          return ListView.builder(
            itemCount: controller.groceryList.length,
            itemBuilder: (context, index) {
              final item = controller.groceryList[index];
              return ListTile(
                title: Text(item),
                trailing: IconButton(
                  icon: Icon(Icons.check_circle),
                  onPressed: () => controller.markAsPurchased(item),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
