import 'dart:ui';

import '../../../style/colors.dart';
import 'lexi_game_button_type.dart';

import 'package:flutter/material.dart';

import 'lexi_game_button_type.dart';

class LexiButtonStyle {
  final List<Color> normalColors;
  final List<Color> pressedColors;

  final Color borderColor;
  final Color pressedBorderColor;

  final Color shadowColor;
  final Color strokeColor;

  const LexiButtonStyle({
    required this.normalColors,
    required this.pressedColors,
    required this.borderColor,
    required this.pressedBorderColor,
    required this.shadowColor,
    required this.strokeColor,
  });

  static LexiButtonStyle of(LexiButtonType type) {
    switch (type) {
      case LexiButtonType.legend:
        return const LexiButtonStyle(
          normalColors: [
            Color(0xFFFFD84A),
            Color(0xFFFFA800),
          ],
          pressedColors: [
            Color(0xFFFFB800),
            Color(0xFFE69200),
          ],
          borderColor: Color(0xFFD89200),
          pressedBorderColor: Color(0xFFB87400),
          shadowColor: Color(0xFF8A5700),
          strokeColor: Color(0xFFC88400),
        );

      case LexiButtonType.epic:
        return const LexiButtonStyle(
          normalColors: [
            Color(0xFFB875FF),
            Color(0xFF8E45E8),
          ],
          pressedColors: [
            Color(0xFF9E55E6),
            Color(0xFF7430C8),
          ],
          borderColor: Color(0xFF6F35D6),
          pressedBorderColor: Color(0xFF5725B0),
          shadowColor: Color(0xFF3D167F),
          strokeColor: Color(0xFF6F35D6),
        );

      case LexiButtonType.rare:
        return const LexiButtonStyle(
          normalColors: [
            Color(0xFF58B8FF),
            Color(0xFF238DFF),
          ],
          pressedColors: [
            Color(0xFF369EEF),
            Color(0xFF1677D2),
          ],
          borderColor: Color(0xFF1677D2),
          pressedBorderColor: Color(0xFF0F5FA8),
          shadowColor: Color(0xFF084C8C),
          strokeColor: Color(0xFF1677D2),
        );

      case LexiButtonType.normal:
        return const LexiButtonStyle(
          normalColors: [
            Color(0xFFD7A36D),
            Color(0xFFB7834A),
          ],
          pressedColors: [
            Color(0xFFC18A52),
            Color(0xFF9B6635),
          ],
          borderColor: Color(0xFF8A5A2B),
          pressedBorderColor: Color(0xFF6F441F),
          shadowColor: Color(0xFF5A3318),
          strokeColor: Color(0xFF8A5A2B),
        );

      case LexiButtonType.light:
        return const LexiButtonStyle(
          normalColors: [
            Color(0xFFB9D98D),
            Color(0xFF8DBB67),
          ],
          pressedColors: [
            Color(0xFFA0C875),
            Color(0xFF729D55),
          ],
          borderColor: Color(0xFF7EA85F),
          pressedBorderColor: Color(0xFF5E8F55),
          shadowColor: Color(0xFF4B7044),
          strokeColor: Color(0xFF7EA85F),
        );
      case LexiButtonType.blue:
        return const LexiButtonStyle(
          normalColors: [
            AppColors.blueButtonStart,
            AppColors.blueButtonEnd,
          ],

          pressedColors: [
            AppColors.blueButtonPressedStart,
            AppColors.blueButtonPressedEnd,
          ],

          borderColor: AppColors.blueButtonBorder,
          pressedBorderColor:
          AppColors.blueButtonPressedBorder,

          shadowColor: AppColors.blueButtonShadow,

          strokeColor: AppColors.blueButtonStroke,
        );

      case LexiButtonType.orange:
        return const LexiButtonStyle(
          normalColors: [
            AppColors.orangeButtonStart,
            AppColors.orangeButtonEnd,
          ],

          pressedColors: [
            AppColors.orangeButtonPressedStart,
            AppColors.orangeButtonPressedEnd,
          ],

          borderColor: AppColors.orangeButtonBorder,

          pressedBorderColor:
          AppColors.orangeButtonPressedBorder,

          shadowColor: AppColors.orangeButtonShadow,

          strokeColor: AppColors.orangeButtonStroke,
        );
    }
  }
}