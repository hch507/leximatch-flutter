import 'package:leximatch/feature/home/domain/model/ad_watch_dto.dart';

abstract class AdRepository {
  Future<AdWatchDto> fetchAdWatch();

  Future<void> saveAdWatch();
}
