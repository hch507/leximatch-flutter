
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/data/repositoryImpl/game_repository_Impl.dart';
import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

import '../../../../core/di/api_provider.dart';

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final dio = ref.read(dioProvider);

  return GameRepositoryImpl(dio);
});