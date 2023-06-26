import 'package:flutter/material.dart';

class LemonColor {
  static Color black = const Color(0xff000000);
  static Color black50 = const Color.fromRGBO(0, 0, 0, 0.5);
  static Color raisinBlack = const Color(0xff212121);
  static Color raisinBlack0 = const Color(0xff212121).withOpacity(0);
  static Color oliveBlack = const Color(0xff404040);
  static Color white = const Color(0xffFFFFFF);
  static Color white6 = const Color(0xffFFFFFF).withOpacity(0.6);
  static Color white10 = const Color(0xffFFFFFF).withOpacity(0.10);
  static Color white12 = const Color(0xffFFFFFF).withOpacity(0.12);
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

  // UI specific
  static Color dropdownBackground = const Color.fromARGB(221, 32, 32, 32);
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
  onSurface: LemonColor.raisinBlack
);

final ColorScheme lemonadeDarkThemeColorScheme = ColorScheme.dark(
  primary: LemonColor.black,
  onPrimary: LemonColor.white,
  secondary: LemonColor.raisinBlack,
  onSecondary: LemonColor.white54,
  tertiary: LemonColor.paleViolet,
  onTertiary: LemonColor.lavender,
  background: LemonColor.black,
  onBackground: LemonColor.white,
  surface: LemonColor.raisinBlack,
  onSurface: LemonColor.white72,
  outline: LemonColor.white12,
);
