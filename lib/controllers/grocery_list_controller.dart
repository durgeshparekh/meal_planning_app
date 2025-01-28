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

    // fetch the amount value of the groceries and count the same name
    groceryMap.clear();
    for (var grocery in groceries) {
      var name = grocery['name'];
      var amount = grocery['amount'];
      var unit = grocery['unit'] ?? '';
      var isPurchased = grocery['isPurchased'] ?? false;

      // Split name and unit if they are combined
      if (name.contains(':')) {
        var parts = name.split(':');
        name = parts[0];
        unit = parts[1];
      }

      // var key = '$name:$unit'; // Use name and unit as key
      if (groceryMap.containsKey(name)) {
        groceryMap[name]!['amount'] += amount;
      } else {
        groceryMap[name] = {
          'amount': amount,
          'unit': unit,
          'isPurchased': isPurchased
        };
      }
    }

    // merge the grocery data
    groceries.value = groceryMap.entries.map((entry) {
      var nameUnit = entry.key.split(':');
      return {
        'name': nameUnit[0],
        'amount': entry.value['amount'],
        'unit': entry.value['unit'],
        'isPurchased': entry.value['isPurchased']
      };
    }).toList();

  }

  void toggleGrocery(int index, bool value) {
    // checkedValues[index] = value;
    var grocery = groceries[index];
    grocery['isPurchased'] = value;

    // Update the groceries list
    groceries[index] = grocery;
    update(); // Refresh the UI
  }
}
