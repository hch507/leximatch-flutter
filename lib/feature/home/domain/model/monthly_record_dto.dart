class MonthlyRecordDto {
  final int rank;
  final int score;

  MonthlyRecordDto({
    required this.rank,
    required this.score,
  });

  factory MonthlyRecordDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return MonthlyRecordDto(
      rank: json['rank'] as int,
      score: json['score'] as int,
    );
  }
}