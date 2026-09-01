import 'package:flutter/material.dart';
import 'package:leximatch/core/widget/dialog.dart';

import '../../../../../core/style/colors.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';

// class HintDialog extends StatelessWidget {
//   final VoidCallback onAdWatch;
//   final VoidCallback onCancel;
//
//   const HintDialog({
//     super.key,
//     required this.onAdWatch,
//     required this.onCancel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return LexiDialog(
//       borderColor: AppColors.blueDialogBorder,
//       titleImagePath: 'assets/images/ic_hint_title.png',
//       titleHeight: 50,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(height: 15,),
//           const Text(
//             '광고 시청 후\n힌트를 확인할 수 있어요!',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w900,
//               color: Color(0xFF2F4F60),
//               height: 1.4,
//             ),
//           ),
//
//           const SizedBox(height: 10),
//
//           const Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                   text: '일정 확률에 따라\n',
//                 ),
//
//                 TextSpan(
//                   text: 'SS',
//                   style: TextStyle(
//                     color: Color(0xFFFFD84A),
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//
//                 TextSpan(text: ' · '),
//
//                 TextSpan(
//                   text: 'S',
//                   style: TextStyle(
//                     color: Color(0xFFB875FF),
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//
//                 TextSpan(text: ' · '),
//
//                 TextSpan(
//                   text: 'A',
//                   style: TextStyle(
//                     color: Color(0xFF58B8FF),
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//
//                 TextSpan(text: ' · '),
//
//                 TextSpan(
//                   text: 'B',
//                   style: TextStyle(
//                     color: Color(0xFFD7A36D),
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//
//                 TextSpan(text: ' · '),
//
//                 TextSpan(
//                   text: 'C',
//                   style: TextStyle(
//                     color: Color(0xFFB9D98D),
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//
//                 TextSpan(
//                   text: ' 등급의\n힌트가 제공됩니다.',
//                 ),
//               ],
//               style: TextStyle(
//                 fontSize: 14,
//                 height: 1.5,
//                 color: Color(0xFF6D8795),
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             textAlign: TextAlign.center,
//           ),
//
//           const SizedBox(height: 28),
//
//           Row(
//             children: [
//               Expanded(
//                 child: LexiGameButton(
//                   height: 40,
//                   text: '닫기',
//                   type: LexiButtonType.orange,
//                   onTap: onCancel,
//                 ),
//               ),
//               const SizedBox(width: 14),
//               Expanded(
//                 child: LexiGameButton(
//                   height: 40,
//                   text: '광고 보기',
//                   type: LexiButtonType.blue,
//                   onTap: onAdWatch,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
class HintDialog extends StatelessWidget {
  final VoidCallback onBigHintWatch;
  final VoidCallback onRandomHintWatch;
  final VoidCallback onCancel;

  const HintDialog({
    super.key,
    required this.onBigHintWatch,
    required this.onRandomHintWatch,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      borderColor: AppColors.blueDialogBorder,
      titleImagePath: 'assets/images/ic_hint_title.png',
      titleHeight: 50,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 350;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),

              Text(
                '광고 시청 후 힌트를 확인하세요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF6D6258),
                ),
              ),

              const SizedBox(height: 10),

              // ─────────────────────────
              // 대박 힌트
              // ─────────────────────────
              HintCard(
                title: '대박 힌트',
                description: const TextSpan(
                  children: [
                    TextSpan(
                        text: '10%의 확률로 정답에 포함된\n',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                      text: ' 한 글자',
                      style: TextStyle(
                        color: Color(0xFF1659C7),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: '를 알려드려요!',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                buttonText: '힌트 받기',
                imagePath: 'assets/images/ic_big_hint.png',
                onButtonPressed: onBigHintWatch,
                backgroundColor: const Color(0xFFE8F4FF),
                borderColor: const Color(0xFF4A9AFF),
                titleColor: const Color(0xFF164B9B),
                buttonType: LexiButtonType.blue,
              ),

              const SizedBox(height: 10),

              // ─────────────────────────
              // 랜덤 힌트
              // ─────────────────────────
              HintCard(
                title: '랜덤 힌트',
                description: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'SS',
                      style: TextStyle(
                        color: Color(0xFFFFB800),
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
                      text: ' 등급의\n랜덤 힌트를 받아요!',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                buttonText: '힌트 받기',
                imagePath: 'assets/images/ic_random_hint.png',
                onButtonPressed: onRandomHintWatch,
                backgroundColor: const Color(0xFFFFF8DF),
                borderColor: const Color(0xFFFFB51B),
                titleColor: const Color(0xFF9C4A12),
                buttonType: LexiButtonType.orange,
              ),

              const SizedBox(height: 6),

              // 구분선
              Container(
                height: 1,
                color: const Color(0xFFE3D8C8),
              ),

              const SizedBox(height: 6),

              // 닫기
              SizedBox(
                width: 100,
                child: LexiGameButton(
                  height: 30,
                  text: '닫기',
                  type: LexiButtonType.gray,
                  onTap: onCancel,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────
// Hint Card
// ─────────────────────────────────────

class HintCard extends StatelessWidget {
  final String title;
  final TextSpan description;
  final String buttonText;
  final String imagePath;
  final VoidCallback onButtonPressed;

  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final LexiButtonType buttonType;

  const HintCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.imagePath,
    required this.onButtonPressed,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.buttonType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // 이미지
          Image.asset(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 5),

          // 오른쪽 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),

                // 설명
                Text.rich(
                  description,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.4,
                    color: Color(0xFF333333),
                  ),
                ),

                const SizedBox(height: 3),

                // 버튼 오른쪽 정렬
                Align(
                  alignment: Alignment.centerRight,
                  child: LexiGameButton(
                    height: 20,
                    width: 70,
                    text: buttonText,
                    type: buttonType,
                    onTap: onButtonPressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
