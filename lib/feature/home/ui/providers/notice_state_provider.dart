import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/home/ui/providers/state/notice_notifier.dart';
import 'package:leximatch/feature/home/ui/providers/state/notice_ui_state.dart';

final noticeNotifierProvider =
AutoDisposeAsyncNotifierProvider<
    NoticeNotifier,
    NoticeUiState>(
  NoticeNotifier.new,
);
