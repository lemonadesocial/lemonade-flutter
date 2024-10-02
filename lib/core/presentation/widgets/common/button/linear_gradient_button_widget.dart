import 'package:app/core/presentation/widgets/lemon_inner_shadow.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum GradientButtonMode {
  defaultMode,
  lavenderMode,
  lavenderDisableMode;

  List<Color> get gradients {
    switch (this) {
      case defaultMode:
        return [
          LemonColor.arsenic.withOpacity(0.6),
          LemonColor.charlestonGreen.withOpacity(0.6),
        ];
      case lavenderMode:
        return [LemonColor.buttonLinear1, LemonColor.buttonLinear2];
      case lavenderDisableMode:
        return [
          LemonColor.disableButtonLavender,
          LemonColor.disableButtonLavender,
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
    return GestureDetector(
      onTap: loadingWhen ? null : onTap,
      child: ClipRRect(
        borderRadius: radius ?? BorderRadius.circular(LemonRadius.xSmall),
        child: InnerShadow(
          color: Colors.white.withOpacity(0.06),
          offset: shadowOffset ?? const Offset(0, 4),
          blur: 4,
          child: _childButton,
        ),
      ),
    );
  }

  Widget get _childButton => Container(
        height: height ?? Sizing.medium,
        width: width,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
              vertical: Spacing.extraSmall,
            ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: mode.gradients,
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
                    SizedBox(width: Spacing.extraSmall),
                  ],
                  Text(
                    label,
                    style: textStyle ??
                        Typo.small.copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (trailing != null) ...[
                    SizedBox(width: Spacing.extraSmall),
                    trailing!,
                  ],
                ],
        ),
      );

  factory LinearGradientButton.primaryButton({
    required String label,
    Function()? onTap,
    bool? loadingWhen,
    Color? textColor,
    Widget? trailing,
    TextStyle? textStyle,
    double? height,
    BorderRadius? radius,
  }) =>
      LinearGradientButton(
        onTap: onTap,
        label: label,
        loadingWhen: loadingWhen ?? false,
        textStyle: textStyle ??
            Typo.medium.copyWith(
              fontFamily: FontFamily.nohemiVariable,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
        mode: GradientButtonMode.lavenderMode,
        height: height ?? Sizing.large,
        radius: radius ?? BorderRadius.circular(LemonRadius.small * 2),
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
  }) =>
      LinearGradientButton(
        onTap: onTap,
        label: label,
        loadingWhen: loadingWhen ?? false,
        textStyle: textStyle ??
            Typo.medium.copyWith(
              fontFamily: FontFamily.nohemiVariable,
              fontWeight: FontWeight.w600,
              color: textColor ?? LemonColor.white,
            ),
        mode: GradientButtonMode.defaultMode,
        height: height ?? Sizing.large,
        radius: BorderRadius.circular(LemonRadius.small * 2),
        leading: leading,
        trailing: trailing,
      );
}
