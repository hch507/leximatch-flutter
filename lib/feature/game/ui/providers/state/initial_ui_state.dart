import '../../../domain/model/initial_hint_dto.dart';

class InitialHintUiState {
  final InitialHintDto? hintResult;

  const InitialHintUiState({
    this.hintResult,
  });

  InitialHintDto get displayHintResult {
    return hintResult ??
        const InitialHintDto(
          initial: null,
          isSuccess: false,
        );
  }

  InitialHintUiState copyWith({
    InitialHintDto? hintResult,
  }) {
    return InitialHintUiState(
      hintResult: hintResult ?? this.hintResult,
    );
  }
}