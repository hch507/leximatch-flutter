import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/api_client_provider.dart';
import '../../../splash/domain/providers/device_repository_provider.dart';
import '../../data/repositoryImpl/notice_repository_impl.dart';
import '../repository/notice_repository.dart';

final noticeRepositoryProvider = Provider<NoticeRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final deviceRepository = ref.read(deviceRepositoryProvider);
  return NoticeRepositoryImpl(
    apiClient,
    deviceRepository,
  );
});
