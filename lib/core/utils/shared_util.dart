import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtil {

  static Future<void> shareCorrectAnswer({
    required String playTime,
  }) async {

    final byteData = await rootBundle.load(
      'assets/images/ic_lodo_search.png',
    );

    final tempDir = await getTemporaryDirectory();

    final imageFile = File(
      '${tempDir.path}/leximatch_share.png',
    );

    await imageFile.writeAsBytes(
      byteData.buffer.asUint8List(),
    );

    final text = '''
🎉 LexiMatch 정답 성공!

걸린 시간 : $playTime

매일 새로운 단어에 도전해보세요!

https://play.google.com/store/apps/details?id=com.lotto.leximatch
''';

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(imageFile.path),
        ],
        text: text,
        subject: 'LexiMatch',
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