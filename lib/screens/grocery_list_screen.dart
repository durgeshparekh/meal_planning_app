import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/controllers/grocery_list_controller.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroceryListController controller = Get.put(GroceryListController());
    controller.fetchGroceries();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Grocery List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (controller.groceries.isEmpty) {
          // Show a message if no groceries are found
          return Center(child: Text('No groceries found 🛒'));
        } else {
          // Display the grocery list in a scrollable table
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 30.0,
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Purchased')),
                  ],
                  rows: controller.groceries.map((grocery) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: BoxConstraints(
                              minHeight: double.infinity,
                            ),
                            child: Text(
                              grocery['name'][0].toUpperCase() +
                                  grocery['name'].substring(1),
                              maxLines: null,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: BoxConstraints(
                              minHeight: double.infinity,
                            ),
                            child:
                                Text('${grocery['amount']} ${grocery['unit']}'),
                          ),
                        ),
                        DataCell(
                          Checkbox(
                            value: grocery['isPurchased'],
                            activeColor: Theme.of(context).secondaryHeaderColor,
                            onChanged: (bool? value) {
                              // Handle checkbox change
                              int index = controller.groceries.indexOf(grocery);
                              controller.toggleGrocery(index, value!);
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
