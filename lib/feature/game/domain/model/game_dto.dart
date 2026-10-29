class GameDto {
  final String userInput;
  final String dist;
  final String ranking;
  final String elapsedTime;
  final String clearRank;
  final String timeScore;
  final String rankScore;

  GameDto({
    required this.userInput,
    required this.dist,
    required this.ranking,
    required this.elapsedTime,
    required this.clearRank,
    required this.timeScore,
    required this.rankScore,
  });

  factory GameDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return GameDto(
      userInput: json['input'],
      dist: json['dist'] ,
      ranking: json['ranking'],
      elapsedTime: json['elapsed_time'] as String,
      clearRank: json['clear_rank']as String,
      timeScore: json['time_score']as String,
      rankScore: json['rank_score']as String,
    );
  }
}