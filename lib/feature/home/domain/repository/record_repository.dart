

import 'package:leximatch/feature/home/domain/model/monthly_record_dto.dart';

import '../model/home_record_dto.dart';

abstract class RecordRepository {
  Future<HomeRecordDto?> fetchRecord();

  Future<MonthlyRecordDto?> fetchMonthlyRecord();

}
