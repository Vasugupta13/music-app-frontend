import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/res/color.dart';

final themeControllerProvider =
    StateNotifierProvider<ThemeChanger, ThemeData>((ref) {
  return ThemeChanger();
});

class ThemeChanger extends StateNotifier<ThemeData> {
  bool _isDarkMode = false;
  Color _borderColor = AppColors.kBlack;

  ThemeChanger() : super(_buildLightTheme());

  Color get borderColor => _borderColor;
  bool get isDark => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _borderColor = _isDarkMode ? AppColors.kWhite : AppColors.kBlack;
    state = _isDarkMode ? _buildDarkTheme() : _buildLightTheme();
  }

  static ThemeData _buildLightTheme() {
    return ThemeData(
      fontFamily: "Inter",
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(AppColors.kBlack),
        ),
      ),
      scaffoldBackgroundColor: AppColors.kPrimaryBackground,
      secondaryHeaderColor: AppColors.kBlack,
      primaryColor: AppColors.kBlack,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(AppColors.kWhite),
          backgroundColor: MaterialStateProperty.all(AppColors.kBlack),
        ),
      ),
    );
  }

  // Builds the dark theme
  static ThemeData _buildDarkTheme() {
    return ThemeData(
      fontFamily: "Inter",
      iconTheme: const IconThemeData(color: AppColors.kWhite),
      scaffoldBackgroundColor: AppColors.kBlack,
      primaryColor: AppColors.kWhite,
      secondaryHeaderColor: AppColors.kWhite,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
      ).apply(
        bodyColor: AppColors.kWhite,
        displayColor: AppColors.kWhite,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(AppColors.kBlack),
          backgroundColor: MaterialStateProperty.all(AppColors.kWhite),
        ),
      ),
    );
  }
}
