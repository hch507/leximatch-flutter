
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/data/repositoryImpl/game_repository_Impl.dart';
import 'package:leximatch/feature/game/domain/repository/game_repository.dart';

import '../../../../core/di/api_client_provider.dart';
import '../../../../core/di/api_provider.dart';
import '../../../splash/domain/providers/device_repository_provider.dart';

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final deviceRepository = ref.read(deviceRepositoryProvider);

  return GameRepositoryImpl(
    apiClient,
    deviceRepository,
  );
});