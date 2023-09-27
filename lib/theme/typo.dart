import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Typo {
  /// 26 sp
  static final extraLarge = TextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
  );

  /// 21 sp
  static final large = TextStyle(
    fontSize: 21.sp,
    height: (27 / 21).w,
    fontWeight: FontWeight.w700,
  );

  /// 18 sp
  static final extraMedium = TextStyle(
    fontSize: 18.sp,
    height: (25 / 18).w,
    fontWeight: FontWeight.w700,
  );

  /// 16 sp
  static final mediumPlus = TextStyle(
    fontSize: 16.sp,
    height: (20 / 16).w,
    fontWeight: FontWeight.w500,
  );

  /// 14 sp
  static final medium = TextStyle(
    fontSize: 14.sp,
    height: (18 / 14).w,
    fontWeight: FontWeight.w500,
  );

  /// 12 sp
  static final small = TextStyle(
    fontSize: 12.sp,
    height: (15 / 14).w,
    fontWeight: FontWeight.w500,
  );

  /// 10 sp
  static final xSmall = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );

  /// 8 sp
  static final extraSmall = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );
}

final lemonadeTextTheme = TextTheme(
  titleLarge: Typo.large,
  titleSmall: Typo.medium,
  bodyMedium: Typo.medium,
  bodySmall: Typo.small,
  labelLarge: Typo.medium,
  labelMedium: Typo.small,
);
