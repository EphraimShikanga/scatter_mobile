import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.inter(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: GoogleFonts.jetBrainsMono(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.jetBrainsMono(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
