import 'package:app/app_theme/typography/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Typo {
  /// 30sp
  static final superLarge = AppTypography.xxl;
  // TextStyle(
  //   fontSize: 30.sp,
  //   fontWeight: FontWeight.w700,
  // );

  /// 26 sp
  static final extraLarge = AppTypography.xl;
  // TextStyle(
  //   fontSize: 26.sp,
  //   fontWeight: FontWeight.w700,
  // );

  /// 21 sp
  static final large = AppTypography.xl;
  // TextStyle(
  //   fontSize: 21.sp,
  //   height: (27 / 21).w,
  //   fontWeight: FontWeight.w700,
  // );

  /// 18 sp
  static final extraMedium = AppTypography.lg;
  // TextStyle(
  //   fontSize: 18.sp,
  //   height: (25 / 18).w,
  //   fontWeight: FontWeight.w700,
  // );

  /// 16 sp
  static final mediumPlus = AppTypography.md;
  // TextStyle(
  //   fontSize: 16.sp,
  //   height: (20 / 16).w,
  //   fontWeight: FontWeight.w500,
  // );

  /// 14 sp
  static final medium = AppTypography.md;
  // TextStyle(
  //   fontSize: 14.sp,
  //   height: (18 / 14).w,
  //   fontWeight: FontWeight.w500,
  // );

  /// 12 sp
  static final small = AppTypography.sm;
  // TextStyle(
  //   fontSize: 12.sp,
  //   height: (15 / 14).w,
  //   fontWeight: FontWeight.w500,
  // );

  /// 10 sp
  static final xSmall = AppTypography.xs;
  // TextStyle(
  //   fontSize: 10.sp,
  //   fontWeight: FontWeight.w500,
  // );

  /// 8 sp
  static final extraSmall = AppTypography.xs.copyWith(
    fontSize: 10.sp,
  );
  // TextStyle(
  //   fontSize: 10.sp,
  //   fontWeight: FontWeight.w500,
  // );
}

final lemonadeTextTheme = TextTheme(
  titleLarge: Typo.large,
  titleSmall: Typo.medium,
  bodyMedium: Typo.medium,
  bodySmall: Typo.small,
  labelLarge: Typo.medium,
  labelMedium: Typo.small,
);
