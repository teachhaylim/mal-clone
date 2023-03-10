import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/config/color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    // colorScheme: AppColors.lightColorScheme,
    useMaterial3: true,
    brightness: Brightness.light,
    bottomSheetTheme: BottomSheetThemeData(
      constraints: BoxConstraints(
        maxHeight: Get.size.height * 0.8,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    // colorScheme: AppColors.darkColorScheme,
    useMaterial3: true,
    brightness: Brightness.dark,
    bottomSheetTheme: BottomSheetThemeData(
      constraints: BoxConstraints(
        maxHeight: Get.size.height * 0.8,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    ),
  );
}
