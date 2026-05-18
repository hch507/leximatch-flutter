import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/game_dto.dart';
import '../../style/rank_style.dart';

class Top5ResultCard extends StatelessWidget {
  final GameDto item;
  final int rank;

  const Top5ResultCard({
    super.key,
    required this.item,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final style = RankStyle.of(rank);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        final inputFontSize = height * 0.20;
        final valueFontSize = height * 0.20;

        return SizedBox.expand(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: style.backgroundColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: style.borderColor,
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: height * 0.4,
                  child: Image.asset(
                    style.medalAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 3,
                  child: Text(
                    item.userInput,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: inputFontSize,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF222222),
                    ),
                  ),
                ),
                VerticalDivider(
                  width: height * 0.2,
                  thickness: 1.4,
                  color: style.dividerColor,
                  indent: height * 0.25,
                  endIndent: height * 0.25,
                ),
                Expanded(
                  flex: 3,
                  child: _CardText(
                    value: item.dist.toString(),
                    valueColor: style.pointColor,
                    center: true,
                    valueFontSize: valueFontSize,
                  ),
                ),
                VerticalDivider(
                  width: height * 0.2,
                  thickness: 1.4,
                  color: style.dividerColor,
                  indent: height * 0.25,
                  endIndent: height * 0.25,
                ),
                Expanded(
                  flex: 3,
                  child: _CardText(
                    value: '${item.ranking} 위',
                    valueColor: style.pointColor,
                    center: true,
                    valueFontSize: valueFontSize,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CardText extends StatelessWidget {
  final String value;
  final Color valueColor;
  final bool center;

  final double valueFontSize;

  const _CardText({
    required this.value,
    required this.valueColor,
    required this.valueFontSize,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: valueFontSize,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
