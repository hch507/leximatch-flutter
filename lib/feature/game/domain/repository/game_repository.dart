

import 'package:leximatch/feature/game/data/dto/game_dto.dart';

abstract class GameRepository {
  Future<GameDto?> fetchSimilarity(String keyword);
}