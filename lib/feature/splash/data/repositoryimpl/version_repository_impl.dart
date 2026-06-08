import 'package:leximatch/feature/splash/domain/model/version_dto.dart';
import 'package:leximatch/feature/splash/domain/repository/version_repository.dart';

import '../../../../core/network/common/api_client.dart';

class VersionRepositoryImpl implements VersionRepository {
  final ApiClient apiClient;

  VersionRepositoryImpl(this.apiClient);

  @override
  Future<VersionDto?> fetchVersion() {
    return apiClient.request<VersionDto>(
      '/api/version',
      method: 'GET',
      fromJson: (json) {
        return VersionDto.fromJson(json as Map<String, dynamic>);
      },
    );
  }
}
