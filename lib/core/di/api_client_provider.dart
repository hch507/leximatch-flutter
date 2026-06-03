import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/common/api_client.dart';
import 'api_provider.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.read(dioProvider);
  return ApiClient(dio);
});