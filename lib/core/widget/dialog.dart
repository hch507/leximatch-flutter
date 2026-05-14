
import 'package:flutter/material.dart';
import 'package:leximatch/core/style/colors.dart';

class LexiDialog extends StatelessWidget {
  final Widget child;

  final String titleImagePath;
  final double titleWidth;

  final Color borderColor;
  final Color backgroundColor;

  const LexiDialog({
    super.key,
    required this.child,
    required this.titleImagePath,

    this.titleWidth = 150,

    this.borderColor = AppColors.orangeDialogBorder,

    this.backgroundColor = AppColors.dialogBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,

      insetPadding: const EdgeInsets.symmetric(
        horizontal: 28,
      ),

      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,

        children: [

          // 메인 카드
          Container(
            margin: const EdgeInsets.only(top: 50),

            padding: const EdgeInsets.fromLTRB(
              20,
              45,
              20,
              24,
            ),

            decoration: BoxDecoration(
              color: backgroundColor,

              borderRadius: BorderRadius.circular(32),

              border: Border.all(
                color: borderColor,
                width: 4,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: child,
          ),

          // 상단 타이틀
          Positioned(
            top: 0,

            child: Image.asset(
              titleImagePath,
              width: titleWidth,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}