import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sizing {
  @Deprecated("Use s2 instead")

  /// represent size of 8.0
  static double xxSmall = 8.w;

  @Deprecated("Use s4 instead")

  /// represent size of 16.0
  static double xSmall = 16.w;

  @Deprecated("Use s4_5 instead")

  /// represent size of 18.0
  static double mSmall = 18.w;

  @Deprecated("Use s6 instead")

  /// represent size of 24.0
  static double small = 24.w;

  @Deprecated("Use s8 instead")

  /// represent size of 32
  static double regular = 32.w;

  @Deprecated("Use s9 instead")

  /// represent size of 36
  static double medium = 36.w;

  @Deprecated(
    "Use s12 from Spacing or define new if needed",
  ) // Assuming s12 from Spacing class (48px)
  /// represent size of 48
  static double large = 48.w;

  @Deprecated(
    "Use s10 (40px) or s12 (48px) from Spacing, or s14 (56px) from Spacing, or define new if needed",
  ) // 60px is between s14(56) and s16(64) from Spacing
  /// represent size of 60
  static double xLarge = 60.w;

  // New sizing system
  /// 0px
  static double s0 = 0.0.w;

  /// 2px
  static double s0_5 = 2.0.w;

  /// 4px
  static double s1 = 4.0.w;

  /// 6px
  static double s1_5 = 6.0.w;

  /// 8px
  static double s2 = 8.0.w;

  /// 10px
  static double s2_5 = 10.0.w;

  /// 12px
  static double s3 = 12.0.w;

  /// 14px
  static double s3_5 = 14.0.w;

  /// 16px
  static double s4 = 16.0.w;

  /// 18px
  static double s4_5 = 18.0.w;

  /// 20px
  static double s5 = 20.0.w;

  /// 24px
  static double s6 = 24.0.w;

  /// 28px
  static double s7 = 28.0.w;

  /// 32px
  static double s8 = 32.0.w;

  /// 36px
  static double s9 = 36.0.w;

  /// 40px
  static double s10 = 40.0.w;

  /// 44px
  static double s11 = 44.0.w;

  /// 48px
  static double s12 = 48.0.w;

  /// 56px
  static double s14 = 56.0.w;

  /// 64px
  static double s16 = 64.0.w;

  /// 72px
  static double s18 = 72.0.w;

  /// 80px
  static double s20 = 80.0.w;

  /// 96px
  static double s24 = 96.0.w;
}
