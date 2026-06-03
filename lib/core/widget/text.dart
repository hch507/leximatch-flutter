import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/colors.dart';
class StrokeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;

  const StrokeText(
      this.text, {
        super.key,
        this.fontSize = 18,
        this.fontWeight = FontWeight.bold,
        this.fillColor = Colors.white,
        this.strokeColor = AppColors.orangeButtonPressedBorder,
        this.strokeWidth = 4,
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),

        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}