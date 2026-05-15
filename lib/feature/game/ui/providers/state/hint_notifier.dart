import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/domain/model/hint_dto.dart';

import '../../../domain/providers/game_repository_provider.dart';
import '../../../domain/repository/game_repository.dart';
import 'hint_ui_state.dart';


//Todo : 중복 호출 관련 로직 수정 필요 ex) _isFetching
class HintNotifier extends AutoDisposeAsyncNotifier<HintUiState> {
  late final GameRepository _repository =
  ref.read(gameRepositoryProvider);
  bool _isFetching = false;
  @override
  Future<HintUiState> build() async {
    return const HintUiState();
  }

  Future<HintDto?> fetchHint() async {

    if (_isFetching) return null;
    _isFetching = true;
    final previous = state.value ?? const HintUiState();

    try {
      final hint = await _repository.fetchHint();

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