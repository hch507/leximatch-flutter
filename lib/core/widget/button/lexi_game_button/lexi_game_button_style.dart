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