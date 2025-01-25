import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: () async {
              try {
                controller.resetGroceryList();
                showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Reset'),
                      content: Text('Grocery list has been reset.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                Get.snackbar('Error', e.toString());
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        var ingredients = controller.ingredientsList;
        if (ingredients.isEmpty) {
          return Center(
            child: Text('Your cart is empty.'),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = ingredients[index];
                    return Obx(() => ListTile(
                          title: Text(ingredient['name'] ?? 'Unknown'),
                          subtitle: Text('Quantity: ${ingredient['quantity'] ?? 'Unknown'}'),
                          trailing: Checkbox(
                            value: controller.selectedGroceries
                                .contains(ingredient),
                            onChanged: (bool? value) {
                              if (value == true) {
                                controller.selectGrocery(index);
                              } else {
                                controller.deselectGrocery(index);
                              }
                            },
                            activeColor:
                                Colors.blue, // Customize the checkbox color
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(ingredient['name'] ?? 'Unknown'),
                                  content: Text(
                                      'Quantity: ${ingredient['quantity'] ?? 'Unknown'}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await controller.buySelectedGroceries();
                      showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content:
                                Text('Selected groceries bought and stored.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      Get.snackbar('Error', e.toString());
                    }
                  },
                  child: Text('Buy Selected Groceries'),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
