class GameDto {
  final String userInput;
  final String dist;
  final String ranking;
  final String elapsedTime;
  final String clearRank;

  GameDto({
    required this.userInput,
    required this.dist,
    required this.ranking,
    required this.elapsedTime,
    required this.clearRank,
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
    );
  }
}