import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  // Page
  final Color pageBg;
  final Color pageBgInverse;
  final Color pageOverlayBg;
  final Color pageOverlayPrimary;
  final Color pageOverlaySecondary;
  final Color pageOverlayBackdrop;
  final Color pageDivider;
  final Color pageDividerInverse;

  // Input
  final Color inputBg;
  final Color inputBorder;
  final Color inputBorderHover;
  final Color inputBorderActive;

  // Card
  final Color cardBg;
  final Color cardBgHover;
  final Color cardBorder;
  final Color cardBorderHover;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textQuaternary;
  final Color textInverse;
  final Color textAccent;
  final Color textSuccess;
  final Color textAlert;
  final Color textWarning;
  final Color textError;

  // Button
  final Color buttonPrimary;
  final Color buttonPrimaryBg;
  final Color buttonPrimaryBgHover; // Renamed from primary-g-hover
  final Color buttonSuccessBg;
  final Color buttonSuccessBgHover; // Renamed from success-g-hover
  final Color buttonAlertBg;
  final Color buttonAlertBgHover;
  final Color buttonWarningBg;
  final Color buttonWarningBgHover;
  final Color buttonErrorBg;
  final Color buttonErrorBgHover;
  final Color buttonSecondary;
  final Color buttonSecondaryBg;
  final Color buttonSecondaryBgHover;
  final Color buttonTertiary;
  final Color buttonTertiaryBg;
  final Color buttonTertiaryBgHover;

  // Chip
  final Color chipPrimary;
  final Color chipPrimaryBg;
  final Color chipSuccess;
  final Color chipSuccessBg;
  final Color chipAlert;
  final Color chipAlertBg;
  final Color chipWarning;
  final Color chipWarningBg;
  final Color chipError;
  final Color chipErrorBg;
  final Color chipSecondary;
  final Color chipSecondaryBg;

  const AppColorsExtension({
    // Page
    required this.pageBg,
    required this.pageBgInverse,
    required this.pageOverlayBg,
    required this.pageOverlayPrimary,
    required this.pageOverlaySecondary,
    required this.pageOverlayBackdrop,
    required this.pageDivider,
    required this.pageDividerInverse,

    // Input
    required this.inputBg,
    required this.inputBorder,
    required this.inputBorderHover,
    required this.inputBorderActive,

    // Card
    required this.cardBg,
    required this.cardBgHover,
    required this.cardBorder,
    required this.cardBorderHover,

    // Text
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textQuaternary,
    required this.textInverse,
    required this.textAccent,
    required this.textSuccess,
    required this.textAlert,
    required this.textWarning,
    required this.textError,

    // Button
    required this.buttonPrimary,
    required this.buttonPrimaryBg,
    required this.buttonPrimaryBgHover,
    required this.buttonSuccessBg,
    required this.buttonSuccessBgHover,
    required this.buttonAlertBg,
    required this.buttonAlertBgHover,
    required this.buttonWarningBg,
    required this.buttonWarningBgHover,
    required this.buttonErrorBg,
    required this.buttonErrorBgHover,
    required this.buttonSecondary,
    required this.buttonSecondaryBg,
    required this.buttonSecondaryBgHover,
    required this.buttonTertiary,
    required this.buttonTertiaryBg,
    required this.buttonTertiaryBgHover,

    // Chip
    required this.chipPrimary,
    required this.chipPrimaryBg,
    required this.chipSuccess,
    required this.chipSuccessBg,
    required this.chipAlert,
    required this.chipAlertBg,
    required this.chipWarning,
    required this.chipWarningBg,
    required this.chipError,
    required this.chipErrorBg,
    required this.chipSecondary,
    required this.chipSecondaryBg,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    // Page
    Color? pageBg,
    Color? pageBgInverse,
    Color? pageOverlayBg,
    Color? pageOverlayPrimary,
    Color? pageOverlaySecondary,
    Color? pageOverlayBackdrop,
    Color? pageDivider,
    Color? pageDividerInverse,

    // Input
    Color? inputBg,
    Color? inputBorder,
    Color? inputBorderHover,
    Color? inputBorderActive,

    // Card
    Color? cardBg,
    Color? cardBgHover,
    Color? cardBorder,
    Color? cardBorderHover,

    // Text
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textQuaternary,
    Color? textInverse,
    Color? textAccent,
    Color? textSuccess,
    Color? textAlert,
    Color? textWarning,
    Color? textError,

    // Button
    Color? buttonPrimary,
    Color? buttonPrimaryBg,
    Color? buttonPrimaryBgHover,
    Color? buttonSuccessBg,
    Color? buttonSuccessBgHover,
    Color? buttonAlertBg,
    Color? buttonAlertBgHover,
    Color? buttonWarningBg,
    Color? buttonWarningBgHover,
    Color? buttonErrorBg,
    Color? buttonErrorBgHover,
    Color? buttonSecondary,
    Color? buttonSecondaryBg,
    Color? buttonSecondaryBgHover,
    Color? buttonTertiary,
    Color? buttonTertiaryBg,
    Color? buttonTertiaryBgHover,

    // Chip
    Color? chipPrimary,
    Color? chipPrimaryBg,
    Color? chipSuccess,
    Color? chipSuccessBg,
    Color? chipAlert,
    Color? chipAlertBg,
    Color? chipWarning,
    Color? chipWarningBg,
    Color? chipError,
    Color? chipErrorBg,
    Color? chipSecondary,
    Color? chipSecondaryBg,
  }) {
    return AppColorsExtension(
      pageBg: pageBg ?? this.pageBg,
      pageBgInverse: pageBgInverse ?? this.pageBgInverse,
      pageOverlayBg: pageOverlayBg ?? this.pageOverlayBg,
      pageOverlayPrimary: pageOverlayPrimary ?? this.pageOverlayPrimary,
      pageOverlaySecondary: pageOverlaySecondary ?? this.pageOverlaySecondary,
      pageOverlayBackdrop: pageOverlayBackdrop ?? this.pageOverlayBackdrop,
      pageDivider: pageDivider ?? this.pageDivider,
      pageDividerInverse: pageDividerInverse ?? this.pageDividerInverse,
      inputBg: inputBg ?? this.inputBg,
      inputBorder: inputBorder ?? this.inputBorder,
      inputBorderHover: inputBorderHover ?? this.inputBorderHover,
      inputBorderActive: inputBorderActive ?? this.inputBorderActive,
      cardBg: cardBg ?? this.cardBg,
      cardBgHover: cardBgHover ?? this.cardBgHover,
      cardBorder: cardBorder ?? this.cardBorder,
      cardBorderHover: cardBorderHover ?? this.cardBorderHover,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textQuaternary: textQuaternary ?? this.textQuaternary,
      textInverse: textInverse ?? this.textInverse,
      textAccent: textAccent ?? this.textAccent,
      textSuccess: textSuccess ?? this.textSuccess,
      textAlert: textAlert ?? this.textAlert,
      textWarning: textWarning ?? this.textWarning,
      textError: textError ?? this.textError,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonPrimaryBg: buttonPrimaryBg ?? this.buttonPrimaryBg,
      buttonPrimaryBgHover: buttonPrimaryBgHover ?? this.buttonPrimaryBgHover,
      buttonSuccessBg: buttonSuccessBg ?? this.buttonSuccessBg,
      buttonSuccessBgHover: buttonSuccessBgHover ?? this.buttonSuccessBgHover,
      buttonAlertBg: buttonAlertBg ?? this.buttonAlertBg,
      buttonAlertBgHover: buttonAlertBgHover ?? this.buttonAlertBgHover,
      buttonWarningBg: buttonWarningBg ?? this.buttonWarningBg,
      buttonWarningBgHover: buttonWarningBgHover ?? this.buttonWarningBgHover,
      buttonErrorBg: buttonErrorBg ?? this.buttonErrorBg,
      buttonErrorBgHover: buttonErrorBgHover ?? this.buttonErrorBgHover,
      buttonSecondary: buttonSecondary ?? this.buttonSecondary,
      buttonSecondaryBg: buttonSecondaryBg ?? this.buttonSecondaryBg,
      buttonSecondaryBgHover:
          buttonSecondaryBgHover ?? this.buttonSecondaryBgHover,
      buttonTertiary: buttonTertiary ?? this.buttonTertiary,
      buttonTertiaryBg: buttonTertiaryBg ?? this.buttonTertiaryBg,
      buttonTertiaryBgHover:
          buttonTertiaryBgHover ?? this.buttonTertiaryBgHover,
      chipPrimary: chipPrimary ?? this.chipPrimary,
      chipPrimaryBg: chipPrimaryBg ?? this.chipPrimaryBg,
      chipSuccess: chipSuccess ?? this.chipSuccess,
      chipSuccessBg: chipSuccessBg ?? this.chipSuccessBg,
      chipAlert: chipAlert ?? this.chipAlert,
      chipAlertBg: chipAlertBg ?? this.chipAlertBg,
      chipWarning: chipWarning ?? this.chipWarning,
      chipWarningBg: chipWarningBg ?? this.chipWarningBg,
      chipError: chipError ?? this.chipError,
      chipErrorBg: chipErrorBg ?? this.chipErrorBg,
      chipSecondary: chipSecondary ?? this.chipSecondary,
      chipSecondaryBg: chipSecondaryBg ?? this.chipSecondaryBg,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      pageBg: Color.lerp(pageBg, other.pageBg, t)!,
      pageBgInverse: Color.lerp(pageBgInverse, other.pageBgInverse, t)!,
      pageOverlayBg: Color.lerp(pageOverlayBg, other.pageOverlayBg, t)!,
      pageOverlayPrimary:
          Color.lerp(pageOverlayPrimary, other.pageOverlayPrimary, t)!,
      pageOverlaySecondary:
          Color.lerp(pageOverlaySecondary, other.pageOverlaySecondary, t)!,
      pageOverlayBackdrop:
          Color.lerp(pageOverlayBackdrop, other.pageOverlayBackdrop, t)!,
      pageDivider: Color.lerp(pageDivider, other.pageDivider, t)!,
      pageDividerInverse:
          Color.lerp(pageDividerInverse, other.pageDividerInverse, t)!,
      inputBg: Color.lerp(inputBg, other.inputBg, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      inputBorderHover:
          Color.lerp(inputBorderHover, other.inputBorderHover, t)!,
      inputBorderActive:
          Color.lerp(inputBorderActive, other.inputBorderActive, t)!,
      cardBg: Color.lerp(cardBg, other.cardBg, t)!,
      cardBgHover: Color.lerp(cardBgHover, other.cardBgHover, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      cardBorderHover: Color.lerp(cardBorderHover, other.cardBorderHover, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textQuaternary: Color.lerp(textQuaternary, other.textQuaternary, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      textAccent: Color.lerp(textAccent, other.textAccent, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      textAlert: Color.lerp(textAlert, other.textAlert, t)!,
      textWarning: Color.lerp(textWarning, other.textWarning, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonPrimaryBg: Color.lerp(buttonPrimaryBg, other.buttonPrimaryBg, t)!,
      buttonPrimaryBgHover:
          Color.lerp(buttonPrimaryBgHover, other.buttonPrimaryBgHover, t)!,
      buttonSuccessBg: Color.lerp(buttonSuccessBg, other.buttonSuccessBg, t)!,
      buttonSuccessBgHover:
          Color.lerp(buttonSuccessBgHover, other.buttonSuccessBgHover, t)!,
      buttonAlertBg: Color.lerp(buttonAlertBg, other.buttonAlertBg, t)!,
      buttonAlertBgHover:
          Color.lerp(buttonAlertBgHover, other.buttonAlertBgHover, t)!,
      buttonWarningBg: Color.lerp(buttonWarningBg, other.buttonWarningBg, t)!,
      buttonWarningBgHover:
          Color.lerp(buttonWarningBgHover, other.buttonWarningBgHover, t)!,
      buttonErrorBg: Color.lerp(buttonErrorBg, other.buttonErrorBg, t)!,
      buttonErrorBgHover:
          Color.lerp(buttonErrorBgHover, other.buttonErrorBgHover, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonSecondaryBg:
          Color.lerp(buttonSecondaryBg, other.buttonSecondaryBg, t)!,
      buttonSecondaryBgHover:
          Color.lerp(buttonSecondaryBgHover, other.buttonSecondaryBgHover, t)!,
      buttonTertiary: Color.lerp(buttonTertiary, other.buttonTertiary, t)!,
      buttonTertiaryBg:
          Color.lerp(buttonTertiaryBg, other.buttonTertiaryBg, t)!,
      buttonTertiaryBgHover:
          Color.lerp(buttonTertiaryBgHover, other.buttonTertiaryBgHover, t)!,
      chipPrimary: Color.lerp(chipPrimary, other.chipPrimary, t)!,
      chipPrimaryBg: Color.lerp(chipPrimaryBg, other.chipPrimaryBg, t)!,
      chipSuccess: Color.lerp(chipSuccess, other.chipSuccess, t)!,
      chipSuccessBg: Color.lerp(chipSuccessBg, other.chipSuccessBg, t)!,
      chipAlert: Color.lerp(chipAlert, other.chipAlert, t)!,
      chipAlertBg: Color.lerp(chipAlertBg, other.chipAlertBg, t)!,
      chipWarning: Color.lerp(chipWarning, other.chipWarning, t)!,
      chipWarningBg: Color.lerp(chipWarningBg, other.chipWarningBg, t)!,
      chipError: Color.lerp(chipError, other.chipError, t)!,
      chipErrorBg: Color.lerp(chipErrorBg, other.chipErrorBg, t)!,
      chipSecondary: Color.lerp(chipSecondary, other.chipSecondary, t)!,
      chipSecondaryBg: Color.lerp(chipSecondaryBg, other.chipSecondaryBg, t)!,
    );
  }
}
