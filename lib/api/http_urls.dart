class HttpUrls {
  static const String baseUrl = "https://api.spoonacular.com";
  static const String apiKey = "00f58d35886a4d21af943d2cde0da7f4";

  static const String searchRecipesUrl = "$baseUrl/recipes/complexSearch";
  static const String randomRecipesUrl = "$baseUrl/recipes/random";
  static const String searchIngredientUrl =
      "$baseUrl/recipes/{id}/ingredientWidget.json";
}
