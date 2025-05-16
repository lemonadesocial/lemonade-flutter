import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

final lemonadeAppLightThemeData = ThemeData(
  fontFamily: FontFamily.generalSans,
  brightness: Brightness.light,
  textTheme: lemonadeTextTheme,
  colorScheme: lemonadeLightThemeColorScheme,
);

final lemonadeAppDarkThemeData = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  fontFamily: FontFamily.generalSans,
  brightness: Brightness.dark,
  textTheme: lemonadeTextTheme,
  colorScheme: lemonadeDarkThemeColorScheme,
  scaffoldBackgroundColor: LemonColor.black,
  // ignore: deprecated_member_use
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: LemonColor.black,
    titleTextStyle: Typo.large,
  ),
  // Change the text buttons.
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      // Change the color of the text buttons.
      foregroundColor: MaterialStatePropertyAll(Colors.white),
    ),
  ),
);
