import '../../../domain/model/home_record_dto.dart';

class HomeRecordUiState {
  final HomeRecordDto? record;

  const HomeRecordUiState({
    this.record,
  });

  HomeRecordDto get displayRecord {
    return record ??
        HomeRecordDto(
          normalRecord: null,
          hardRecord: null,
        );
  }

  HomeRecordUiState copyWith({
    HomeRecordDto? record,
  }) {
    return HomeRecordUiState(
      record: record ?? this.record,
    );
  }
}