import 'package:flutter/material.dart';

import '../../../../../core/style/colors.dart';

class LexiTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onClear;
  final VoidCallback? onSearch;
  final bool isError;
  final double height;

  const LexiTextField({
    super.key,
    required this.controller,
    required this.height,
    this.hintText = "단어 입력",
    this.onClear,
    this.onSearch,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = (height * 0.32);
    final iconSize = (height * 0.42);
    final verticalPadding = (height * 0.22);

    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        onEditingComplete: () {
          onSearch?.call();
        },
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              "assets/images/ic_paw.png",
              width: iconSize,
              height: iconSize,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: onClear,
            child: Icon(
              Icons.cancel,
              size: iconSize,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: verticalPadding,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isError ? Colors.red : const Color(0xFFB8B0AA),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isError ? Colors.red : AppColors.primary,
              width: 1.8,
            ),
          ),
        ),
      ),
    );
  }
}