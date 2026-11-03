import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
  textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
    bodyColor: AppColors.textDark,
    displayColor: AppColors.textDark,
  ),
);
