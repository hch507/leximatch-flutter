import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/ui/providers/state/initial_hint_notifier.dart';
import 'package:leximatch/feature/game/ui/providers/state/initial_ui_state.dart';

final initialHintProvider =
AutoDisposeAsyncNotifierProvider<InitialHintNotifier, InitialHintUiState>(
  InitialHintNotifier.new,
);