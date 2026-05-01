import 'dart:ui';

class RankStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color pointColor;
  final List<Color> badgeColors;

  const RankStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.pointColor,
    required this.badgeColors,
  });

  static RankStyle of(int rank) {
    switch (rank) {
      case 1:
        return const RankStyle(
          backgroundColor: Color(0xFFFFF8E5),
          borderColor: Color(0xFFFFC94A),
          pointColor: Color(0xFFFF8A00),
          badgeColors: [Color(0xFFFFD84D), Color(0xFFFF9F1A)],
        );
      case 2:
        return const RankStyle(
          backgroundColor: Color(0xFFEAF7FF),
          borderColor: Color(0xFF9BD4FF),
          pointColor: Color(0xFF1677D2),
          badgeColors: [Color(0xFFC9E8FF), Color(0xFF6FA9D8)],
        );
      case 3:
        return const RankStyle(
          backgroundColor: Color(0xFFFFF1E8),
          borderColor: Color(0xFFFFB28A),
          pointColor: Color(0xFFE86C24),
          badgeColors: [Color(0xFFFFB066), Color(0xFFE07828)],
        );
      default:
        return const RankStyle(
          backgroundColor: Color(0xFFFFFCF5),
          borderColor: Color(0xFFE1D8C9),
          pointColor: Color(0xFF4D5B68),
          badgeColors: [Color(0xFF9BA9B2), Color(0xFF5F6D78)],
        );
    }
  }
}