import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  const AppTextStyles._();

  static TextStyle get displayLg => GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    height: 48 / 40,
    letterSpacing: -0.8,
  );

  static TextStyle get headlineLg => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: -0.32,
  );

  static TextStyle get headlineLgMobile => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
  );

  static TextStyle get titleMd => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
  );

  static TextStyle get bodyMd => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  static TextStyle get bodySm => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );

  static TextStyle get labelCaps => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 16 / 12,
    letterSpacing: 1.2,
  );

  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLg,
    headlineLarge: headlineLg,
    headlineMedium: headlineLgMobile,
    titleMedium: titleMd,
    bodyLarge: bodyMd,
    bodyMedium: bodyMd,
    bodySmall: bodySm,
    labelLarge: labelCaps,
    labelMedium: labelCaps,
  );
}
