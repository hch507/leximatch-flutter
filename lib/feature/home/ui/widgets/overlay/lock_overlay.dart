import 'package:flutter/material.dart';

class LockOverlay extends StatelessWidget {
  final double iconSize;   // 아이콘 크기 (기본 48)
  final double fontSize;   // 텍스트 크기 (기본 18)
  final double spacing;
  const LockOverlay({
    required this.message,
    this.iconSize = 48,
    this.fontSize = 18,
    this.spacing = 12,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.withOpacity(0.65),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock,
              size: iconSize,
              color: Colors.white,
            ),
            SizedBox(height: spacing),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
