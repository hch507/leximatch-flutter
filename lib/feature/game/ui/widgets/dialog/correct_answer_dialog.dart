import 'package:flutter/material.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/dialog.dart';

class CorrectAnswerDialog extends StatelessWidget {
  final String elapsedTime;
  final String rank;
  final VoidCallback onConfirm;

  const CorrectAnswerDialog({
    super.key,
    required this.elapsedTime,
    required this.rank,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return LexiDialog(
      titleImagePath: 'assets/images/correct_comment_logo.png',
      titleHeight: 100,
      borderColor: const Color(0xFFFFC95A),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/ic_lodo_success.png',
            height: 100,
            fit: BoxFit.contain,
          ),
          CorrectResultCard(
            elapsedTime: elapsedTime,
            rank: rank,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            height: 55,
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

class CorrectResultCard extends StatelessWidget {
  final String elapsedTime;
  final String rank;

  const CorrectResultCard({
    super.key,
    required this.elapsedTime,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF4),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFF0C96A),
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _InfoRow(
            iconPath: 'assets/images/ic_timer.png',
            title: '클리어 기록',
            value: elapsedTime,
            titleColor: const Color(0xFF3972B6),
            valueColor: const Color(0xFF5A3718),
            iconBackgroundColor: const Color(0xFFEAF2FF),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              height: 1,
              thickness: 1.5,
              color: Color(0xFFEFDDAE),
            ),
          ),
          _InfoRow(
            iconPath: 'assets/images/ic_trophy.png',
            title: '최초 클리어 랭크',
            value: '${rank}',
            titleColor: const Color(0xFFC97A00),
            valueColor: const Color(0xFFFF8A00),
            iconBackgroundColor: const Color(0xFFFFF1C9),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;
  final Color titleColor;
  final Color valueColor;
  final Color iconBackgroundColor;

  const _InfoRow({
    required this.iconPath,
    required this.title,
    required this.value,
    required this.titleColor,
    required this.valueColor,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Image.asset(
            iconPath,
            width: 45,
            height: 45,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
