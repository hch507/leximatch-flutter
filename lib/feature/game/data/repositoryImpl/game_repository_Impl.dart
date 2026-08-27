import 'package:dio/dio.dart';
import 'package:leximatch/core/network/common/api_client.dart';
import 'package:leximatch/feature/game/domain/model/initial_hint_dto.dart';

import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

import '../../../../core/network/common/api_response.dart';
import '../../../splash/domain/repository/device_repository.dart';
import '../../domain/model/game_dto.dart';
import '../../domain/model/hint_dto.dart';

class GameRepositoryImpl implements GameRepository {
  final ApiClient apiClient;
  final DeviceRepository deviceRepository;

  GameRepositoryImpl(
    this.apiClient,
    this.deviceRepository,
  );

  @override
  Future<GameDto?> fetchSimilarity(
    String keyword,
  ) async {
    final deviceId = await deviceRepository.getOrCreateDeviceId();
    print('guess deviceId = $deviceId');
    return apiClient.request<GameDto>(
      '/api/games/guess',
      method: 'POST',
      data: {
        'input': keyword,
        'device_id': deviceId,
      },
      fromJson: (json) {
        return GameDto.fromJson(
          json as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<HintDto?> fetchHint() {
    return apiClient.request<HintDto>(
      '/api/games/hint',
      method: 'GET',
      fromJson: (json) {
        return HintDto.fromJson(json as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<InitialHintDto> fetchInitialHint() async {
    final result = await apiClient.request<InitialHintDto>(
      '/api/games/initial-hint',
      method: 'GET',
      fromJson: (json) {
        return InitialHintDto.fromJson(json as Map<String, dynamic>);
      },
    );

    return result!;
  }
}
