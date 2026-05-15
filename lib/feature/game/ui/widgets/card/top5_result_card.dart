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

        final inputFontSize = height * 0.30;
        final labelFontSize = height * 0.22;
        final valueFontSize = height * 0.26;

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


                Expanded(
                  flex: 3,
                  child: _CardText(
                    label: '유사도',
                    value: item.dist.toString(),
                    valueColor: style.pointColor,
                    center: true,
                    labelFontSize: labelFontSize,
                    valueFontSize: valueFontSize,
                  ),
                ),



                Expanded(
                  flex: 3,
                  child: _CardText(
                    label: '순위',
                    value: '${item.ranking} 위',
                    valueColor: style.pointColor,
                    center: true,
                    labelFontSize: labelFontSize,
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
  final String label;
  final String value;
  final Color valueColor;
  final bool center;

  final double labelFontSize;
  final double valueFontSize;

  const _CardText({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.labelFontSize,
    required this.valueFontSize,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF3F3A35),
          ),
        ),
        const SizedBox(height: 3),
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
