class RecordDto {
  final String rank;
  final String elapsedTime;

  RecordDto({
    required this.rank,
    required this.elapsedTime,
  });

  factory RecordDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return RecordDto(
      rank: json['rank'] as String,
      elapsedTime: json['elapsed_time'] as String,
    );
  }
}