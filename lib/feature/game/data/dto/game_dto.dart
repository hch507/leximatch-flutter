class GameDto {
  final String keyword;
  final String userInput;
  final String dist;
  final String ranking;

  GameDto({
    required this.keyword,
    required this.userInput,
    required this.dist,
    required this.ranking,
  });

  factory GameDto.fromJson(Map<String, dynamic> json) {
    return GameDto(
      keyword: json['keyword'],
      userInput: json['userInput'],
      dist: json['dist'] ,
      ranking: json['ranking'],
    );
  }
}