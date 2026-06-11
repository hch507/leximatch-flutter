

abstract class DeviceRepository {

  Future<String?> getOrCreateDeviceId();

  Future<String?> getCurrentFcmToken();

  Future<String?> getLastFcmToken();

  Future<void> saveLastFcmToken(String token);

  Future<void> registerDevice(String deviceId, String fcmToken);
}