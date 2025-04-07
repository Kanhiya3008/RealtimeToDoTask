import 'package:flutter/material.dart';
import 'package:todoassignment/theme/app_text_style.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1DA1F2); // Example primary color
  static const Color backgroundColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,

    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: AppTextStyles.appBarTitle,
      contentTextStyle: AppTextStyles.bodyText,
    ),

    // Define default TextTheme
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1, // H1
      titleLarge: AppTextStyles.heading2, // H2
      bodyMedium: AppTextStyles.bodyText, // Body text
      labelLarge: AppTextStyles.buttonText, // Button text
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      titleTextStyle: AppTextStyles.heading2.copyWith(color: Colors.white),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: primaryColor),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.buttonText,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: AppTextStyles.buttonText.copyWith(color: primaryColor),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor),
        textStyle: AppTextStyles.buttonText.copyWith(color: primaryColor),
      ),
    ),
  );
}
