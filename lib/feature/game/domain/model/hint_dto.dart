class HintDto {
  final String userInput;
  final String dist;
  final String ranking;

  HintDto({
    required this.userInput,
    required this.dist,
    required this.ranking,
  });

  factory HintDto.fromJson(Map<String, dynamic> json) {
    return HintDto(
      userInput: json['input'],
      dist: json['dist'] ,
      ranking: json['ranking'],
    );
  }
}