import '../../../data/dto/game_dto.dart';


class GameUiState {
  final GameDto? myResult;
  final List<GameDto> results;

  const GameUiState({
    this.myResult,
    this.results = const [],
  });

  GameDto get displayMyResult {
    return myResult ??
        GameDto(
          userInput: '-',
          dist: '-',
          ranking: '-',
          elapsedTime: "-"
        );
  }

  List<GameDto> get top5 {
    final sorted = [...results]
      ..sort((a, b) {
        final aDist = double.tryParse(a.dist.toString()) ?? 0;
        final bDist = double.tryParse(b.dist.toString()) ?? 0;

        return bDist.compareTo(aDist); // 높은 유사도 먼저
      });

    return sorted.take(5).toList();
  }
  GameUiState copyWith({
    GameDto? myResult,
    List<GameDto>? results,
  }) {
    return GameUiState(
      myResult: myResult ?? this.myResult,
      results: results ?? this.results,
    );
  }
}