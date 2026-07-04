import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextTheme textTheme(Brightness brightness) {
    final textColor = brightness == Brightness.dark
        ? AppColors.textPrimary
        : AppColors.matteBlack;

    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.inter(
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.inter(
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.inter(
        color: textColor,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: GoogleFonts.jetBrainsMono(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.jetBrainsMono(
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
