import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/dto/game_dto.dart';
import '../../../domain/providers/game_repository_provider.dart';
import '../../../domain/repository/game_repository.dart';
import 'game_ui_state.dart';



class GameNotifier extends AsyncNotifier<GameUiState> {
  late final GameRepository _repository;

  @override
  Future<GameUiState> build()async {
    print("build 실행됨");

    try {
      _repository = ref.read(gameRepositoryProvider);
      print("repository 주입 성공");
    } catch (e) {
      print("에러 발생: $e");
    }

    return const GameUiState();
  }


  Future<void> fetchSimilarity(String keyword) async {
    final previous = state.value ?? const GameUiState();

    state = const AsyncLoading();

    try {
      final result = await _repository.fetchSimilarity(keyword);

      if (result == null) {
        state = AsyncData(previous);
        return;
      }

      final updatedResults = [
        result,
        ...previous.results,
      ];

      state = AsyncData(
        previous.copyWith(
          myResult: result,
          results: updatedResults,
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

}