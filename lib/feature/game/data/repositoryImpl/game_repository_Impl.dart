import 'package:dio/dio.dart';
import 'package:leximatch/core/network/common/api_client.dart';

import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

import '../../../../core/network/common/api_response.dart';
import '../../domain/model/game_dto.dart';
import '../../domain/model/hint_dto.dart';

class GameRepositoryImpl implements GameRepository {
  final ApiClient apiClient;
  GameRepositoryImpl(this.apiClient);

  @override
  Future<GameDto?> fetchSimilarity(String keyword) {
    return apiClient.request<GameDto>(
      '/api/games/guess',
      method: 'GET',
      queryParameters: {
        'input': keyword,
      },
      fromJson: (json) {
        return GameDto.fromJson(json as Map<String, dynamic>);
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
}