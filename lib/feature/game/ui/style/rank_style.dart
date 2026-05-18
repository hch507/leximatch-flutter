import 'dart:ui';

class RankStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color pointColor;
  final Color dividerColor;
  final String medalAsset;

  const RankStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.pointColor,
    required this.dividerColor,
    required this.medalAsset
  });

  static RankStyle of(int rank) {
    switch (rank) {
      case 1:
        return const RankStyle(
          backgroundColor: Color(0xFFFFF8E5),
          borderColor: Color(0xFFFFC94A),
          pointColor: Color(0xFFFF8A00),
          dividerColor: Color(0xFFFFC94A),
          medalAsset: "assets/images/ic_rank_1.png",
        );
      case 2:
        return const RankStyle(
          backgroundColor: Color(0xFFEAF7FF),
          borderColor: Color(0xFF9BD4FF),
          pointColor: Color(0xFF1677D2),
          dividerColor: Color(0xFF9BD4FF),
          medalAsset: "assets/images/ic_rank_2.png",
        );
      case 3:
        return const RankStyle(
          backgroundColor: Color(0xFFFFF1E8),
          borderColor: Color(0xFFFFB28A),
          pointColor: Color(0xFFE86C24),
          dividerColor: Color(0xFFFFB28A),
          medalAsset: "assets/images/ic_rank_3.png",
        );
      case 4:
        return const RankStyle(
          backgroundColor: Color(0xFFFFFCF5),
          borderColor: Color(0xFFE1D8C9),
          pointColor: Color(0xFF4D5B68),
          dividerColor: Color(0xFFE1D8C9),
          medalAsset: "assets/images/ic_rank_4.png",
        );
      default:
        return const RankStyle(
          backgroundColor: Color(0xFFFFFCF5),
          borderColor: Color(0xFFE1D8C9),
          pointColor: Color(0xFF4D5B68),
          dividerColor: Color(0xFFE1D8C9),
          medalAsset: "assets/images/ic_rank_5.png",
        );
    }
  }
}