class InitialHintDto {
  final String? initial;
  final bool isSuccess;

  const InitialHintDto({
    required this.initial,
    required this.isSuccess,
  });

  factory InitialHintDto.fromJson(Map<String, dynamic> json) {
    return InitialHintDto(
      initial: json['initial'] as String?,
      isSuccess: json['isSuccess'] as bool,
    );
  }
}