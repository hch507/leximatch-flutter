import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/providers/notice_repository_provider.dart';
import '../../../domain/repository/notice_repository.dart';
import 'notice_ui_state.dart';

class NoticeNotifier
    extends AutoDisposeAsyncNotifier<NoticeUiState> {

  late final NoticeRepository _noticeRepository =
  ref.read(noticeRepositoryProvider);

  @override
  FutureOr<NoticeUiState> build() async {
    try {
      final notice = await _noticeRepository.fetchNotice();

      return NoticeUiState(
        notice: notice,
      );
    } catch (e) {
      return const NoticeUiState();
    }
  }
}