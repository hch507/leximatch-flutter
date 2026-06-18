import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/providers/device_repository_provider.dart';
import '../../../domain/repository/device_repository.dart';

//ㅅTodo : 추후 fcm 토큰 변경시만 api 호출
class DeviceNotifier extends AutoDisposeAsyncNotifier<void> {
  late final DeviceRepository _deviceRepository =
  ref.read(deviceRepositoryProvider);

  @override
  Future<void> build() async {}

  Future<void> register() async {
    await _requestNotificationPermissionIfNeeded();

    final deviceId =
    await _deviceRepository.getOrCreateDeviceId();

    if (deviceId == null || deviceId.isEmpty) {
      throw Exception('Device ID 생성 실패');
    }

    final currentFcmToken =
    await _deviceRepository.getCurrentFcmToken();

    if (currentFcmToken == null ||
        currentFcmToken.isEmpty) {
      throw Exception('FCM Token 조회 실패');
    }

    await _deviceRepository.registerDevice(
      deviceId,
      currentFcmToken,
    );

    await _deviceRepository.saveLastFcmToken(
      currentFcmToken,
    );
  }

  Future<void> _requestNotificationPermissionIfNeeded() async {
    if (Platform.isIOS) {
      final settings =
      await FirebaseMessaging.instance.getNotificationSettings();

      if (settings.authorizationStatus ==
          AuthorizationStatus.notDetermined) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      return;
    }

    if (Platform.isAndroid) {
      final status = await Permission.notification.status;

      if (status.isGranted) {
        return;
      }

      if (status.isDenied) {
        await Permission.notification.request();
        return;
      }

      // "다시 묻지 않음" 상태
      if (status.isPermanentlyDenied) {
        // 설정 이동은 바로 하지 말고
        // 다이얼로그 보여준 뒤 사용자가 눌렀을 때 이동
        return;
      }
    }
  }
}