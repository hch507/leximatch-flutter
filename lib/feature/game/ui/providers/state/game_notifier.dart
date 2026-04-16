import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/dto/game_dto.dart';
import '../../../domain/providers/game_repository_provider.dart';
import '../../../domain/repository/game_repository.dart';



class GameNotifier extends AsyncNotifier<List<GameDto?>> {
  late final GameRepository _repository;

  @override
  Future<List<GameDto?>> build()async {
    print("build 실행됨");

    try {
      _repository = ref.read(gameRepositoryProvider);
      print("repository 주입 성공");
    } catch (e) {
      print("에러 발생: $e");
    }

    return [];
  }

  Future<void> fetchSimilarity(String keyword) async {
    state = const AsyncLoading();
    final currentList = state.value ?? [];
    try {
      final result = await _repository.fetchSimilarity(keyword);

      print("데이터 로드 완료: ${result?.dist}");


      final updatedList = [result,...currentList];

      state = AsyncData(updatedList);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}