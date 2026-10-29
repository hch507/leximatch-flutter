import 'package:leximatch/core/network/common/api_client.dart';
import 'package:leximatch/feature/home/domain/model/monthly_record_dto.dart';

import 'package:leximatch/feature/home/domain/repository/record_repository.dart';
import 'package:leximatch/feature/splash/domain/repository/device_repository.dart';

import '../../domain/model/home_record_dto.dart';
import '../../domain/model/record_dto.dart';

class RecordRepositoryImpl implements RecordRepository {
  final ApiClient apiClient;
  final DeviceRepository deviceRepository;

  RecordRepositoryImpl(this.apiClient, this.deviceRepository);

  @override
  Future<HomeRecordDto?> fetchRecord() async {
    final deviceId = await deviceRepository.getOrCreateDeviceId();
    return await apiClient.request<HomeRecordDto>(
      '/api/record',
      method: 'GET',
      queryParameters: {
        'device_id': deviceId,
      },
      fromJson: (json) {
        return HomeRecordDto.fromJson(
          json as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<MonthlyRecordDto?> fetchMonthlyRecord() async {
    final deviceId = await deviceRepository.getOrCreateDeviceId();
    return await apiClient.request<MonthlyRecordDto>(
      '/api/record/monthly',
      method: 'GET',
      queryParameters: {
        'deviceId': deviceId,
      },
      fromJson: (json) {
        return MonthlyRecordDto.fromJson(
          json as Map<String, dynamic>,
        );
      },
    );
  }

}
