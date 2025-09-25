import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_assessment/core/utils/api_response.dart';
import 'package:flutter_assessment/features/images/models/image_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RetrieveImagesDataService {
  static const String _baseUrl = "https://pixabay.com/api/";
  static const int _perPage = 10;

  Future<ApiResult<ImagesApiResponseModel>> fetchImages({
    int page = 1,
    String query = 'popular',
  }) async {
    try {
      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'key': dotenv.env["PIXABY_API_KEY"],
          'q': query,
          'page': page.toString(),
          'per_page': _perPage.toString(),
          'image_type': 'photo',
          'safesearch': 'true',
        },
      );

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw TimeoutException('Request timed out'),
          );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final result = ImagesApiResponseModel.fromJson(jsonResponse);
        return ApiResult.success(result);
      } else {
        return ApiResult.failure('Server error: ${response.statusCode}');
      }
    } on SocketException {
      return ApiResult.failure('No internet connection');
    } on TimeoutException {
      return ApiResult.failure('Request timed out');
    } on FormatException {
      return ApiResult.failure('Invalid response format');
    } catch (e) {
      return ApiResult.failure('Unexpected error: ${e.toString()}');
    }
  }
}
