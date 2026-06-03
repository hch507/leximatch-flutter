

import 'package:leximatch/core/network/common/result.dart';

class ApiResponse<T> {
  final Result result;
  final T? body; // 데이터가 없을 수도 있으므로 nullable 처리

  ApiResponse({required this.result, this.body});

  // json과 해당 body를 파싱할 함수를 함께 전달받습니다.
  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT
      ) {
    return ApiResponse<T>(
      result: Result.fromJson(json['result']),
      body: json['body'] != null ? fromJsonT(json['body']) : null,
    );
  }
}
