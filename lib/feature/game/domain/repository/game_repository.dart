
import 'package:leximatch/feature/game/domain/model/initial_hint_dto.dart';

import '../model/game_dto.dart';
import '../model/hint_dto.dart';

abstract class GameRepository {
  Future<GameDto?> fetchSimilarity(String keyword);

  Future<HintDto?> fetchHint();

  Future<HintDto?> fetchOpeningHint();

  Future<InitialHintDto> fetchInitialHint();
}