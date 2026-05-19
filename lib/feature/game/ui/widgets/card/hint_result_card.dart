import 'package:flutter/material.dart';

class HintResultCard extends StatelessWidget {
  final String input;
  final String similarity;
  final String rank;
  final double minHeight;

  const HintResultCard({
    super.key,
    required this.input,
    required this.similarity,
    required this.rank,
    this.minHeight = 120,
  });

  @override
  Widget build(BuildContext context) {
    const titleFontSize = 13.0;
    const valueFontSize = 14.0;

    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF9BD4FF),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ResultRow(
            title: '단어',
            value: input,
            titleFontSize: titleFontSize,
            valueFontSize: valueFontSize,
          ),

          const SizedBox(height: 10),

          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFB7DDF6),
          ),

          const SizedBox(height: 10),

          _ResultRow(
            title: '유사도',
            value: similarity,
            titleFontSize: titleFontSize,
            valueFontSize: valueFontSize,
          ),

          const SizedBox(height: 10),

          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFB7DDF6),
          ),

          const SizedBox(height: 10),

          _ResultRow(
            title: '순위',
            value: rank,
            titleFontSize: titleFontSize,
            valueFontSize: valueFontSize,
          ),
        ],
      ),
    );
  }
}
class _ResultRow extends StatelessWidget {
  final String title;
  final String value;

  final double titleFontSize;
  final double valueFontSize;

  const _ResultRow({
    required this.title,
    required this.value,
    required this.titleFontSize,
    required this.valueFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 52,
          child: Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF4D4D4D),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: valueFontSize,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1677D2),
            ),
          ),
        ),
      ],
    );
  }
}
