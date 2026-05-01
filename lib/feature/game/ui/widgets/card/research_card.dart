import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchResultCard extends StatelessWidget {
  final String input;
  final String similarity;
  final String rank;

  const MySearchResultCard({
    super.key,
    required this.input,
    required this.similarity,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 18),
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
      child: Row(/**/
        children: [
          Image.asset(
            'assets/images/ic_research.png',
            width: 45,
            height: 45,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _ResultColumn(
              title: '단어',
              value: input,
            ),
          ),
          const VerticalDivider(
            width: 10,
            thickness: 1.4,
            color: Color(0xFFB7DDF6),
            indent: 18,
            endIndent: 18,
          ),
          Expanded(
            child: _ResultColumn(
              title: '유사도',
              value: similarity,
              center: true,
            ),
          ),
          const VerticalDivider(
            width: 24,
            thickness: 1.4,
            color: Color(0xFFB7DDF6),
            indent: 18,
            endIndent: 18,
          ),
          Expanded(
            child: _ResultColumn(
              title: '순위',
              value: '$rank',
              center: true,
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

  const _ResultColumn({
    required this.title,
    required this.value,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Color(0xFF4D4D4D),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1677D2),
          ),
        ),
      ],
    );
  }
}
