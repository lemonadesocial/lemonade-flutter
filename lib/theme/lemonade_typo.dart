import 'package:flutter/material.dart';

class LemonadeTypo {
  static const large = TextStyle(
    fontSize: 21,
    height: 27 / 21,
    fontWeight: FontWeight.w500,
  );

  static const medium = TextStyle(
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w500,
  );

  static const small = TextStyle(
    fontSize: 12,
    height: 15 / 14,
    fontWeight: FontWeight.w500,
  );
}

const lemonadeTextTheme = TextTheme(
  titleLarge: LemonadeTypo.large,
  titleSmall: LemonadeTypo.medium,
  bodyMedium: LemonadeTypo.medium,
  bodySmall: LemonadeTypo.small, 
  labelLarge: LemonadeTypo.medium,
  labelMedium: LemonadeTypo.small,
);
