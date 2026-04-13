import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/ui/providers/state/game_notifier.dart';


final gameStateProvider =
AsyncNotifierProvider<GameNotifier, String>(
      () => GameNotifier(),
);