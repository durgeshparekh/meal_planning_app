class HttpUrls {
  static const String baseUrl = "https://api.spoonacular.com";
  static const String apiKey = "your_api_key_here";
  static const String searchRecipesUrl = "$baseUrl/recipes/complexSearch";
  static const String randomRecipesUrl = "$baseUrl/recipes/random";
  static const String searchIngredientUrl =
      "$baseUrl/recipes/{id}/ingredientWidget.json";
}
