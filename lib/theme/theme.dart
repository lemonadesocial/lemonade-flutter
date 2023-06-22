import 'package:app/theme/lemonade_color.dart';
import 'package:app/theme/lemonade_typo.dart';
import 'package:flutter/material.dart';

final lemonadeAppLightThemeData = ThemeData(
  brightness: Brightness.light,
  textTheme: lemonadeTextTheme,
  colorScheme: lemonadeLightThemeColorScheme,
);

final lemonadeAppDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  textTheme: lemonadeTextTheme,
  colorScheme: lemonadeDarkThemeColorScheme,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    color: LemonadeColor.black,
    titleTextStyle: LemonadeTypo.large,
  ),
);
