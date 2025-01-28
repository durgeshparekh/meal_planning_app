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
        title: Text('Grocery List'),
      ),
      body: Obx(() {
        if (controller.groceryMap.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return DataTable(
            columns: [
              DataColumn(label: Text('Grocery Name')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Purchased')),
            ],
            rows: controller.groceryMap.entries.expand((entry) {
              debugPrint('Entry: $entry');
              final groceryName = entry.key;
              final ingredientsList = entry.value as List<Map<String, dynamic>>;
              return ingredientsList.map((ingredient) {
                return DataRow(
                  cells: [
                    DataCell(Text(groceryName as String)),
                    DataCell(
                        Text('${ingredient['amount']} ${ingredient['unit']}')),
                    DataCell(
                      Checkbox(
                        value: ingredient['purchased'] as bool? ?? false,
                        onChanged: (bool? value) {
                          // controller.toggleGrocery(groceryName, ingredient);
                        },
                      ),
                    ),
                  ],
                );
              }).toList();
            }).toList(),
          );
        }
      }),
    );
  }
}
