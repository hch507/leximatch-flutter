import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/splash/ui/providers/state/version_notifier.dart';
import 'package:leximatch/feature/splash/ui/providers/state/version_ui_state.dart';

final versionNotifierProvider =
    AutoDisposeAsyncNotifierProvider<VersionNotifier, VersionUiState>(
  VersionNotifier.new,
);
