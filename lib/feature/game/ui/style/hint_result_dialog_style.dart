import 'dart:ui';

import '../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';
class HintResultDialogStyle {
  final Color borderColor;
  final Color pointColor;
  final Color dividerColor;
  final LexiButtonType buttonType;
  // 카드뷰 전용
  final Color cardBackgroundColor;
  final Color cardBorderColor;
  final Color cardDividerColor;
  final Color cardTitleColor;
  final Color cardPointTextColor;

  final String titleAsset;
  final String backgroundAsset;

  const HintResultDialogStyle({
    required this.borderColor,
    required this.pointColor,
    required this.dividerColor,

    required this.cardBackgroundColor,
    required this.cardBorderColor,
    required this.cardDividerColor,
    required this.cardTitleColor,
    required this.cardPointTextColor,
    required this.buttonType,
    required this.titleAsset,
    required this.backgroundAsset,
  });

  static HintResultDialogStyle of(int ranking) {

    // LEGEND
    if (ranking <= 10) {
      return const HintResultDialogStyle(
        borderColor: Color(0xFFFFC94A),
        pointColor: Color(0xFFFF8A00),
        dividerColor: Color(0xFFFFD66B),

        cardBackgroundColor: Color(0xFFFFFCF4),
        cardBorderColor: Color(0xFFFFC94A),
        cardDividerColor: Color(0xFFFFE3A3),
        cardTitleColor: Color(0xFF6B4A1E),
        cardPointTextColor: Color(0xFFFF4B91),
        buttonType : LexiButtonType.legend,
        titleAsset: "assets/images/ic_legend_hint_title.png",
        backgroundAsset: "assets/images/legend_hint_background.png",
      );
    }

    // EPIC
    if (ranking <= 50) {
      return const HintResultDialogStyle(
        borderColor: Color(0xFF9B5CFF),
        pointColor: Color(0xFF6F35D6),
        dividerColor: Color(0xFFD6B8FF),

        cardBackgroundColor: Color(0xFFFDF9FF),
        cardBorderColor: Color(0xFFC79BFF),
        cardDividerColor: Color(0xFFE8D6FF),
        cardTitleColor: Color(0xFF5A3C7C),
        cardPointTextColor: Color(0xFF8C3DFF),
        buttonType : LexiButtonType.epic,
        titleAsset: "assets/images/ic_epic_hint_title.png",
        backgroundAsset: "assets/images/epic_hint_background.png",
      );
    }

    // GOOD
    if (ranking <= 100) {
      return const HintResultDialogStyle(
        borderColor: Color(0xFF4DA3FF),
        pointColor: Color(0xFF1677D2),
        dividerColor: Color(0xFFAEDBFF),

        cardBackgroundColor: Color(0xFFF8FCFF),
        cardBorderColor: Color(0xFF9ED1FF),
        cardDividerColor: Color(0xFFD7ECFF),
        cardTitleColor: Color(0xFF3C5E7C),
        cardPointTextColor: Color(0xFF258CFF),
        buttonType : LexiButtonType.rare,
        titleAsset: "assets/images/ic_hint_title.png",
        backgroundAsset: "assets/images/rare_hint_background.png",
      );
    }

    // NORMAL
    if (ranking <= 300) {
      return const HintResultDialogStyle(
        borderColor: Color(0xFFD6B98A),
        pointColor: Color(0xFF8A5A2B),
        dividerColor: Color(0xFFEADCC7),

        cardBackgroundColor: Color(0xFFFFFCF7),
        cardBorderColor: Color(0xFFE7D2AE),
        cardDividerColor: Color(0xFFF1E4CC),
        cardTitleColor: Color(0xFF7A5733),
        cardPointTextColor: Color(0xFFB16A2A),
        buttonType : LexiButtonType.normal,
        titleAsset: "assets/images/ic_normal_hint_title.png",
        backgroundAsset: "assets/images/normal_hint_background.png",
      );
    }

    // LIGHT
    return const HintResultDialogStyle(
      borderColor: Color(0xFFA8C979),
      pointColor: Color(0xFF5E8F55),
      dividerColor: Color(0xFFD6E8BC),

      cardBackgroundColor: Color(0xFFFCFFF8),
      cardBorderColor: Color(0xFFC8DE9E),
      cardDividerColor: Color(0xFFE3F0CC),
      cardTitleColor: Color(0xFF5C7B55),
      cardPointTextColor: Color(0xFF79A86A),
      buttonType : LexiButtonType.light,
      titleAsset: "assets/images/ic_light_hint_title.png",
      backgroundAsset: "assets/images/light_hint_background.png",
    );
  }
}
// class HintResultDialogStyle {
//   final Color borderColor;
//   final Color pointColor;
//   final Color dividerColor;
//   final String titleAsset;
//   final String backgroundAsset;
//
//
//   const HintResultDialogStyle({
//     required this.borderColor,
//     required this.pointColor,
//     required this.dividerColor,
//     required this.titleAsset,
//     required this.backgroundAsset,
//   });
//
//   static HintResultDialogStyle of(int ranking) {
//     if (ranking <= 10) {
//       return const HintResultDialogStyle(
//         borderColor: Color(0xFFFFC94A),
//         pointColor: Color(0xFFFF8A00),
//         dividerColor: Color(0xFFFFD66B),
//         titleAsset: "assets/images/ic_legend_hint_title.png",
//         backgroundAsset: "assets/images/legend_hint_background.png",
//
//       );
//     }
//
//     if (ranking <= 50) {
//       return const HintResultDialogStyle(
//         borderColor: Color(0xFF9B5CFF),
//         pointColor: Color(0xFF6F35D6),
//         dividerColor: Color(0xFFD6B8FF),
//         titleAsset: "assets/images/ic_epic_hint_title.png",
//         backgroundAsset: "assets/images/epic_hint_background.png",
//
//       );
//     }
//
//     if (ranking <= 100) {
//       return const HintResultDialogStyle(
//         borderColor: Color(0xFF4DA3FF),
//         pointColor: Color(0xFF1677D2),
//         dividerColor: Color(0xFFAEDBFF),
//         titleAsset: "assets/images/ic_hint_title.png",
//         backgroundAsset: "assets/images/rare_hint_background.png",
//
//       );
//     }
//
//     if (ranking <= 300) {
//       return const HintResultDialogStyle(
//         borderColor: Color(0xFFD6B98A),
//         pointColor: Color(0xFF8A5A2B),
//         dividerColor: Color(0xFFEADCC7),
//         titleAsset: "assets/images/ic_normal_hint_title.png",
//         backgroundAsset: "assets/images/normal_hint_background.png",
//
//       );
//     }
//
//     return const HintResultDialogStyle(
//       borderColor: Color(0xFFA8C979),
//       pointColor: Color(0xFF5E8F55),
//       dividerColor: Color(0xFFD6E8BC),
//       titleAsset: "assets/images/ic_light_hint_title.png",
//       backgroundAsset: "assets/images/light_hint_background.png",
//
//     );
//   }
// }