import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/splash/domain/providers/version_respository_provider.dart';
import 'package:leximatch/feature/splash/domain/repository/version_repository.dart';
import 'package:leximatch/feature/splash/ui/providers/state/version_ui_state.dart';

class VersionNotifier extends AutoDisposeAsyncNotifier<VersionUiState> {
  late final VersionRepository _repository =
      ref.read(versionRepositoryProvider);

  @override
  Future<VersionUiState> build() async {
    final result = await _repository.fetchVersion();

    return VersionUiState(
      version: result,
    );
  }
}
