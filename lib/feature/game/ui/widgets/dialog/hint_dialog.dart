import 'package:flutter/material.dart';
import 'package:leximatch/core/widget/dialog.dart';

import '../../../../../core/style/colors.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';

class HintDialog extends StatelessWidget {
  final VoidCallback onAdWatch;
  final VoidCallback onCancel;

  const HintDialog({
    super.key,
    required this.onAdWatch,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      borderColor: AppColors.blueDialogBorder,
      titleImagePath: 'assets/images/ic_hint_title.png',
      titleHeight: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '광고를 시청 후\n힌트를 확인할 수 있어요!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2F4F60),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            '힌트에는 단어, 유사도, 랭킹 정보가 포함돼요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6D8795),
            ),
          ),

          const SizedBox(height: 28),

          Row(
            children: [
              Expanded(
                child: LexiGameButton(
                  height: 40,
                  text: '닫기',
                  type: LexiButtonType.orange,
                  onTap: onCancel,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: LexiGameButton(
                  height: 40,
                  text: '광고 보기',
                  type: LexiButtonType.blue,
                  onTap: onAdWatch,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
