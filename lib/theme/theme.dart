import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

final lemonadeAppLightThemeData = ThemeData(
  brightness: Brightness.light,
  textTheme: lemonadeTextTheme,
  colorScheme: lemonadeLightThemeColorScheme,
);

final lemonadeAppDarkThemeData = ThemeData(
  splashColor: Colors.red,
  fontFamily: 'CircularStd',
  brightness: Brightness.dark,
  textTheme: lemonadeTextTheme,
  colorScheme: lemonadeDarkThemeColorScheme,
  // ignore: deprecated_member_use
  backgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: LemonColor.black,
    titleTextStyle: Typo.large,
  ),
);
