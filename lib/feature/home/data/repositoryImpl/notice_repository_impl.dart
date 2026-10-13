

import 'package:leximatch/feature/home/domain/model/notice_dto.dart';
import 'package:leximatch/feature/home/domain/repository/notice_repository.dart';

import '../../../../core/network/common/api_client.dart';
import '../../../splash/domain/repository/device_repository.dart';

class NoticeRepositoryImpl implements NoticeRepository{

  final ApiClient apiClient;
  final DeviceRepository deviceRepository;

  NoticeRepositoryImpl(this.apiClient, this.deviceRepository);
  @override
  Future<NoticeDto?> fetchNotice() async {
    return await apiClient.request<NoticeDto>(
      '/api/notice',
      method: 'GET',
      fromJson: (json) {
        return NoticeDto.fromJson(
          json as Map<String, dynamic>,
        );
      },
    );
  }
}