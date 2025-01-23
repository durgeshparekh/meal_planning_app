import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(
          headers: {'Authorization': 'Bearer eeb51b87ede548d7b18b0ccef9d845e4'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
