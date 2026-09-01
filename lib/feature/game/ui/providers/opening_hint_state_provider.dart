import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/ui/providers/state/hint_ui_state.dart';
import 'package:leximatch/feature/game/ui/providers/state/opening_hint_notifier.dart';

final openingHintProvider =
AutoDisposeAsyncNotifierProvider<OpeningHintNotifier, HintUiState>(
  OpeningHintNotifier.new,
);