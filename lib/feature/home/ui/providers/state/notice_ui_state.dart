import '../../../domain/model/notice_dto.dart';

class NoticeUiState {
  final NoticeDto? notice;

  const NoticeUiState({
    this.notice,
  });

  NoticeDto get displayNotice {
    return notice ??
        NoticeDto(
          content: '새로운 소식이 없습니다.',
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