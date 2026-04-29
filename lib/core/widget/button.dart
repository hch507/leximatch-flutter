import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leximatch/core/widget/text.dart';

import '../style/colors.dart';

class PressableImageButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;

  const PressableImageButton({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<PressableImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<PressableImageButton> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) {
        setState(() => scale = 1.0);
        widget.onTap();
      },
      onTapCancel: () => setState(() => scale = 1.0),
      child: Transform.scale(
        scale: scale,
        child: Image.asset(
          widget.imagePath,
          width: 56,
          height: 56,
        ),
      ),
    );
  }
}

class LexiGameButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool enabled;

  const LexiGameButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.enabled = true,
  });

  @override
  State<LexiGameButton> createState() => _LexiGameButtonState();
}

class _LexiGameButtonState extends State<LexiGameButton> {
  bool _pressed = false;

  bool get _canTap => widget.enabled && widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final colors = !_canTap
        ? [
      AppColors.border,
      AppColors.textSecondary.withOpacity(0.5),
    ]
        : _pressed
        ? const [
      AppColors.buttonPressedStart,
      AppColors.buttonPressedEnd,
    ]
        : const [
      AppColors.buttonPrimaryStart,
      AppColors.buttonPrimaryEnd,
    ];

    return GestureDetector(
      onTapDown: _canTap ? (_) => setState(() => _pressed = true) : null,
      onTapUp: _canTap ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: _canTap ? () => setState(() => _pressed = false) : null,
      onTap: _canTap ? widget.onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.translationValues(0, _pressed ? 3 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: _pressed
              ? const [
            BoxShadow(
              color: Color(0xFF9B4D00),
              offset: Offset(0, 1),
              blurRadius: 0,
            ),
          ]
              : const [
            BoxShadow(
              color: Color(0xFF9B4D00),
              offset: Offset(0, 5),
              blurRadius: 0,
            ),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 6),
              blurRadius: 4,
            ),
          ],
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
            border: Border.all(
              color: !_canTap
                  ? AppColors.textSecondary
                  : _pressed
                  ? AppColors.buttonPressedBorder
                  : AppColors.buttonBorder,
              width: 2,
            ),
          ),
          child: StrokeText(
            widget.text,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            strokeColor: AppColors.primary,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}