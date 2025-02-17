import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme colors for homeowner users
class HomeownerColors {
  static const primary = Color(0xFFFFA000); // Amber primary color
  static const onPrimary = Colors.white;
  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const error = Color(0xFFDC2626);
  static const onBackground = Color(0xFF1E293B);
  static const onSurface = Color(0xFF1E293B);
  static const onError = Colors.white;
}

/// Theme colors for professional users
class ProfessionalColors {
  static const primary = Color(0xFFF9A8D4); // Pink pastel primary color
  static const onPrimary = Colors.white;
  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const error = Color(0xFFDC2626);
  static const onBackground = Color(0xFF1E293B);
  static const onSurface = Color(0xFF1E293B);
  static const onError = Colors.white;
}

/// App theme data
class AppTheme {
  static ThemeData getThemeForUserType(String userType) {
    final colors = userType == 'professional'
        ? ProfessionalColors.primary
        : HomeownerColors.primary;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: colors,
        onPrimary: Colors.white,
        background: HomeownerColors.background,
        surface: HomeownerColors.surface,
        error: HomeownerColors.error,
        onBackground: HomeownerColors.onBackground,
        onSurface: HomeownerColors.onSurface,
        onError: HomeownerColors.onError,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HomeownerColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colors,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: HomeownerColors.error,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: HomeownerColors.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: colors,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: colors,
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
