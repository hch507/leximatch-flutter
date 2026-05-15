import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/ui/providers/state/hint_notifier.dart';
import 'package:leximatch/feature/game/ui/providers/state/hint_ui_state.dart';

final hintProvider =
AutoDisposeAsyncNotifierProvider<HintNotifier, HintUiState>(
  HintNotifier.new,
);