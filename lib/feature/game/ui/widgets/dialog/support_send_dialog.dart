import 'package:flutter/material.dart';

import '../../../../../core/style/colors.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import '../../../../../core/widget/dialog.dart';

class SupportSendDialog extends StatelessWidget {
  final VoidCallback onSend;
  final VoidCallback onCancel;

  const SupportSendDialog({
    super.key,
    required this.onSend,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      borderColor: AppColors.blueDialogBorder,
      titleImagePath: 'assets/images/ic_support_title.png',
      titleHeight: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,
          ),
          const Text(
            '친구에게 도움을 \n요청하세요.',
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
            '내가 찾은 Top5를 전달하고\n도움을 받아보세요!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF6D8795),
              fontWeight: FontWeight.w700,
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
                  text: '요청하기',
                  type: LexiButtonType.blue,
                  onTap: onSend,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
