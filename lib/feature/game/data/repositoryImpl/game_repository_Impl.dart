import 'package:dio/dio.dart';
import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

class GameRepositoryImpl implements GameRepository {

  final Dio dio;
  GameRepositoryImpl(this.dio);

  @override
  Future<void> getData() {
    print("실행");
    throw UnimplementedError();
  }}