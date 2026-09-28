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
    return AdWatchDto(watched: false);
  }

  @override
  Future<void> saveAdWatch() async {


  }

}