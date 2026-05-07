import 'package:dio/dio.dart';
import 'package:leximatch/core/network/common/api_client.dart';
import 'package:leximatch/feature/game/data/dto/game_dto.dart';
import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

import '../../../../core/network/common/api_response.dart';

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
}