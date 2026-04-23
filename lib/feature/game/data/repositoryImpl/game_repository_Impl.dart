import 'package:dio/dio.dart';
import 'package:leximatch/feature/game/data/dto/game_dto.dart';
import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

import '../../../../core/network/common/api_response.dart';

class GameRepositoryImpl implements GameRepository {
  final Dio dio;
  GameRepositoryImpl(this.dio);

  @override
  Future<GameDto?> fetchSimilarity(String keyword) async {
    try {
      final response = await dio.get(
        '/similarity',
        queryParameters: {
          'text1': "사과",
          'text2': keyword,
        },
      );

      // response.data가 이미 Map인 경우 (Dio의 특징)
      final result = ApiResponse<GameDto>.fromJson(
        response.data,
            (data) => GameDto.fromJson(data as Map<String, dynamic>),
      );

      // 성공 코드(200) 확인 후 body 반환
      if (result.result.resultCode == 200) {
        return result.body;
      } else {
        return null;
      }
    } catch (e) {
      // 네트워크 에러 등 예외 처리
      print("Error fetching similarity: $e");
      return null;
    }
  }
}