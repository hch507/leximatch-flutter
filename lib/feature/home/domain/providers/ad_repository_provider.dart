import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/home/domain/repository/ad_repository.dart';

import '../../../../core/di/api_client_provider.dart';
import '../../../splash/domain/providers/device_repository_provider.dart';
import '../../data/repositoryImpl/ad_repository_impl.dart';

final adRepositoryProvider = Provider<AdRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final deviceRepository = ref.read(deviceRepositoryProvider);
  return AdRepositoryImpl(
    apiClient,
    deviceRepository,
  );
});
