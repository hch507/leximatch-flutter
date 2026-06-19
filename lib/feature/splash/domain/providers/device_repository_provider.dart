import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/api_client_provider.dart';
import '../../../../core/di/secure_storage_provider.dart';
import '../../data/repositoryimpl/device_repository_impl.dart';
import '../repository/device_repository.dart';

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return DeviceRepositoryImpl(
    apiClient: apiClient,
    storage: ref.read(
      secureStorageProvider,
    ),
  );
});
