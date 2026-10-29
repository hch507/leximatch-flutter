class MonthlyRecordDto {
  final int rank;
  final int totalScore;

  MonthlyRecordDto({
    required this.rank,
    required this.totalScore,
  });

  factory MonthlyRecordDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return MonthlyRecordDto(
      rank: (json['rank'] as num?)!.toInt(),
      totalScore: (json['total_score'] as num).toInt(),
    );
  }
}