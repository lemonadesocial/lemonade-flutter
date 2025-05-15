import 'package:app/theme/theme.dart';
import 'package:app/app_theme/colors/app_colors_extension.dart';
import 'package:app/app_theme/colors/dark_theme_color.dart';
import 'package:app/app_theme/colors/light_theme_colors.dart';
import 'package:app/app_theme/typography/app_text_extension.dart';
import 'package:app/app_theme/typography/app_typography.dart';
import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  //
  // Light theme
  //
  static final light = lemonadeAppLightThemeData.copyWith(
    textTheme: TextTheme(
      displayLarge: _lightAppTextTheme.xxxl,
      displayMedium: _lightAppTextTheme.xxl,
      displaySmall: _lightAppTextTheme.xl,
      headlineLarge: _lightAppTextTheme.xl,
      headlineMedium: _lightAppTextTheme.lg,
      headlineSmall: _lightAppTextTheme.md,
      titleLarge: _lightAppTextTheme.lg,
      titleMedium: _lightAppTextTheme.md,
      titleSmall: _lightAppTextTheme.sm,
      bodyLarge: _lightAppTextTheme.md,
      bodyMedium: _lightAppTextTheme.sm,
      bodySmall: _lightAppTextTheme.xs,
      labelLarge: _lightAppTextTheme.sm,
      labelMedium: _lightAppTextTheme.xs,
      labelSmall: _lightAppTextTheme.xs,
    ),
    scaffoldBackgroundColor: _lightAppColors.pageBg,
    colorScheme: lemonadeAppLightThemeData.colorScheme.copyWith(
      background: _lightAppColors.pageBg,
    ),
    extensions: [
      _lightAppColors,
      _lightAppTextTheme,
    ],
  );

  static final _lightAppColors = lightThemeColors;

  static final _lightAppTextTheme = AppTextThemeExtension(
    xs: AppTypography.xs.copyWith(
      color: _lightAppColors.textPrimary,
    ),
    sm: AppTypography.sm.copyWith(
      color: _lightAppColors.textPrimary,
    ),
    md: AppTypography.md.copyWith(
      color: _lightAppColors.textPrimary,
    ),
    lg: AppTypography.lg.copyWith(
      color: _lightAppColors.textPrimary,
    ),
    xl: AppTypography.xl.copyWith(
      color: _lightAppColors.textPrimary,
    ),
    xxl: AppTypography.xxl.copyWith(
      color: _lightAppColors.textPrimary,
    ),
    xxxl: AppTypography.xxxl.copyWith(
      color: _lightAppColors.textPrimary,
    ),
  );

  static final dark = lemonadeAppDarkThemeData.copyWith(
    textTheme: TextTheme(
      displayLarge: _darkAppTextTheme.xxxl,
      displayMedium: _darkAppTextTheme.xxl,
      displaySmall: _darkAppTextTheme.xl,
      headlineLarge: _darkAppTextTheme.xl,
      headlineMedium: _darkAppTextTheme.lg,
      headlineSmall: _darkAppTextTheme.md,
      titleLarge: _darkAppTextTheme.lg,
      titleMedium: _darkAppTextTheme.md,
      titleSmall: _darkAppTextTheme.sm,
      bodyLarge: _darkAppTextTheme.md,
      bodyMedium: _darkAppTextTheme.sm,
      bodySmall: _darkAppTextTheme.xs,
      labelLarge: _darkAppTextTheme.sm,
      labelMedium: _darkAppTextTheme.xs,
      labelSmall: _darkAppTextTheme.xs,
    ),

    // scaffoldBackgroundColor: _darkAppColors.pageBg,
    colorScheme: lemonadeAppDarkThemeData.colorScheme.copyWith(
        // background: _darkAppColors.pageBg,
        ),
    extensions: [
      _darkAppColors,
      _darkAppTextTheme,
    ],
  );

  static final _darkAppColors = darkThemeColors;

  static final _darkAppTextTheme = AppTextThemeExtension(
    xs: AppTypography.xs.copyWith(
      color: _darkAppColors.textPrimary,
    ),
    sm: AppTypography.sm.copyWith(
      color: _darkAppColors.textPrimary,
    ),
    md: AppTypography.md.copyWith(
      color: _darkAppColors.textPrimary,
    ),
    lg: AppTypography.lg.copyWith(
      color: _darkAppColors.textPrimary,
    ),
    xl: AppTypography.xl.copyWith(
      color: _darkAppColors.textPrimary,
    ),
    xxl: AppTypography.xxl.copyWith(
      color: _darkAppColors.textPrimary,
    ),
    xxxl: AppTypography.xxxl.copyWith(
      color: _darkAppColors.textPrimary,
    ),
  );
}

extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppTheme._lightAppColors;

  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppTheme._lightAppTextTheme;
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);

  void a() {}
}
