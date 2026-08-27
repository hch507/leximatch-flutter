import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/initial_hint_dto.dart';
import '../../../domain/providers/game_repository_provider.dart';
import '../../../domain/repository/game_repository.dart';
import 'initial_ui_state.dart';

class InitialHintNotifier extends AutoDisposeAsyncNotifier<InitialHintUiState> {
  late final GameRepository _repository = ref.read(gameRepositoryProvider);

  bool _isFetching = false;

  @override
  Future<InitialHintUiState> build() async {
    return const InitialHintUiState();
  }

  Future<InitialHintDto?> fetchInitialHint() async {
    if (_isFetching) return null;

    _isFetching = true;

    final previous = state.value ?? const InitialHintUiState();

    try {
      final hint = await _repository.fetchInitialHint();

      if (hint == null) {
        state = AsyncData(previous);
        return null;
      }

      state = AsyncData(
        previous.copyWith(
          hintResult: hint,
        ),
      );

      return hint;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    } finally {
      _isFetching = false;
    }
  }
}
