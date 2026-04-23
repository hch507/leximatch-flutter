class Result {
  final int resultCode;
  final String resultMessage;
  final String resultDescription;

  Result({
    required this.resultCode,
    required this.resultMessage,
    required this.resultDescription,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      resultDescription: json['resultDescription'],
    );
  }
}