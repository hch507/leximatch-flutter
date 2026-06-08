
import 'package:leximatch/feature/splash/domain/model/version_dto.dart';

abstract class VersionRepository {

  Future<VersionDto?> fetchVersion();
}