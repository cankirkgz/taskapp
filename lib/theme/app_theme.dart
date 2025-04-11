import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textPrimary),
      ),
    );
  }
}
