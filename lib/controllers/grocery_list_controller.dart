import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_planning_app/utils/box_name.dart';

class GroceryListController extends GetxController {
  var groceries = [].obs;
  var checkedValues = <bool>[].obs;
  var mealsBox = Hive.box(BoxName.mealsBox);
  var groceryMap = <String, Map<String, dynamic>>{};

  @override
  void onInit() {
    super.onInit();
    fetchGroceries();
  }

  void fetchGroceries() {
    groceries.value = mealsBox.values
        .map((recipe) => recipe['ingredients'])
        .expand((ingredients) => ingredients)
        .toList();

    // sort grocery list based on same name
    groceries.sort((a, b) => a['name'].compareTo(b['name']));

    debugPrint('Groceries------>: $groceries');
    var data = [];

    // fetch the amount value of the groceries and count the same name
    for (var grocery in groceries) {
      var name = grocery['name'];
      var amount = grocery['amount'];
      var isPurchased = grocery['isPurchased'] ?? false;
      if (groceryMap.containsKey(name)) {
        groceryMap[name]!['amount'] += amount;
      } else {
        groceryMap[name] = {'amount': amount, 'isPurchased': isPurchased};
      }
      data.add({groceryMap[name]});
    }

    // debugPrint('GroceryMap-----: $data');

    // print all data of grocery Map
    for (var key in data) {
      debugPrint('Grocery-------: $key');
    }
  }

  void toggleGrocery(int index, bool value) async {
    checkedValues[index] = value;
    if (value) {
      mealsBox.add(groceries[index]);
    } else {
      var key = mealsBox.keys.firstWhere(
          (k) => mealsBox.get(k) == groceries[index],
          orElse: () => null);
      if (key != null) {
        mealsBox.delete(key);
      }
    }
  }
}
