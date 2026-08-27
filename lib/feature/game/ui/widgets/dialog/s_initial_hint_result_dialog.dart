
import 'package:flutter/widgets.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import '../../../../../core/widget/dialog.dart';

class SInitialHintResultDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String initialWord;
  const SInitialHintResultDialog({
    super.key,
    required this.onConfirm,
    required this.initialWord,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      borderColor: const Color(0xFFFFC94A),
      titleImagePath: 'assets/images/ic_legend_hint_title.png',
      titleHeight: 50,
      backgroundImagePath: 'assets/images/legend_hint_background.png',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          // 강아지 + 상자
          Image.asset(
            'assets/images/ic_success_hint_lodo.png',
            height: 100,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 5),


          const Text(
            '글자 힌트 획득!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFF8A00),
            ),
          ),

          const SizedBox(height: 5),


          const Text(
            '한 글자 더~?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3D3028),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

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
                color: const Color(0xFFFFC94A),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                initialWord,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFF4B91),
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          LexiGameButton(
            text: '확인',
            width: 180,
            height: 50,
            type: LexiButtonType.legend,
            onTap: onConfirm,
          ),
        ],
      ),
    );
  }
}