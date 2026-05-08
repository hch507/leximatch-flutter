import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/network/exception/api_exception.dart';
import '../../../data/dto/game_dto.dart';
import '../../../domain/providers/game_repository_provider.dart';
import '../../../domain/repository/game_repository.dart';
import 'game_ui_state.dart';



class GameNotifier extends AutoDisposeAsyncNotifier<GameUiState> {
  late final GameRepository _repository =
  ref.read(gameRepositoryProvider);

  @override
  Future<GameUiState> build() async {

    return const GameUiState();
  }


  Future<void> fetchSimilarity(String keyword) async {
    if (state.isLoading) return;
    final previous = state.value ?? const GameUiState();

    state = const AsyncLoading<GameUiState>().copyWithPrevious(
      AsyncData(previous),
    );

    try {
      final result = await _repository.fetchSimilarity(keyword);

      if (result == null) {
        state = AsyncData(previous);
        return;
      }

      final updatedResults = [
        result,
        ...previous.results.where(
              (e) => e.userInput != result.userInput,
        ),
      ];

      state = AsyncData(
        previous.copyWith(
          myResult: result,
          results: updatedResults,
          isWordNotFound: false,
        ),
      );
    } catch (e, st) {
      print("------------------------------에러 발생: $e, $st");
      if (e is ApiException && e.resultCode == 6001) {
        state = AsyncData(
          previous.copyWith(
            isWordNotFound: true,
          ),
        );
        return;
      }
      state = AsyncError(e, st);
    }
  }

}