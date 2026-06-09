import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/splash/domain/providers/version_respository_provider.dart';
import 'package:leximatch/feature/splash/domain/repository/version_repository.dart';
import 'package:leximatch/feature/splash/ui/providers/state/splash_ui_state.dart';

import '../../../domain/providers/device_repository_provider.dart';
import '../../../domain/repository/device_repository.dart';

class SplashNotifier extends AutoDisposeAsyncNotifier<SplashUiState> {
  late final VersionRepository _repository =
      ref.read(versionRepositoryProvider);

  late final DeviceRepository _deviceRepository =
      ref.read(deviceRepositoryProvider);

  @override
  Future<SplashUiState> build() async {
    final result = await _repository.fetchVersion();
    final deviceId =
    await _deviceRepository.getOrCreateDeviceId();

    print('deviceId = $deviceId');
    return SplashUiState(
      version: result,
    );
  }
}
