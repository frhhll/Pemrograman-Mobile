import 'package:flutter/material.dart';
import 'package:music_app/models/app_colors.dart';

class AppThemeClass {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      background: const Color.fromARGB(255, 246, 204, 182),
      secondary: const Color.fromARGB(255, 255, 255, 255),
      tertiary: Colors.black,
    ),
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        background: const Color.fromARGB(255, 17, 20, 54),
        secondary: AppColors.pageColor,
        tertiary: Colors.white),
    useMaterial3: true,
  );
}
