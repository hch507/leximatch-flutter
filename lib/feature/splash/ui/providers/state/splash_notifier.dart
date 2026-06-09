import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
    await _requestNotificationPermissionIfNeeded();

    final deviceId = await _deviceRepository.getOrCreateDeviceId();

    await _syncFcmTokenIfNeeded(
      deviceId: deviceId!,
    );

    final version = await _repository.fetchVersion();

    return SplashUiState(
      version: version,
    );
  }

  Future<void> _requestNotificationPermissionIfNeeded() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      await FirebaseMessaging.instance.requestPermission();

      await Future.delayed(
        const Duration(seconds: 1),
      );
    }
  }

  Future<void> _syncFcmTokenIfNeeded({
    required String deviceId,
  }) async {
    final currentFcmToken = await _deviceRepository.getCurrentFcmToken();

    final lastFcmToken = await _deviceRepository.getLastFcmToken();
    debugPrint('''
      deviceId = $deviceId
      currentFcmToken = $currentFcmToken
      lastFcmToken = $lastFcmToken
    ''');
    if (currentFcmToken == null || currentFcmToken == lastFcmToken) {

      return;
    }
    // final response = await _deviceRepository.registerDevice(
    //   deviceId: deviceId,
    //   fcmToken: currentFcmToken,
    // );
    //
    //
    // if (response.isSuccess) {
    //   await _deviceRepository.saveLastFcmToken(
    //     currentFcmToken,
    //   );
    // }
    await _deviceRepository.saveLastFcmToken(
      currentFcmToken,
    );
  }
}
