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
          SizedBox(height: 15,),
          const Text(
            '광고 시청 후\n힌트를 확인할 수 있어요!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2F4F60),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 10),

          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '일정 확률에 따라\n',
                ),

                TextSpan(
                  text: 'SS',
                  style: TextStyle(
                    color: Color(0xFFFFD84A),
                    fontWeight: FontWeight.w900,
                  ),
                ),

                TextSpan(text: ' · '),

                TextSpan(
                  text: 'S',
                  style: TextStyle(
                    color: Color(0xFFB875FF),
                    fontWeight: FontWeight.w900,
                  ),
                ),

                TextSpan(text: ' · '),

                TextSpan(
                  text: 'A',
                  style: TextStyle(
                    color: Color(0xFF58B8FF),
                    fontWeight: FontWeight.w900,
                  ),
                ),

                TextSpan(text: ' · '),

                TextSpan(
                  text: 'B',
                  style: TextStyle(
                    color: Color(0xFFD7A36D),
                    fontWeight: FontWeight.w900,
                  ),
                ),

                TextSpan(text: ' · '),

                TextSpan(
                  text: 'C',
                  style: TextStyle(
                    color: Color(0xFFB9D98D),
                    fontWeight: FontWeight.w900,
                  ),
                ),

                TextSpan(
                  text: ' 등급의\n힌트가 제공됩니다.',
                ),
              ],
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF6D8795),
                fontWeight: FontWeight.w700,
              ),
            ),
            textAlign: TextAlign.center,
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
