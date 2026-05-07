import '../common/result.dart';

class ApiException implements Exception {
  final int resultCode;
  final String message;
  final String? description;

  const ApiException({
    required this.resultCode,
    required this.message,
    this.description,
  });

  factory ApiException.fromResult(Result result) {
    return ApiException(
      resultCode: result.resultCode,
      message: result.resultMessage,
      description: result.resultDescription,
    );
  }
}