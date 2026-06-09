import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/splash/ui/providers/state/splash_notifier.dart';
import 'package:leximatch/feature/splash/ui/providers/state/splash_ui_state.dart';

final splahsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SplashNotifier, SplashUiState>(
  SplashNotifier.new,
);
