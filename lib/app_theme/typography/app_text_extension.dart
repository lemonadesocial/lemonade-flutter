import 'package:flutter/material.dart';

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  const AppTextThemeExtension({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
  });

  final TextStyle xs;
  final TextStyle sm;
  final TextStyle md;
  final TextStyle lg;
  final TextStyle xl;
  final TextStyle xxl;
  final TextStyle xxxl;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    TextStyle? xs,
    TextStyle? sm,
    TextStyle? md,
    TextStyle? lg,
    TextStyle? xl,
    TextStyle? xxl,
    TextStyle? xxxl,
  }) {
    return AppTextThemeExtension(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) {
      return this;
    }

    return AppTextThemeExtension(
      xs: TextStyle.lerp(xs, other.xs, t)!,
      sm: TextStyle.lerp(sm, other.sm, t)!,
      md: TextStyle.lerp(md, other.md, t)!,
      lg: TextStyle.lerp(lg, other.lg, t)!,
      xl: TextStyle.lerp(xl, other.xl, t)!,
      xxl: TextStyle.lerp(xxl, other.xxl, t)!,
      xxxl: TextStyle.lerp(xxxl, other.xxxl, t)!,
    );
  }
}
