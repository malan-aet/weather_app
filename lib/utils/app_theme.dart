import 'package:flutter/material.dart';
import 'package:weather_app/utils/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: AppColors.primaryColor,
      useMaterial3: true,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: AppColors.primaryColor,
      useMaterial3: true,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    );
  }
}
