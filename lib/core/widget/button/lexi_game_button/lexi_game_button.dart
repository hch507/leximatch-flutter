import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../text.dart';
import 'lexi_game_button_style.dart';
import 'lexi_game_button_type.dart';

class LexiGameButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final LexiButtonType type;

  const LexiGameButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.type = LexiButtonType.orange,
  });

  @override
  State<LexiGameButton> createState() => _LexiGameButtonState();
}

class _LexiGameButtonState extends State<LexiGameButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final style = LexiButtonStyle.of(widget.type);

    final fontSize =
        (widget.height ?? 60) * 0.38;

    final strokeWidth =
        fontSize/5;

    final buttonColors = _pressed
        ? style.pressedColors
        : style.normalColors;

    final borderColor = _pressed
        ? style.pressedBorderColor
        : style.borderColor;

    final shadows = _pressed
        ? [
      BoxShadow(
        color: style.shadowColor,
        offset: const Offset(0, 1),
        blurRadius: 0,
      ),
    ]
        : [
      BoxShadow(
        color: style.shadowColor,
        offset: const Offset(0, 5),
        blurRadius: 0,
      ),
      const BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 6),
        blurRadius: 4,
      ),
    ];

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.translationValues(
          0,
          _pressed ? 3 : 0,
          0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: shadows,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: buttonColors,
            ),
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: StrokeText(
            widget.text,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            strokeColor: style.strokeColor,
            strokeWidth: strokeWidth,
          ),
        ),
      ),
    );
  }
}