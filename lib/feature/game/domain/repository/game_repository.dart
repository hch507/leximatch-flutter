
import '../model/game_dto.dart';
import '../model/hint_dto.dart';

abstract class GameRepository {
  Future<GameDto?> fetchSimilarity(String keyword);

  Future<HintDto?> fetchHint();
}