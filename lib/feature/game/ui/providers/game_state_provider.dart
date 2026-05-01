import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/ui/providers/state/game_notifier.dart';
import 'package:leximatch/feature/game/ui/providers/state/game_ui_state.dart';

import '../../data/dto/game_dto.dart';


final gameStateProvider =
AsyncNotifierProvider<GameNotifier, GameUiState>(
      () => GameNotifier(),
);