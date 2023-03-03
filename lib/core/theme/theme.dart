import 'package:flutter/material.dart';
import 'package:mal_clone/core/config/color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    // colorScheme: AppColors.lightColorScheme,
    useMaterial3: true,
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    // colorScheme: AppColors.darkColorScheme,
    useMaterial3: true,
    brightness: Brightness.dark,
  );
}
