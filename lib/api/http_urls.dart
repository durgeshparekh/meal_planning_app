class HttpUrls {
  static const String baseUrl = "https://api.spoonacular.com";
  static const String apiKey = "9e3bb0319fe24deb95897db34298d1ba";

  static const String searchRecipesUrl = "$baseUrl/recipes/complexSearch";
  static const String randomRecipesUrl = "$baseUrl/recipes/random";
  static const String searchIngredientUrl =
      "$baseUrl/recipes/{id}/ingredientWidget.json";
}
