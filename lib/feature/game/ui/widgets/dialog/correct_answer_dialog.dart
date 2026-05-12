import 'package:flutter/material.dart';

import '../../../../../core/widget/button.dart';

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
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // 메인 카드
          Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.fromLTRB(20, 45, 20, 24),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6DF),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: const Color(0xFFFFC95A),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 강아지 이미지
                Image.asset(
                  'assets/images/ic_lodo_success.png',
                  height: 210,
                  fit: BoxFit.contain,
                ),

                // 시간 카드
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(width: 18),
                      Text(
                        elapsedTime,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4A2D17),
                        ),
                      ),
                    ],

                  ),
                ),

                const SizedBox(height: 24),

                // 확인 버튼
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
          ),

          // 상단 로고
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/correct_comment_logo.png',
              width: 310,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
