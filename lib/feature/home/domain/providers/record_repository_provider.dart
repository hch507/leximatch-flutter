
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/home/data/repositoryImpl/record_respository_impl.dart';
import 'package:leximatch/feature/home/domain/repository/record_repository.dart';

import '../../../../core/di/api_client_provider.dart';
import '../../../splash/domain/providers/device_repository_provider.dart';
final recordRepositoryProvider = Provider<RecordRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final deviceRepository = ref.read(deviceRepositoryProvider);

  return RecordRepositoryImpl(
    apiClient,
    deviceRepository,
  );
});