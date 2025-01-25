import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CartController extends GetxController {
  var ingredientsList = <Map<String, dynamic>>[].obs;
  var selectedGroceries = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchIngredients();
    fetchPurchasedGroceries();
  }

  // Fetch ingredients from the Hive box and populate the ingredientsList
  void fetchIngredients() {
    try {
      var mealsBox = Hive.box('meals');
      var ingredientsMap = <String, Map<String, dynamic>>{};

      if (mealsBox.isEmpty) {
        ingredientsList.clear();
        return;
      }

      for (var i = 0; i < mealsBox.length; i++) {
        var meal = mealsBox.getAt(i);
        var ingredients = meal['extendedIngredients'] ?? [];

        for (var ingredient in ingredients) {
          var name = ingredient['name'];
          var quantity = ingredient['amount'];

          if (name == null || quantity == null) {
            throw Exception('Ingredient name or quantity is null');
          }

          if (ingredientsMap.containsKey(name)) {
            ingredientsMap[name]!['quantity'] += quantity;
          } else {
            ingredientsMap[name] = {
              'name': name,
              'quantity': quantity,
            };
          }
        }
      }

      // Convert quantities to whole numbers
      ingredientsList.value = ingredientsMap.values.map((ingredient) {
        ingredient['quantity'] = ingredient['quantity'].round();
        return ingredient;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Fetch purchased groceries from the Hive box and populate the selectedGroceries list
  void fetchPurchasedGroceries() async {
    try {
      var groceryBox = await Hive.openBox('groceries');
      var purchasedGroceries =
          groceryBox.values.where((g) => g['isPurchased'] == true).toList();
      if (purchasedGroceries.isNotEmpty) {
        selectedGroceries.value =
            List<Map<String, dynamic>>.from(purchasedGroceries);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Increase the quantity of an ingredient
  void increaseQuantity(int index) {
    ingredientsList[index]['quantity'] += 1;
    ingredientsList.refresh();
  }

  // Decrease the quantity of an ingredient
  void decreaseQuantity(int index) {
    if (ingredientsList[index]['quantity'] > 1) {
      ingredientsList[index]['quantity'] -= 1;
      ingredientsList.refresh();
    }
  }

  // Buy all groceries and clear the ingredients list
  Future<void> buyGroceries() async {
    var groceryBox = await Hive.openBox('groceries');
    for (var ingredient in ingredientsList) {
      groceryBox.add(ingredient);
    }
    ingredientsList.clear();
    Get.back();
  }

  // Select a grocery item
  void selectGrocery(int index) {
    selectedGroceries.add(ingredientsList[index]);
    selectedGroceries.refresh();
  }

  // Deselect a grocery item
  void deselectGrocery(int index) {
    selectedGroceries.remove(ingredientsList[index]);
    selectedGroceries.refresh();
  }

  // Buy selected groceries and mark them as purchased
  Future<void> buySelectedGroceries() async {
    try {
      var groceryBox = await Hive.openBox('groceries');
      for (var ingredient in selectedGroceries) {
        ingredient['isPurchased'] = true;
        groceryBox.add(ingredient);
      }
      selectedGroceries.clear();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Reset the grocery list by clearing the Hive box and fetching ingredients again
  void resetGroceryList() async {
    try {
      var groceryBox = await Hive.openBox('groceries');
      groceryBox.clear();
      fetchIngredients();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Delete a meal and update the ingredients list accordingly
  void deleteMeal(int mealIndex) {
    try {
      var mealsBox = Hive.box('meals');
      var meal = mealsBox.getAt(mealIndex);
      var ingredients = meal['extendedIngredients'] ?? [];

      for (var ingredient in ingredients) {
        var name = ingredient['name'];
        var quantity = ingredient['amount'];

        if (name == null || quantity == null) {
          throw Exception('Ingredient name or quantity is null');
        }

        var groceryIndex = ingredientsList.indexWhere((g) => g['name'] == name);
        if (groceryIndex != -1) {
          ingredientsList[groceryIndex]['quantity'] -= quantity;
          if (ingredientsList[groceryIndex]['quantity'] <= 0) {
            ingredientsList.removeAt(groceryIndex);
          }
        }
      }

      mealsBox.deleteAt(mealIndex);
      ingredientsList.refresh();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
