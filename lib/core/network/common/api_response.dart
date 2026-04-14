import 'package:leximatch/core/network/common/payload.dart';

class ApiResponse<T> {
  final String resultCode;
  final String resultMsg;
  final Payload<T> payload;

  ApiResponse({
    required this.resultCode,
    required this.resultMsg,
    required this.payload,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return ApiResponse(
      resultCode: json['resultCode'],
      resultMsg: json['resultMsg'],
      payload: Payload<T>.fromJson(
        json['payload'],
        fromJsonT,
      ),
    );
  }
}
