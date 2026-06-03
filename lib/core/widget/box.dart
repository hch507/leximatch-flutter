import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/colors.dart';

class LexiMatchBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const LexiMatchBox({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final appliedPadding =
        padding ??
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 20,
            );
    return Container(
        padding: appliedPadding,
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.7),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              )
            ]),
        child: child);
    ;
  }
}
