import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/home/ui/providers/state/home_ad_watched_notifier.dart';
import 'package:leximatch/feature/home/ui/providers/state/home_ad_watched_ui_state.dart';

final homeAdWatchedNotifierProvider =
AutoDisposeAsyncNotifierProvider<HomeAdWatchedNotifier, HomeAdWatchedUiState>(
  HomeAdWatchedNotifier.new,
);
