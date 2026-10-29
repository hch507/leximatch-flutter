import '../../../domain/model/monthly_record_dto.dart';

class HomeMonthlyRecordUiState {
  final MonthlyRecordDto? record;

  const HomeMonthlyRecordUiState({
    this.record,
  });

  MonthlyRecordDto? get displayRecord => record;

  HomeMonthlyRecordUiState copyWith({
    MonthlyRecordDto? record,
  }) {
    return HomeMonthlyRecordUiState(
      record: record ?? this.record,
    );
  }
}