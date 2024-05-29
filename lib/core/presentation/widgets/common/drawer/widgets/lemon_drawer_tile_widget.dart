import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LemonDrawerTileWidget extends StatelessWidget {
  const LemonDrawerTileWidget({
    super.key,
    required this.title,
    this.leading,
    required this.onTap,
    this.trailing,
    this.featureAvailable = true,
    this.titleColor,
    this.color,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool featureAvailable;
  final Color? titleColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
        onTap();
      },
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: color ?? colorScheme.onPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12.r),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 6.w,
                top: 6.h,
                bottom: 6.h,
                right: 18.w,
              ),
              child: Row(
                children: [
                  leading != null
                      ? Container(
                          width: 48.w,
                          height: 48.w,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: LemonColor.white06,
                            borderRadius: BorderRadius.circular(6.r),
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
                          style: Typo.medium.copyWith(
                            color: titleColor ?? colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
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
      height: 32.w,
      label: t.common.comingSoon,
      radius: BorderRadius.circular(LemonRadius.button),
      textStyle: Typo.xSmall.copyWith(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
