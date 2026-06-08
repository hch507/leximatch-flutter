
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/api_client_provider.dart';
import '../../data/repositoryimpl/version_repository_impl.dart';
import '../repository/version_repository.dart';

final versionRepositoryProvider = Provider<VersionRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);

  return VersionRepositoryImpl(apiClient);
});