import '../../../domain/model/notice_dto.dart';

class NoticeUiState {
  final NoticeDto? notice;

  const NoticeUiState({
    this.notice,
  });

  NoticeDto get displayNotice {
    return notice ??
        NoticeDto(
          content: null,
          url: null,
        );
  }

  NoticeUiState copyWith({
    NoticeDto? notice,
  }) {
    return NoticeUiState(
      notice: notice ?? this.notice,
    );
  }
}