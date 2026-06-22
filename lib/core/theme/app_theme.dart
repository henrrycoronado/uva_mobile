import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.lightSecondary,
        surface: AppColors.lightNeutral,
        onSurface: AppColors.lightText,
      ),
      scaffoldBackgroundColor: AppColors.lightNeutral,
      textTheme: _textTheme(AppColors.lightText),
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.darkSecondary,
        surface: AppColors.darkNeutral,
        onSurface: AppColors.darkText,
      ),
      scaffoldBackgroundColor: AppColors.darkNeutral,
      textTheme: _textTheme(AppColors.darkText),
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      // Headlines and Titles use Space Grotesk
      displayLarge: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),

      // Labels and Buttons use Space Grotesk
      labelLarge: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),

      // Body text uses Inter
      bodyLarge: GoogleFonts.inter(color: textColor),
      bodyMedium: GoogleFonts.inter(color: textColor),
      bodySmall: GoogleFonts.inter(color: textColor),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.darkSecondary,
        textStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
