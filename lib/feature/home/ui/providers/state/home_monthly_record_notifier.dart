import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/monthly_record_dto.dart';
import '../../../domain/providers/record_repository_provider.dart';
import '../../../domain/repository/record_repository.dart';

class HomeMonthlyRecordNotifier extends AutoDisposeAsyncNotifier<MonthlyRecordDto>{
  late final RecordRepository _recordRepository = ref.read(recordRepositoryProvider);
  @override
  FutureOr<MonthlyRecordDto> build() async {
    final record = await _recordRepository.fetchMonthlyRecord();

    if (record == null) {
      throw Exception('Home record not found');
    }

    return record;
  }
}