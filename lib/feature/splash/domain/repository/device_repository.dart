

abstract class DeviceRepository {

  Future<String?> getOrCreateDeviceId();

  Future<String?> getCurrentFcmToken();

  Future<String?> getLastFcmToken();

  Future<void> saveLastFcmToken(String token);
}