import 'package:flutter/material.dart';

import 'color_tokens.dart';

/// AppTypography — the product type scale.
///
/// Purpose: one place defines every text style. Uses the platform system
/// font (Segoe UI on Windows) for a native feel and zero asset weight; a
/// custom display font can be introduced later by changing only this file.
///
/// Accessibility: sizes respect the OS text-scale factor automatically
/// because widgets consume these through [TextTheme].
abstract final class AppTypography {
  static const String? _fontFamily = null; // platform default

  static TextTheme textTheme({required bool dark}) {
    final Color primary =
        dark ? ColorTokens.textPrimaryDark : ColorTokens.textPrimaryLight;
    final Color secondary =
        dark ? ColorTokens.textSecondaryDark : ColorTokens.textSecondaryLight;

    return TextTheme(
      // Hero numbers / splash moments.
      displayMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: primary,
      ),
      // Screen titles.
      headlineMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: primary,
      ),
      // Section headers.
      titleLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      // Card titles.
      titleMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      // Primary reading text.
      bodyLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: primary,
      ),
      // Secondary/supporting text.
      bodyMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13.5,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: secondary,
      ),
      // Captions, badges, metadata.
      labelSmall: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: secondary,
      ),
      // Buttons.
      labelLarge: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: primary,
      ),
    );
  }
}
