import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class LemonDrawerTileWidget extends StatelessWidget {
  const LemonDrawerTileWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.leadingBackgroundColor,
    required this.onTap,
    this.trailing,
    this.featureAvailable = true,
    this.titleColor,
    this.color,
    this.disabled = false,
    this.radius,
    this.border,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Color? leadingBackgroundColor;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool featureAvailable;
  final Color? titleColor;
  final Color? color;
  final bool disabled;
  final BorderRadius? radius;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return InkWell(
      onTap: () {
        if (disabled) return;
        Navigator.of(context, rootNavigator: true).pop();
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: appColors.cardBg,
          borderRadius: radius,
          border: border,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.s2_5,
                horizontal: Spacing.s3,
              ),
              child: Row(
                children: [
                  leading != null
                      ? Container(
                          width: Sizing.s10,
                          height: Sizing.s10,
                          padding: EdgeInsets.all(Spacing.s2),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color:
                                leadingBackgroundColor ?? appColors.cardBgHover,
                            borderRadius: BorderRadius.circular(LemonRadius.sm),
                          ),
                          child: leading,
                        )
                      : const SizedBox(),
                  leading != null
                      ? SizedBox(width: Spacing.small)
                      : const SizedBox(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: appText.md,
                        ),
                        if (subtitle != null && subtitle!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(
                              subtitle!,
                              style: appText.sm.copyWith(
                                color: appColors.textTertiary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  featureAvailable == false
                      ? _renderComingSoon(context)
                      : trailing ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _renderComingSoon(BuildContext context) {
    return LemonOutlineButton(
      height: Spacing.s8,
      label: t.common.comingSoon,
      radius: BorderRadius.circular(LemonRadius.full),
    );
  }
}
