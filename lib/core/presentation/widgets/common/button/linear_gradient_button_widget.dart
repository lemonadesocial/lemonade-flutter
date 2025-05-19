import 'package:app/core/presentation/widgets/lemon_inner_shadow.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

enum GradientButtonMode {
  defaultMode,
  lavenderMode,
  lavenderDisableMode,
  light;

  @Deprecated("")
  List<Color> get gradients {
    switch (this) {
      case defaultMode:
        return [
          LemonColor.arsenic.withOpacity(0.6),
          LemonColor.charlestonGreen.withOpacity(0.6),
        ];
      case lavenderMode:
        return [LemonColor.lavender, LemonColor.lavender];
      case lavenderDisableMode:
        return [
          LemonColor.disableButtonLavender,
          LemonColor.disableButtonLavender,
        ];
      case light:
        return [
          const Color.fromRGBO(255, 255, 255, 0.87),
          const Color.fromRGBO(255, 255, 255, 0.87),
        ];
      default:
        return [];
    }
  }
}

class LinearGradientButton extends StatelessWidget {
  final GradientButtonMode mode;
  final String label;
  final Widget? leading;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final TextStyle? textStyle;
  final Offset? shadowOffset;
  final bool loadingWhen;
  final Widget? trailing;

  const LinearGradientButton({
    super.key,
    required this.label,
    this.leading,
    this.mode = GradientButtonMode.defaultMode,
    this.onTap,
    this.height,
    this.width,
    this.padding,
    this.radius,
    this.textStyle,
    this.shadowOffset,
    this.trailing,
    this.loadingWhen = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loadingWhen ? null : onTap,
      child: ClipRRect(
        borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
        child: InnerShadow(
          color: Colors.white.withOpacity(0.06),
          offset: shadowOffset ?? const Offset(0, 4),
          blur: 4,
          child: _childButton(context),
        ),
      ),
    );
  }

  Widget _childButton(BuildContext buildContext) {
    final appColors = buildContext.theme.appColors;
    final appText = buildContext.theme.appTextTheme;
    Color textColor = appColors.buttonPrimary;
    List<Color> gradients = [];
    switch (mode) {
      case GradientButtonMode.lavenderMode:
        gradients = [
          appColors.buttonPrimaryBg,
          appColors.buttonPrimaryBg,
        ];
        textColor = appColors.buttonPrimary;
      case GradientButtonMode.lavenderDisableMode:
        gradients = [
          appColors.buttonSecondaryBg.withOpacity(0.6),
          appColors.buttonSecondaryBg.withOpacity(0.6),
        ];
        textColor = appColors.buttonPrimary;
      case GradientButtonMode.light:
      case GradientButtonMode.defaultMode:
        gradients = [
          appColors.buttonSecondaryBg,
          appColors.buttonSecondaryBg,
        ];
        textColor = appColors.buttonSecondary;
    }

    return Container(
      height: height ?? Sizing.medium,
      width: width,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: Spacing.s2_5,
            vertical: Spacing.s1_5,
          ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradients,
        ),
        boxShadow: [
          BoxShadow(
            color: LemonColor.black.withOpacity(0.30),
            offset: const Offset(0, 2),
            blurRadius: 18.r,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: loadingWhen
            ? [
                SizedBox(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  child: CircularProgressIndicator(
                    // Loading button should be black and white and are not affected by theme
                    backgroundColor: LemonColor.black.withOpacity(0.36),
                    color: LemonColor.white.withOpacity(0.72),
                  ),
                ),
              ]
            : [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: Spacing.s1_5),
                ],
                Text(
                  label,
                  style: textStyle ?? appText.sm.copyWith(color: textColor),
                ),
                if (trailing != null) ...[
                  SizedBox(width: Spacing.s1_5),
                  trailing!,
                ],
              ],
      ),
    );
  }

  factory LinearGradientButton.primaryButton({
    required String label,
    Function()? onTap,
    bool? loadingWhen,
    Color? textColor,
    Widget? trailing,
    TextStyle? textStyle,
    double? height,
    BorderRadius? radius,
    Widget? leading,
  }) =>
      LinearGradientButton(
        onTap: onTap,
        label: label,
        loadingWhen: loadingWhen ?? false,
        textStyle: textStyle,
        mode: GradientButtonMode.lavenderMode,
        height: height ?? Sizing.s12,
        radius: radius ?? BorderRadius.circular(LemonRadius.md),
        leading: leading,
        trailing: trailing,
      );

  factory LinearGradientButton.secondaryButton({
    required String label,
    Function()? onTap,
    bool? loadingWhen,
    Color? textColor,
    Widget? leading,
    Widget? trailing,
    TextStyle? textStyle,
    double? height,
    GradientButtonMode? mode,
    BorderRadius? radius,
  }) =>
      LinearGradientButton(
        onTap: onTap,
        label: label,
        loadingWhen: loadingWhen ?? false,
        textStyle: textStyle,
        mode: mode ?? GradientButtonMode.defaultMode,
        height: height ?? Sizing.s12,
        radius: radius ?? BorderRadius.circular(LemonRadius.md),
        leading: leading,
        trailing: trailing,
      );

  factory LinearGradientButton.whiteButton({
    required String label,
    Function()? onTap,
    bool? loadingWhen,
    Color? textColor,
    Widget? leading,
    Widget? trailing,
    TextStyle? textStyle,
    double? height,
    BorderRadius? radius,
  }) =>
      LinearGradientButton(
        onTap: onTap,
        label: label,
        loadingWhen: loadingWhen ?? false,
        textStyle: textStyle,
        mode: GradientButtonMode.light,
        height: height ?? Sizing.large,
        radius: radius ?? BorderRadius.circular(LemonRadius.md),
        leading: leading,
        trailing: trailing,
      );
}
