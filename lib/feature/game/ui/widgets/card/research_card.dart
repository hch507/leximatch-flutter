
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/hint_result_dialog_style.dart';

class MySearchResultCard extends StatelessWidget {
  final String input;
  final String similarity;
  final String rank;

  final bool showSearchIcon;

  final double height;
  final HintResultDialogStyle style;

  const MySearchResultCard({
    super.key,
    required this.input,
    required this.similarity,
    required this.rank,

    this.showSearchIcon = true,
    required this.style,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {

    final titleFontSize =
        height * 0.20;

    final valueFontSize =
        height * 0.22;

    final iconSize =
        height * 0.5;

    final borderRadius =
        height * 0.3;

    return Container(
      height: height,

      padding: EdgeInsets.symmetric(
        horizontal: height * 0.3,
      ),

      decoration: BoxDecoration(
        color: style.cardBackgroundColor,

        borderRadius: BorderRadius.circular(
          borderRadius,
        ),

        border: Border.all(
          color: style.cardBorderColor,
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

      child: Row(
        children: [

          if (showSearchIcon) ...[
            Image.asset(
              'assets/images/ic_research.png',
              width: iconSize,
              height: iconSize,
            ),

            SizedBox(
              width: height * 0.25,
            ),
          ],

          Expanded(
            child: _ResultColumn(
              title: '단어',
              value: input,
              titleFontSize: titleFontSize,
              valueFontSize: valueFontSize,
              center: true,
              valueColor: style.cardPointTextColor,
            ),
          ),

          VerticalDivider(
            width: height * 0.2,
            thickness: 1.4,
            color: style.cardDividerColor,
            indent: height * 0.25,
            endIndent: height * 0.25,
          ),

          Expanded(
            child: _ResultColumn(
              title: '유사도',
              value: similarity,
              center: true,
              titleFontSize: titleFontSize,
              valueFontSize: valueFontSize,
              valueColor: style.cardPointTextColor,
            ),
          ),

          VerticalDivider(
            width: height * 0.2,
            thickness: 1.4,
            color: style.cardDividerColor,
            indent: height * 0.25,
            endIndent: height * 0.25,
          ),

          Expanded(
            child: _ResultColumn(
              title: '순위',
              value: rank,
              center: true,
              titleFontSize: titleFontSize,
              valueFontSize: valueFontSize,
              valueColor: style.cardPointTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultColumn extends StatelessWidget {
  final String title;
  final String value;

  final bool center;

  final Color valueColor;
  final double titleFontSize;
  final double valueFontSize;

  const _ResultColumn({
    required this.title,
    required this.value,
    required this.valueColor,
    required this.titleFontSize,
    required this.valueFontSize,

    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment:
      center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,

      children: [

        Text(
          title,

          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF4D4D4D),
          ),
        ),

        SizedBox(
          height: titleFontSize * 0.2,
        ),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
            fontSize: valueFontSize,
            fontWeight: FontWeight.w900,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}