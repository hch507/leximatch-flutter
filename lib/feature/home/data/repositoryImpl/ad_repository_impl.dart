import 'package:leximatch/feature/home/domain/model/ad_watch_dto.dart';
import 'package:leximatch/feature/home/domain/repository/ad_repository.dart';

import '../../../../core/network/common/api_client.dart';
import '../../../splash/domain/repository/device_repository.dart';

class AdRepositoryImpl implements AdRepository{
  final ApiClient apiClient;
  final DeviceRepository deviceRepository;

  AdRepositoryImpl(this.apiClient, this.deviceRepository);
  @override
  Future<AdWatchDto> fetchAdWatch() async {
    final deviceId = await deviceRepository.getOrCreateDeviceId();

    final result = await apiClient.request<AdWatchDto>(
      '/api/ad/today',
      method: 'GET',
      queryParameters: {
        'device_id': deviceId,
      },
      fromJson: (json) {
        return AdWatchDto.fromJson(
          json as Map<String, dynamic>,
        );
      },
    );

    return result!;
  }


  @override
  Future<void> saveAdWatch() async {
    final deviceId = await deviceRepository.getOrCreateDeviceId();

    await apiClient.request<void>(
      '/api/ad/save',
      method: 'POST',
      data: {
        'device_id': deviceId,
      },
      fromJson: (_) {},
    );
  }

}