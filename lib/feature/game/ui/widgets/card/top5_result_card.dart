import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/dto/game_dto.dart';
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

    return SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: style.borderColor,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [

            const SizedBox(width: 14),

            Expanded(
              flex: 3,
              child: _CardText(
                label: '단어:',
                value: item.userInput,
                valueColor: const Color(0xFF222222),
              ),
            ),

            const VerticalDivider(
              width: 10,
              thickness: 1.4,
              color: Color(0xFFE7D8C0),
              indent: 18,
              endIndent: 18,
            ),

            Expanded(
              flex: 3,
              child: _CardText(
                label: '유사도',
                value: item.dist.toString(),
                valueColor: style.pointColor,
                center: true,
              ),
            ),

            const VerticalDivider(
              width: 10,
              thickness: 1.4,
              color: Color(0xFFE7D8C0),
              indent: 18,
              endIndent: 18,
            ),
            Expanded(
              flex: 3,
              child: _CardText(
                label: '순위',
                value: '${item.ranking} 위',
                valueColor: style.pointColor,
                center: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardText extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final bool center;

  const _CardText({
    required this.label,
    required this.value,
    required this.valueColor,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF3F3A35),
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}