import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/providers/game_repository_provider.dart';
import '../../../domain/repository/game_repository.dart';



class GameNotifier extends AsyncNotifier<String> {
  late final GameRepository _repository;

  @override
  Future<String> build() async {
    print("build 실행됨");
    try {
      _repository = ref.read(gameRepositoryProvider);
      print("repository 주입 성공");
    } catch (e) {
      print("에러 발생: $e");
    }

    return "초기 상태";
  }

  Future<void> fetchGameData() async {
    state = const AsyncLoading();

    try {
      await _repository.getSimilarity();
      print("데이터 로드 완료");
      state = const AsyncData("데이터 로드 완료");
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}