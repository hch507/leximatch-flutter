import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repository/device_repository.dart';

class DeviceRepositoryImpl
    implements DeviceRepository {

  static const _deviceIdKey = 'device_id';
  static const _lastFcmTokenKey = 'last_fcm_token';

  final FlutterSecureStorage _storage;

  DeviceRepositoryImpl({
    required FlutterSecureStorage storage,
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
}