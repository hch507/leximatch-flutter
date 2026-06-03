
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        background: AppColors.background,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
      ),

      // 🔥 AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      // 🔥 버튼 ()
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 6,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      // 🔥 카드
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // // 🔥 TextField
      // inputDecorationTheme: InputDecorationTheme(
      //   filled: true,
      //   fillColor: Colors.white,
      //   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: AppColors.secondary),
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: AppColors.primary, width: 2),
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      // ),

      // 🔥 텍스트
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}