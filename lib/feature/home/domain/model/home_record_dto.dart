import 'package:leximatch/feature/home/domain/model/record_dto.dart';

class HomeRecordDto {
  final String recordDate;
  final RecordDto? normalRecord;
  final RecordDto? hardRecord;

  HomeRecordDto({
    required this.recordDate,
    this.normalRecord,
    this.hardRecord,
  });

  factory HomeRecordDto.fromJson(Map<String, dynamic> json) {
    return HomeRecordDto(
      recordDate: json['record_date'] as String,
      normalRecord: json['normal_record'] != null
          ? RecordDto.fromJson(
        json['normal_record'] as Map<String, dynamic>,
      )
          : null,
      hardRecord: json['hard_record'] != null
          ? RecordDto.fromJson(
        json['hard_record'] as Map<String, dynamic>,
      )
          : null,
    );
  }
}