
import '../../../domain/model/game_dto.dart';


class GameUiState {
  final GameDto? myResult;
  final List<GameDto> results;
  final bool isWordNotFound;

  const GameUiState({
    this.myResult,
    this.results = const [],
    this.isWordNotFound = false,
  });

  GameDto get displayMyResult {
    return myResult ??
        GameDto(
          userInput: '-',
          dist: '-',
          ranking: '-',
          elapsedTime: "-",
          clearRank: "-"
        );
  }

  List<GameDto> get top5 {
    final sorted = [...results]
      ..sort((a, b) {
        final aDist = double.tryParse(a.dist.toString()) ?? 0;
        final bDist = double.tryParse(b.dist.toString()) ?? 0;

        return bDist.compareTo(aDist);
      });

    return sorted.take(5).toList();
  }

  GameUiState copyWith({
    GameDto? myResult,
    List<GameDto>? results,
    bool? isWordNotFound, //
  }) {
    return GameUiState(
      myResult: myResult ?? this.myResult,
      results: results ?? this.results,
      isWordNotFound: isWordNotFound ?? this.isWordNotFound,
    );
  }
}