import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_assessment/core/utils/api_response.dart';
import 'package:flutter_assessment/features/profile/models/user_model.dart';
import "package:http/http.dart" as http;

class UserService {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<ApiResult<int>> submitUserData({required UserModel body}) async {
    try {
      final response = await http
          .post(
            Uri.parse(_baseUrl),
            headers: {"Content-Type": "application/json"},
            body: json.encode(body.toJson()),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw TimeoutException('Request timed out'),
          );
      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final result = ProfileResponse.fromJson(jsonResponse);
        return ApiResult.success(result.id);
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
