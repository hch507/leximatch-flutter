import 'package:dio/dio.dart';

import '../exception/api_exception.dart';
import 'api_response.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<T?> request<T>(
      String path, {
        required String method,
        dynamic data,
        Map<String, dynamic>? queryParameters,
        required T Function(dynamic json) fromJson,
      }) async {
    try {
      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      return _parseResponse<T>(response.data, fromJson);
    } on DioException catch (e) {
      final errorData = e.response?.data;

      if (errorData is Map<String, dynamic>) {
        _throwApiException(errorData);
      }

      throw ApiException(
        resultCode: e.response?.statusCode ?? 500,
        message: '네트워크 오류가 발생했습니다.',
      );
    }
  }

  T? _parseResponse<T>(
      dynamic data,
      T Function(dynamic json) fromJson,
      ) {
    final apiResponse = ApiResponse<T>.fromJson(data, fromJson);

    if (apiResponse.result.resultCode == 200) {
      return apiResponse.body;
    }

    throw ApiException.fromResult(apiResponse.result);
  }

  Never _throwApiException(Map<String, dynamic> data) {
    final apiResponse = ApiResponse<dynamic>.fromJson(
      data,
          (json) => json,
    );

    throw ApiException.fromResult(apiResponse.result);
  }
}