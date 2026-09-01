import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/hint_dto.dart';
import '../../../domain/providers/game_repository_provider.dart';
import '../../../domain/repository/game_repository.dart';
import 'hint_ui_state.dart';

class OpeningHintNotifier extends AutoDisposeAsyncNotifier<HintUiState> {
  late final GameRepository _repository =
  ref.read(gameRepositoryProvider);
  bool _isFetching = false;
  @override
  Future<HintUiState> build() async {
    return const HintUiState();
  }

  Future<HintDto?> fetchOpeningHint() async {

    if (_isFetching) return null;
    _isFetching = true;
    final previous = state.value ?? const HintUiState();

    try {
      final hint = await _repository.fetchOpeningHint();

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