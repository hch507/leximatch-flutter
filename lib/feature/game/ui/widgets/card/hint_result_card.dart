import 'package:flutter/material.dart';

class HintResultCard extends StatelessWidget {
  final String input;
  final String similarity;
  final String rank;

  final double minHeight;

  final Color backgroundColor;
  final Color borderColor;
  final Color dividerColor;
  final Color titleColor;
  final Color pointTextColor;

  const HintResultCard({
    super.key,
    required this.input,
    required this.similarity,
    required this.rank,

    required this.backgroundColor,
    required this.borderColor,
    required this.dividerColor,
    required this.titleColor,
    required this.pointTextColor,

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
        color: backgroundColor,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: borderColor,
          width: 2,
        ),

        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.18),
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
            titleColor: titleColor,
            valueColor: pointTextColor,
          ),

          const SizedBox(height: 10),

          Divider(
            height: 1,
            thickness: 1,
            color: dividerColor,
          ),

          const SizedBox(height: 10),

          _ResultRow(
            title: '유사도',
            value: similarity,
            titleFontSize: titleFontSize,
            valueFontSize: valueFontSize,
            titleColor: titleColor,
            valueColor: pointTextColor,
          ),

          const SizedBox(height: 10),

          Divider(
            height: 1,
            thickness: 1,
            color: dividerColor,
          ),

          const SizedBox(height: 10),

          _ResultRow(
            title: '순위',
            value: rank,
            titleFontSize: titleFontSize,
            valueFontSize: valueFontSize,
            titleColor: titleColor,
            valueColor: pointTextColor,
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

  final Color titleColor;
  final Color valueColor;

  const _ResultRow({
    required this.title,
    required this.value,
    required this.titleFontSize,
    required this.valueFontSize,
    required this.titleColor,
    required this.valueColor,
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
              color: titleColor,
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
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}