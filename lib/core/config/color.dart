import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.green;
  static const Color secondaryColor = Colors.greenAccent;
  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
  );
}
