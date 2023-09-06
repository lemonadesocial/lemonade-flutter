import 'package:flutter/material.dart';

class LemonColor {
  static Color black = const Color(0xff000000);
  static Color black50 = const Color.fromRGBO(0, 0, 0, 0.5);
  static Color black87 = const Color(0x000f0f0f).withOpacity(0.87);
  static Color raisinBlack = const Color(0xff212121);
  static Color raisinBlack0 = const Color(0xff212121).withOpacity(0);
  static Color chineseBlack = const Color(0xff117171);
  static Color oliveBlack = const Color(0xff404040);
  static Color tertiaryBlack = const Color(0x4Debebf5);
  static Color white = const Color(0xffffffff);
  static Color white09 = const Color(0xffFFFFFF).withOpacity(0.09);
  static Color white6 = const Color(0xffFFFFFF).withOpacity(0.6);
  static Color white10 = const Color(0xffFFFFFF).withOpacity(0.10);
  static Color white12 = const Color(0xffFFFFFF).withOpacity(0.12);
  static Color white15 = const Color(0xffFFFFFF).withOpacity(0.15);
  static Color white18 = const Color(0xffFFFFFF).withOpacity(0.18);
  static Color white36 = const Color(0xffFFFFFF).withOpacity(0.36);
  static Color white54 = const Color(0xffFFFFFF).withOpacity(0.54);
  static Color white72 = const Color(0xffFFFFFF).withOpacity(0.72);
  static Color white87 = const Color(0xffFFFFFF).withOpacity(0.87);
  static Color lavender = const Color(0xffA667F3);
  static Color lavender18 = const Color(0xffA667F3).withOpacity(0.18);
  static Color paleViolet = const Color(0xffC69DF7);
  static Color paleViolet12 = const Color(0xffC69DF7).withOpacity(0.12);
  static Color paleViolet18 = const Color(0xffC69DF7).withOpacity(0.18);
  static Color paleViolet36 = const Color(0xffC69DF7).withOpacity(0.36);
  static Color red = const Color(0xFFFE4A49);
  static const errorRedBg = Color(0xFFED7E8C);
  static const usernameApproved = Color(0xFF49DB95);
  static Color black54 = const Color(0xff000000).withOpacity(0.54);
  static Color online = const Color(0xFF5FCB90);
  static Color ownMessage = const Color(0xFF8F71B2);
  static Color otherMessage = const Color(0xFF272727);

  // UI specific
  static Color dropdownBackground = const Color.fromARGB(221, 32, 32, 32);
  static Color dialogBackground = const Color(0xFF141414);

  // Button
  static Color arsenic = const Color(0xff424242);
  static Color charlestonGreen = const Color(0xff2c2c2c);
  static Color buttonLinear1 = const Color(0xFFB17AF4);
  static Color buttonLinear2 = const Color(0xFF6F3FAA);
  static Color grape = const Color(0xffB17AF4);
  static Color shadow = const Color.fromARGB(91, 0, 0, 0);
  static Color disableButtonLavender = const Color(0xFF3c2557);

  // Slider
  static Color sunrise = const Color(0xffFFDB00);
  static Color sunrise18 = const Color(0xffFFDB00).withOpacity(0.18);

  // Textfield
  static Color darkCharcoal = const Color(0xff2e2e2e);
  static const onboardingTitle = Color(0xFFDDDDDD);

  // FAB
  static const fabSecondaryBg = Color(0xFFB17AF4);
  static const fabFirstBg = Color(0xFF6F3FAA);
  static const fabShadow = Color(0x89090909);

  // Onboarding gender color
  static const femaleDefault = Color(0x2DF691B5);
  static const maleDefault = Color(0x1E91C0F6);
  static const ambiguousDefault = Color(0x1EA591F6);
  static const femaleActiveColor = Color(0xFFF691B5);
  static const maleActiveColor = Color(0xFF91C0F6);
  static const ambiguousActiveColor = Color(0xFFA591F6);

  // ripple marker
  static const rippleMarkerColor = Color.fromRGBO(89, 210, 116, 0.24);
}

final ColorScheme lemonadeLightThemeColorScheme = ColorScheme.light(
  primary: LemonColor.white,
  onPrimary: LemonColor.black,
  secondary: LemonColor.white54,
  onSecondary: LemonColor.raisinBlack,
  background: LemonColor.white,
  onBackground: LemonColor.black,
  tertiary: LemonColor.paleViolet,
  onTertiary: LemonColor.lavender,
  surface: LemonColor.white72,
  surfaceVariant: LemonColor.white72,
  onSurface: LemonColor.raisinBlack,
  onSurfaceVariant: LemonColor.raisinBlack,
  outline: LemonColor.oliveBlack,
  tertiaryContainer: LemonColor.tertiaryBlack,
  onPrimaryContainer: LemonColor.dialogBackground,
  errorContainer: LemonColor.errorRedBg,
);

final ColorScheme lemonadeDarkThemeColorScheme = ColorScheme.dark(
  primary: LemonColor.black,
  primaryContainer: LemonColor.darkCharcoal,
  onPrimary: LemonColor.white,
  secondary: LemonColor.raisinBlack,
  secondaryContainer: LemonColor.chineseBlack,
  onSecondary: LemonColor.white54,
  tertiary: LemonColor.paleViolet,
  onTertiary: LemonColor.lavender,
  background: LemonColor.black,
  onBackground: LemonColor.white,
  surface: LemonColor.raisinBlack,
  surfaceVariant: LemonColor.black87,
  onSurface: LemonColor.white72,
  onSurfaceVariant: LemonColor.white36,
  outline: LemonColor.white12,
  outlineVariant: LemonColor.white18,
  tertiaryContainer: LemonColor.tertiaryBlack,
  onPrimaryContainer: LemonColor.dialogBackground,
  onSecondaryContainer: LemonColor.disableButtonLavender,
  errorContainer: LemonColor.errorRedBg,
);
