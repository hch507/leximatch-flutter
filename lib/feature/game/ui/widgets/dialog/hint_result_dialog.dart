import 'package:flutter/material.dart';

import '../../../../../core/style/colors.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import '../../../../../core/widget/dialog.dart';
import '../../style/hint_result_dialog_style.dart';
import '../card/hint_result_card.dart';
import '../card/research_card.dart';

class HintResultDialog extends StatelessWidget {
  final String word;
  final String similarity;
  final String ranking;
  final VoidCallback onConfirm;

  const HintResultDialog({
    super.key,
    required this.word,
    required this.similarity,
    required this.ranking,
    required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final rank = int.tryParse(ranking) ?? 999;
    final style = HintResultDialogStyle.of(rank);

    return LexiDialog(
        borderColor: style.borderColor,
        titleImagePath: style.titleAsset,
        titleHeight: 50,
        backgroundImagePath: style.backgroundAsset,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/ic_hint_lodo.png',
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '힌트',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: style.pointColor,
                    ),
                  ),
                  const TextSpan(
                    text: '를 확인했어요!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF4A3A2A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            HintResultCard(
              input: word,
              similarity: similarity,
              rank: ranking,

              backgroundColor: style.cardBackgroundColor,
              borderColor: style.cardBorderColor,
              dividerColor: style.cardDividerColor,
              titleColor: style.cardTitleColor,
              pointTextColor: style.cardPointTextColor,
            ),

            const SizedBox(height: 22),

            LexiGameButton(
              text: '확인',
              width: 180,
              height: 50,
              type: style.buttonType,
              onTap: onConfirm,
            ),
          ],
        )
    );
  }
}
