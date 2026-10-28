import 'package:flutter/material.dart';
import 'package:leximatch/core/widget/dialog.dart';
import 'package:leximatch/feature/game/domain/model/game_dto.dart';

import '../../../../../core/style/colors.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import '../../../../../core/widget/toast.dart';
import '../../../../home/ui/widgets/overlay/lock_overlay.dart';


class HintDialog extends StatelessWidget {
  final VoidCallback onBigHintWatch;
  final VoidCallback onRandomHintWatch;
  final VoidCallback onCancel;
  final List<GameDto> top5;
  const HintDialog({
    super.key,
    required this.onBigHintWatch,
    required this.onRandomHintWatch,
    required this.onCancel,
    required this.top5
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

          final int ranking = top5.isNotEmpty
              ? (int.tryParse(top5.first.ranking.toString()) ?? 9999)
              : 9999;

          final isTopRank = ranking >= 10;
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
                title: '초성 힌트',
                isTopRank: isTopRank,
                description: const TextSpan(
                  children: [
                    TextSpan(
                        text: '정답의 초성을 알려드려요!\n',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                    // TextSpan(
                    //   text: ' 한 글자',
                    //   style: TextStyle(
                    //     color: Color(0xFF1659C7),
                    //     fontWeight: FontWeight.w900,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: '를 알려드려요!',
                    //   style: TextStyle(
                    //       color: Colors.black87, fontWeight: FontWeight.w600),
                    // ),
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
  final bool isTopRank; // 옵셔널 (기본값 false)

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
    this.isTopRank = false, // required 아님
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: ClipRRect(
        // 테두리 두께(2)만큼 줄여서 안쪽 모서리에 맞춤
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(imagePath, width: 70, height: 70, fit: BoxFit.contain),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                        ),
                        Text.rich(
                          description,
                          style: const TextStyle(
                            fontSize: 10,
                            height: 1.4,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 3),
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
            ),

            if (isTopRank)
              const Positioned.fill(
                child: LockOverlay(
                  message: '유사도 10위안의 단어를 찾으면 \n 힌트가 열립니다!',
                  iconSize: 40,
                  fontSize: 10,
                  spacing: 6,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
