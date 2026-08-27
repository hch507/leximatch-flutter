import 'package:flutter/cupertino.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import '../../../../../core/widget/dialog.dart';
import '../../style/hint_result_dialog_style.dart';

class FInitialHintResultDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const FInitialHintResultDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      borderColor: const Color(0xFF5550B8),
      titleImagePath: 'assets/images/ic_fail_hint_title.png',
      titleHeight: 50,
      backgroundImagePath: 'assets/images/fail_hint_background.png',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          // 강아지 + 상자
          Image.asset(
            'assets/images/ic_fail_hint_lodo.png',
            height: 100,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 5),

          // 아쉽게도...
          const Text(
            '아쉽게도...',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Color(0xFF3D3028),
            ),
          ),

          const SizedBox(height: 2),

          // 실패 메시지
          const Text(
            '다음에 또 도전해보세요!',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3D3028),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 5),

          // 안내 박스
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4FC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD1D1E8),
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Text(
                '꽝!!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5550B8),
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          LexiGameButton(
            text: '확인',
            width: 180,
            height: 50,
            type: LexiButtonType.fail,
            onTap: onConfirm,
          ),
        ],
      ),
    );
  }
}