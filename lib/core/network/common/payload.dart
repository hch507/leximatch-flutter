import 'api_error.dart';

class Payload<T> {
  final T? data;
  final ApiError? error;

  Payload({this.data, this.error});

  factory Payload.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) {
    return Payload(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      error: json['error'] != null
          ? ApiError.fromJson(json['error'])
          : null,
    );
  }
}