import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:leximatch/feature/game/domain/model/game_dto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtil {
  static Future<void> shareTop5({
    required List<GameDto> top5,
  }) async {
    final buffer = StringBuffer();

    buffer.writeln("🐾 Momantle 도움 요청!");
    buffer.writeln();
    buffer.writeln("도움을 요청했습니다!");
    buffer.writeln();
    buffer.writeln("현재까지 찾은 단어 Top5");
    buffer.writeln();

    for (var i = 0; i < top5.length; i++) {
      final item = top5[i];

      buffer.writeln(
        "${i + 1}. ${item.userInput} | ${item.dist} | ${item.ranking}위",
      );
    }

    buffer.writeln();
    buffer.writeln("💡 떠오르는 단어가 있다면 알려주세요!");

    await SharePlus.instance.share(
      ShareParams(
        text: buffer.toString(),
        subject: "Momantle 도움 요청",
        sharePositionOrigin: const Rect.fromLTWH(
          0,
          0,
          1,
          1,
        ),
      ),
    );
  }
}