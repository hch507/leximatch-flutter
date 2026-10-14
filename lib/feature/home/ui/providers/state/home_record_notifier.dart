import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/home/domain/model/home_record_dto.dart';
import 'package:leximatch/feature/home/domain/repository/record_repository.dart';
import '../../../domain/providers/record_repository_provider.dart';

class HomeRecordNotifier extends AutoDisposeAsyncNotifier<HomeRecordDto>{
  late final RecordRepository _recordRepository = ref.read(recordRepositoryProvider);
  @override
  FutureOr<HomeRecordDto> build() async {
    final record = await _recordRepository.fetchRecord();

    if (record == null) {
      throw Exception('Home record not found');
    }

    return record;
  }
}