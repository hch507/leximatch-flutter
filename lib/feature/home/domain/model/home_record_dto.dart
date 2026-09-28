import 'package:leximatch/feature/home/domain/model/record_dto.dart';

class HomeRecordDto {
  final RecordDto? normalRecord;
  final RecordDto? hardRecord;

  HomeRecordDto({
    this.normalRecord,
    this.hardRecord,
  });

  factory HomeRecordDto.fromJson(
      Map<String, dynamic> json,
      ) {
    return HomeRecordDto(
      normalRecord: json['normal_record'] != null
          ? RecordDto.fromJson(json['normal_record'])
          : null,
      hardRecord: json['hard_record'] != null
          ? RecordDto.fromJson(json['hard_record'])
          : null,
    );
  }
}