import 'package:app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTypography {
  static final xs = TextStyle(
    fontSize: 12.sp,
    height: 18 / 12, // 1.5
    fontFamily: FontFamily.generalSans,
    fontWeight: FontWeight.w500,
  );

  static final sm = TextStyle(
    fontSize: 14.sp,
    height: 20 / 14, // ~1.428
    fontFamily: FontFamily.generalSans,
    fontWeight: FontWeight.w500,
  );

  static final md = TextStyle(
    fontSize: 16.sp,
    height: 24 / 16, // 1.5
    fontFamily: FontFamily.generalSans,
    fontWeight: FontWeight.w500,
  );

  static final lg = TextStyle(
    fontSize: 18.sp,
    height: 24 / 18, // ~1.333
    fontFamily: FontFamily.generalSans,
    fontWeight: FontWeight.w500,
  );

  static final xl = TextStyle(
    fontSize: 24.sp,
    height: 32 / 24, // ~1.333
    fontFamily: FontFamily.clashDisplay,
    fontWeight: FontWeight.w600,
  );

  static final xxl = TextStyle(
    fontSize: 32.sp,
    height: 40 / 32, // 1.25
    fontFamily: FontFamily.clashDisplay,
    fontWeight: FontWeight.w600,
  );

  static final xxxl = TextStyle(
    fontSize: 48.sp,
    height: 60 / 48, // 1.25
    fontFamily: FontFamily.clashDisplay,
    fontWeight: FontWeight.w600,
  );
}
