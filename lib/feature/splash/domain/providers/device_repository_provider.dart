import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/secure_storage_provider.dart';
import '../../data/repositoryimpl/device_repository_impl.dart';
import '../repository/device_repository.dart';

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  return DeviceRepositoryImpl(
    storage: ref.read(
      secureStorageProvider,
    ),
  );
});
