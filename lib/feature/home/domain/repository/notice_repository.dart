

import '../model/notice_dto.dart';

abstract class NoticeRepository {
  Future<NoticeDto?> fetchNotice();
}
