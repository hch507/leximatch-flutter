import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/network/common/api_client.dart';
import '../../domain/repository/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final ApiClient apiClient;
  static const _deviceIdKey = 'device_id';
  static const _lastFcmTokenKey = 'last_fcm_token';

  final FlutterSecureStorage _storage;

  DeviceRepositoryImpl({
    required FlutterSecureStorage storage,
    required this.apiClient
  }) : _storage = storage;

  @override
  Future<String> getOrCreateDeviceId() async {

    final savedDeviceId =
    await _storage.read(
      key: _deviceIdKey,
    );

    if (savedDeviceId != null) {
      return savedDeviceId;
    }

    final deviceId =
    const Uuid().v4();

    await _storage.write(
      key: _deviceIdKey,
      value: deviceId,
    );

    return deviceId;
  }

  @override
  Future<String?> getCurrentFcmToken() {
    return FirebaseMessaging.instance.getToken();
  }

  //Todo : 아직 사용안함
  @override
  Future<String?> getLastFcmToken() {
    return _storage.read(
      key: _lastFcmTokenKey,
    );
  }

  @override
  Future<void> saveLastFcmToken(String token) async{
    await _storage.write(
      key: _lastFcmTokenKey,
      value: token,
    );
  }


  @override
  Future<void> registerDevice(
      String deviceId,
      String? fcmToken,
      ) async {
    await apiClient.request<void>(
      '/api/devices',
      method: 'POST',
      data: {
        'device_id': deviceId,
        'fcm_token': fcmToken,
      },
      fromJson: (_) {},
    );
  }
}