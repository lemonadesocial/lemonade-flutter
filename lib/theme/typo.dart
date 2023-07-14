import 'package:flutter/material.dart';

class Typo {
  static const large = TextStyle(
    fontSize: 21,
    height: 27 / 21,
    fontWeight: FontWeight.w500,
  );

  static const extraMedium = TextStyle(
    fontSize: 18,
    height: 25 / 18,
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

  static const xSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}

const lemonadeTextTheme = TextTheme(
  titleLarge: Typo.large,
  titleSmall: Typo.medium,
  bodyMedium: Typo.medium,
  bodySmall: Typo.small, 
  labelLarge: Typo.medium,
  labelMedium: Typo.small,
);
