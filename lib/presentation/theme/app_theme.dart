import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.textDark,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textDark,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
        bodySmall: TextStyle(
          color: AppColors.textGrey,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
        labelLarge: TextStyle(
          color: AppColors.darkGreen,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).copyWith(
      titleLarge: GoogleFonts.bricolageGrotesque(
        color: AppColors.darkGreen,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.1,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.mapGreen,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkGreen,
        brightness: Brightness.light,
        surface: Colors.white,
      ),
      textTheme: textTheme,
    );
  }
}
