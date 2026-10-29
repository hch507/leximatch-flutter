import 'package:flutter/material.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/dialog.dart';

class CorrectAnswerDialog extends StatelessWidget {
  final String elapsedTime;
  final String rank;
  final VoidCallback onConfirm;
  final String timeScore;
  final String rankScore;

  const CorrectAnswerDialog({
    super.key,
    required this.elapsedTime,
    required this.rank,
    required this.onConfirm,
    required this.timeScore,
    required this.rankScore,
  });

  @override
  Widget build(BuildContext context) {
    final totalScore =
        (int.tryParse(timeScore) ?? 0) + (int.tryParse(rankScore) ?? 0);
    return LexiDialog(
      titleImagePath: 'assets/images/correct_comment_logo.png',
      titleHeight: 100,
      borderColor: const Color(0xFFFFC95A),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/ic_lodo_success.png',
            height: 90,
            fit: BoxFit.contain,
          ),
          CorrectResultCard(
            elapsedTime: elapsedTime,
            rank: rank,
            timeScore: timeScore,
            rankScore: rankScore
          ),
          const SizedBox(height: 12),
          _TotalScoreBar(totalScore: totalScore),
          const SizedBox(height: 8),
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
  final String timeScore;
  final String rankScore;

  const CorrectResultCard({
    super.key,
    required this.elapsedTime,
    required this.rank,
    required this.timeScore,
    required this.rankScore,
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
            iconBackgroundColor: const Color(0xFFEAF2FF), score: timeScore,
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
            iconBackgroundColor: const Color(0xFFFFF1C9), score: rankScore,
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
  final String score;
  final Color titleColor;
  final Color valueColor;
  final Color iconBackgroundColor;

  const _InfoRow({
    required this.iconPath,
    required this.title,
    required this.value,
    required this.score,
    required this.titleColor,
    required this.valueColor,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        // 높이가 정해져 있으면 높이 기준, 아니면 폭 기준으로 추정
        final base = c.maxHeight.isFinite ? c.maxHeight : c.maxWidth * 0.25;

        final iconSize = (base * 0.65).clamp(36.0, 48.0).toDouble();
        final titleSize = (base * 0.20).clamp(12.0, 15.0).toDouble();
        final valueSize = (base * 0.28).clamp(15.0, 20.0).toDouble();
        final badgeSize = (base * 0.20).clamp(12.0, 15.0).toDouble();
        final gap = (base * 0.13).clamp(6.0, 10.0).toDouble();

        return Row(
          children: [
            Image.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
            SizedBox(width: gap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w800,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: gap * 0.4),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: valueSize,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: valueColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: gap),
            _ScoreBadge(score: score ),
          ],
        );
      },
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  final String score;

  const _ScoreBadge({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEECC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF4C476),
          width: 1.5,
        ),
      ),
      child: Text(
        '+${score}P',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: Color(0xFFEC8A24),
        ),
      ),
    );
  }
}
class _TotalScoreBar extends StatelessWidget {
  final int totalScore;

  const _TotalScoreBar({required this.totalScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1C4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF1C460),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFECCD82).withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 코인 아이콘 (에셋이 있으면 Image.asset으로 교체하세요)
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFD954), Color(0xFFE09624)],
              ),
            ),
            child: const Text(
              'P',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Color(0xFFAA6412),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            '획득 포인트',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFFB0782C),
            ),
          ),
          const Spacer(),
          // 0 -> totalScore 카운트업 애니메이션
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: totalScore),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => Text(
              '+${value}P',
              style: const TextStyle(
                fontSize: 24,
                height: 1,
                fontWeight: FontWeight.w900,
                color: Color(0xFFEC8A24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
