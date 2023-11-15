import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

/// defines the custom themes.
///
/// customizes theme for [Colors], [TextTheme], [PopupMenuThemeData]
class EBTheme {
  EBTheme._();

  static const baseTextStyle = TextStyle(fontFamily: EBTypography.fontFamily);

  static TextTheme buildTextTheme() {
    return const TextTheme(
      bodyLarge: baseTextStyle,
      bodyMedium: baseTextStyle,
      bodySmall: baseTextStyle,
      displayLarge: baseTextStyle,
      displayMedium: baseTextStyle,
      displaySmall: baseTextStyle,
      headlineLarge: baseTextStyle,
      headlineMedium: baseTextStyle,
      headlineSmall: baseTextStyle,
      labelLarge: baseTextStyle,
      labelMedium: baseTextStyle,
      labelSmall: baseTextStyle,
      titleLarge: baseTextStyle,
      titleMedium: baseTextStyle,
      titleSmall: baseTextStyle,
    );
  }

  static ThemeData data() {
    const borderRadius = 8.0;
    const scrollbarRadius = 100.0;
    const scrollbarMargin = 5.0;

    return ThemeData(
      primarySwatch: EBColor.primary,
      textTheme: buildTextTheme(),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: TextStyle(
          fontFamily: EBTypography.fontFamily,
          fontSize: EBFontSize.label,
          fontWeight: EBFontWeight.regular,
          color: EBColor.primary,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: EBColor.primary, width: 1.0),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(
          fontFamily: EBTypography.fontFamily,
          fontSize: EBFontSize.label,
          fontWeight: EBFontWeight.regular,
          color: EBColor.light,
        ),
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        backgroundColor: EBColor.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: EBColor.dark),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: EBColor.primary),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      scrollbarTheme: const ScrollbarThemeData(
        radius: Radius.circular(scrollbarRadius),
        crossAxisMargin: scrollbarMargin,
        mainAxisMargin: scrollbarMargin,
      ),
    );
  }
}
