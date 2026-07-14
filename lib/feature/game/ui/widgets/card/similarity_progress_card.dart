import 'package:flutter/material.dart';


class SimilarityProgressCard extends StatefulWidget {
  final String word;
  final String rank;

  const SimilarityProgressCard({
    super.key,
    required this.word,
    required this.rank,
  });

  @override
  State<SimilarityProgressCard> createState() => _SimilarityProgressCardState();
}

class _SimilarityProgressCardState extends State<SimilarityProgressCard> {
  double _beginProgress = 0.0;
  double _endProgress = 0.0;

  double get progress {
    if (widget.rank == "+1000") return 0.0;

    final rankValue = int.tryParse(widget.rank);
    if (rankValue == null) return 0.0;
    if (rankValue >= 1000) return 0.0;

    return (1000 - rankValue) / 1000;
  }

  Color get progressColor {
    final r = int.tryParse(widget.rank) ?? 1000;

    if (r <= 10) return const Color(0xFFFFC94A); // LEGEND
    if (r <= 50) return const Color(0xFF9B5CFF); // EPIC
    if (r <= 100) return const Color(0xFF4DA3FF); // GOOD
    if (r <= 300) return const Color(0xFFD6B98A); // NORMAL

    return const Color(0xFFA8C979); // LIGHT
  }

  @override
  void initState() {
    super.initState();
    _endProgress = progress;
  }

  @override
  void didUpdateWidget(covariant SimilarityProgressCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.rank != widget.rank) {
      _beginProgress = _endProgress;
      _endProgress = progress;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double barHeight = 12;
    const double pawSize = 25;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8D9C7),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("🏆", style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              const Text(
                "최고 기록",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEFD8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.word,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFC96C1E),
                  ),
                ),
              ),
              Visibility(
                visible: widget.word != "-",
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFFF8A3D),
                        width: 1.4,
                      ),
                    ),
                    child: Text(
                      widget.rank,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFFF7A00),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: pawSize,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: _beginProgress,
                    end: _endProgress,
                  ),
                  duration: const Duration(milliseconds: 650),
                  curve: Curves.easeOutCubic,
                  builder: (context, animatedProgress, child) {
                    final safeProgress = animatedProgress.clamp(0.0, 1.0);
                    final pawLeft =
                        (constraints.maxWidth - pawSize) * safeProgress;

                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: barHeight,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6E2DC),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: safeProgress,
                          child: Container(
                            height: barHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.lerp(
                                    progressColor,
                                    Colors.white,
                                    0.25,
                                  )!,
                                  progressColor,
                                  Color.lerp(
                                    progressColor,
                                    Colors.black,
                                    0.15,
                                  )!,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: pawLeft,
                          child: Container(
                            width: pawSize,
                            height: pawSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFD56B),
                                  Color(0xFFFFA726),
                                ],
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.pets,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1000+",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5C4635),
                ),
              ),
              Text(
                "TOP 750",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5C4635),
                ),
              ),
              Text(
                "TOP 500",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5C4635),
                ),
              ),
              Text(
                "TOP 250",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5C4635),
                ),
              ),
              Text(
                "정답!",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5C4635),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}