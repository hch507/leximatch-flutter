import 'package:leximatch/feature/game/domain/model/hint_dto.dart';

class HintUiState {
  final HintDto? hintResult;


  const HintUiState({
    this.hintResult,
  });

  HintDto get displayHintResult {
    return hintResult ??
        HintDto(
          userInput: '-',
          dist: '-',
          ranking: '-',
        );
  }

  HintUiState copyWith({
    HintDto? hintResult,
  }) {
    return HintUiState(
      hintResult: hintResult ?? this.hintResult,
    );
  }
}