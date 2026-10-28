import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/dialog.dart';
import '../../../../game/ui/style/hint_result_dialog_style.dart';

class MonthRecordHelpDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const MonthRecordHelpDialog({
    super.key,
    required this.onConfirm});
  static const _ink = Color(0xFF3B2F1E);
  static const _body = Color(0xFF4A3D2A);
  static const _muted = Color(0xFF7A6F62);
  static const _warnBg = Color(0xFFFCEFCF);
  static const _warnText = Color(0xFFA3281C);

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      borderColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/ic_record_dialog_title.png',
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),

          const Text(
            '월간 스코어 안내',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: _ink,
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            '월간 스코어와 순위는\n매월 1일 00시에 새로 시작됩니다.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.5, color: _body),
          ),
          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: _warnBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              '기록은 이 기기를 기준으로 저장되며. \n앱을 삭제하거나 기기를 바꾸면 기록이 사라질 수 있습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w700,
                color: _warnText,
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            '초기화 후에는 새로운 점수로\n다시 순위에 도전할 수 있어요!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, height: 1.5, color: _muted),
          ),
          const SizedBox(height: 20),

          LexiGameButton(
            text: '확인',
            width: 150,
            height: 40,
            onTap: onConfirm,
          ),
        ],
      ),
    );
  }
}
