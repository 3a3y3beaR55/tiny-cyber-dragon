import 'package:flutter/material.dart';

import 'animation_constants.dart';
import 'color_tokens.dart';
import 'spacing.dart';
import 'typography.dart';

/// AppTheme — assembles tokens into Flutter [ThemeData].
///
/// Purpose: the only file that touches [ThemeData]. Widgets style themselves
/// from `Theme.of(context)` plus the token files; they never construct
/// ad-hoc colors or text styles.
///
/// Dark is the primary theme (cyberpunk aesthetic). [light] exists so
/// ThemeMode switching works from day one; it will be polished in a future
/// sprint. New themes = new static getters here, nothing else changes.
abstract final class AppTheme {
  static ThemeData get dark => _build(dark: true);

  static ThemeData get light => _build(dark: false);

  static ThemeData _build({required bool dark}) {
    final ColorScheme scheme = dark
        ? const ColorScheme.dark(
            primary: ColorTokens.primary,
            onPrimary: ColorTokens.onPrimary,
            secondary: ColorTokens.accent,
            onSecondary: ColorTokens.onPrimary,
            surface: ColorTokens.surfaceDark,
            onSurface: ColorTokens.textPrimaryDark,
            surfaceContainerHighest: ColorTokens.surfaceRaisedDark,
            outline: ColorTokens.borderDark,
            error: Color(0xFFF87171),
          )
        : const ColorScheme.light(
            primary: ColorTokens.primaryDim,
            onPrimary: Colors.white,
            secondary: ColorTokens.accent,
            surface: ColorTokens.surfaceLight,
            onSurface: ColorTokens.textPrimaryLight,
            outline: ColorTokens.borderLight,
          );

    final TextTheme textTheme = AppTypography.textTheme(dark: dark);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor:
          dark ? ColorTokens.backgroundDark : ColorTokens.backgroundLight,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.comfortable,
      dividerColor: scheme.outline,
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dark
            ? ColorTokens.surfaceRaisedDark
            : ColorTokens.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor:
            dark ? ColorTokens.surfaceDark : ColorTokens.surfaceLight,
        indicatorColor: ColorTokens.primary.withValues(alpha: 0.16),
        selectedIconTheme: const IconThemeData(color: ColorTokens.primary),
        unselectedIconTheme: IconThemeData(
          color: dark
              ? ColorTokens.textSecondaryDark
              : ColorTokens.textSecondaryLight,
        ),
        selectedLabelTextStyle: textTheme.labelLarge!
            .copyWith(color: ColorTokens.primary),
        unselectedLabelTextStyle: textTheme.labelLarge!.copyWith(
          color: dark
              ? ColorTokens.textSecondaryDark
              : ColorTokens.textSecondaryLight,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: AnimationConstants.normal,
        textStyle: textTheme.bodyMedium!
            .copyWith(color: ColorTokens.textPrimaryDark),
        decoration: BoxDecoration(
          color: ColorTokens.surfaceRaisedDark,
          borderRadius: BorderRadius.circular(Spacing.radiusSm),
          border: Border.all(color: ColorTokens.borderDark),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: dark
            ? ColorTokens.surfaceRaisedDark
            : ColorTokens.textPrimaryLight,
        contentTextStyle: textTheme.bodyLarge!
            .copyWith(color: ColorTokens.textPrimaryDark),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusSm),
        ),
      ),
    );
  }
}
