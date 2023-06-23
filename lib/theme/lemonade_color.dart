import 'package:flutter/material.dart';

class LemonadeColor {
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
}

final ColorScheme lemonadeLightThemeColorScheme = ColorScheme.light(
  primary: LemonadeColor.white,
  onPrimary: LemonadeColor.black,
  secondary: LemonadeColor.white54,
  onSecondary: LemonadeColor.raisinBlack,
  background: LemonadeColor.white,
  onBackground: LemonadeColor.black,
  tertiary: LemonadeColor.paleViolet,
  onTertiary: LemonadeColor.lavender,
);

final ColorScheme lemonadeDarkThemeColorScheme = ColorScheme.dark(
  primary: LemonadeColor.black,
  onPrimary: LemonadeColor.white,
  secondary: LemonadeColor.raisinBlack,
  onSecondary: LemonadeColor.white54,
  background: LemonadeColor.black,
  onBackground: LemonadeColor.white,
  tertiary: LemonadeColor.paleViolet,
  onTertiary: LemonadeColor.lavender,
);
