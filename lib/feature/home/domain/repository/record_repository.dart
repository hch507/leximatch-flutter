

import '../model/home_record_dto.dart';

abstract class RecordRepository {
  Future<HomeRecordDto?> fetchRecord();

}
