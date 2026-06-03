import 'package:flutter/material.dart';

class PressableImageButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;

  const PressableImageButton({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<PressableImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<PressableImageButton> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) {
        setState(() => scale = 1.0);
        widget.onTap();
      },
      onTapCancel: () => setState(() => scale = 1.0),
      child: Transform.scale(
        scale: scale,
        child: Image.asset(
          widget.imagePath,
          width: 56,
          height: 56,
        ),
      ),
    );
  }
}
