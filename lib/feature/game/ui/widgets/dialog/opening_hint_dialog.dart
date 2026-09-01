import 'package:flutter/material.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/dialog.dart';
import '../../style/hint_result_dialog_style.dart';

class OpeningHintDialog extends StatelessWidget {
  final String word;
  final VoidCallback onConfirm;
  const OpeningHintDialog({
    super.key,
    required this.word,

    required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final rank = 300;
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
            const Text(
              '오늘의 단어를 찾아보세요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A3A2A),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '유사도 300위의 단어를\n알려드릴게요!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A3A2A),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              word,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color:style.pointColor,
              ),
            ),
            const SizedBox(height: 10),

            LexiGameButton(
              text: '확인',
              width: 150,
              height: 40,
              // type: style.buttonType,
              onTap: onConfirm,
            ),
          ],
        )
    );
  }
}
