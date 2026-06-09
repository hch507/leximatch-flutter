import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repository/device_repository.dart';

class DeviceRepositoryImpl
    implements DeviceRepository {

  static const _deviceIdKey = 'device_id';

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
}