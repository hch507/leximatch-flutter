import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/colors.dart';

class LexiMatchBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final ImageProvider? backgroundImage;

  const LexiMatchBox({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderColor,
    this.backgroundImage,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final appliedPadding = padding ??
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 20,
        );
    return Container(
        padding: appliedPadding,
        decoration: BoxDecoration(
          color: color ?? AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor ?? Colors.white.withOpacity(0.7),
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            )
          ],
          image: backgroundImage != null
              ? DecorationImage(
                  image: backgroundImage!,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: child);

  }
}
