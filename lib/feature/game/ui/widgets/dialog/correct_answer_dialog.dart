import 'package:flutter/material.dart';


import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/dialog.dart';

class CorrectAnswerDialog extends StatelessWidget {
  final String elapsedTime;
  final VoidCallback onConfirm;

  const CorrectAnswerDialog({
    super.key,
    required this.elapsedTime,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      titleImagePath: 'assets/images/correct_comment_logo.png',
      titleWidth: 310,
      borderColor: const Color(0xFFFFC95A),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/ic_lodo_success.png',
            height: 150,
            fit: BoxFit.contain,
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFAED),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFEFCB8A),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/ic_timer.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '걸린 시간',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF5A3B22),
                      ),
                    ),
                  ],
                ),

                Text(
                  elapsedTime,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4A2D17),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: 220,
            height: 64,
            child: LexiGameButton(
              onTap: onConfirm,
              text: "확인",
            ),
          ),
        ],
      ),
    );
  }
}