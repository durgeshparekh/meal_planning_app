import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // Add this import for debugPrint

class ApiClient {
  static const String baseUrl = "https://api.spoonacular.com";
  static const String apiKey = "eeb51b87ede548d7b18b0ccef9d845e4";

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    debugPrint('$baseUrl$endpoint');

// Ensure params is not null and add the apiKey
    final queryParams = {
      'apiKey': apiKey,
      ...?params,
    };

    final uri =
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);

    // final uri = Uri.parse(
    //     "https://api.spoonacular.com/recipes/complexSearch?apiKey=eeb51b87ede548d7b18b0ccef9d845e4&query=paneer&cuisine=indian");

    debugPrint('🚀 Sending GET request to: $uri');

    try {
      final response = await http.get(uri);

      debugPrint(
          '📬 Received response with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('✅ Request successful');
        return json.decode(response.body);
      } else {
        debugPrint('❌ Failed to load data: ${response.reasonPhrase}');
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('⚠️ Error occurred while fetching data: $e');
      throw Exception('Error occurred while fetching data: $e');
    }
  }
}
