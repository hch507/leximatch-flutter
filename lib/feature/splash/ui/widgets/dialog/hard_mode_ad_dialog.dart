import 'package:flutter/cupertino.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import '../../../../../core/widget/dialog.dart';

class HardModeAdDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const HardModeAdDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      borderColor: const Color(0xFF5550B8),
      titleImagePath: 'assets/images/ic_hard_mode_title.png',
      titleHeight: 50,
      backgroundColor: const Color(0xFFF5F1FD),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          // 강아지 + 상자
          Image.asset(
            'assets/images/ic_hard_mode_major.png',
            height: 70,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 5),

          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF3D3028),
              ),
              children: [
                TextSpan(
                  text: '하드 모드',
                  style: TextStyle(
                    color: Color(0xFF5C32D6),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: ' 입장권',
                ),
              ],
            ),
          ),

          const SizedBox(height: 2),

          // 실패 메시지
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B6475),
              ),
              children: [
                TextSpan(
                  text: '하루 한 번 광고를 시청하고\n',
                ),
                TextSpan(
                  text: '하드 모드',
                  style: TextStyle(
                    color: Color(0xFF5C32D6),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: '에 도전해보세요!',
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),


          Row(
            children: [
              Expanded(
                child: LexiGameButton(
                  height: 40,
                  text: '닫기',
                  type: LexiButtonType.gray,
                  onTap: onCancel,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: LexiGameButton(
                  height: 40,
                  text: '도전하기',
                  type: LexiButtonType.hard_mode,
                  onTap: onConfirm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}