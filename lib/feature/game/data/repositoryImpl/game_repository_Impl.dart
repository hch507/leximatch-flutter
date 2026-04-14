import 'package:dio/dio.dart';
import 'package:leximatch/feature/game/data/dto/game_dto.dart';
import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

import '../../../../core/network/common/api_response.dart';

class GameRepositoryImpl implements GameRepository {

  final Dio dio;
  GameRepositoryImpl(this.dio);

  @override
  Future<void> getSimilarity() async{
    final response = await dio.get(
      '/similarity',
      queryParameters: {
        'text1': "사과",
        'text2': "키위",
      },
    );

    final apiResponse = ApiResponse<GameDto>.fromJson(
      response.data,
          (data) => GameDto.fromJson(
        data as Map<String, dynamic>,
      ),
    );
    print(response.data);
  }}