import 'package:leximatch/core/network/common/api_client.dart';

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
    return HomeRecordDto(
      normalRecord: RecordDto(
        rank: "3",
        elapsedTime: "18:00:00",
      ),
      hardRecord: null,
      // hardRecord: RecordDto(rank: "4", elapsedTime: "18:00:00"),
    );
  }


}
