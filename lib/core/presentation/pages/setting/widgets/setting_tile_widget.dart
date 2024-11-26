import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingTileWidget extends StatelessWidget {
  const SettingTileWidget({
    super.key,
    required this.title,
    this.leading,
    this.leadingCircle = true,
    this.leadingRadius,
    required this.onTap,
    this.subTitle,
    this.description,
    this.trailing,
    this.featureAvailable = true,
    this.titleStyle,
    this.color,
    this.radius,
    this.borderRadius,
    this.isError,
    this.titleColor,
    this.onTapTrailing,
  });

  final String title;
  final String? subTitle;
  final String? description;
  final Widget? leading;
  final double? leadingRadius;
  final bool? leadingCircle;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool featureAvailable;
  final TextStyle? titleStyle;
  final Color? color;
  final double? radius;
  final BorderRadius? borderRadius;
  final bool? isError;
  final Color? titleColor;
  final VoidCallback? onTapTrailing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? LemonColor.atomicBlack,
          borderRadius: borderRadius ??
              BorderRadius.circular(radius ?? LemonRadius.small),
          border: isError == true
              ? Border.all(
                  color: LemonColor.errorRedBg,
                  width: 1,
                )
              : null,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(Spacing.small),
              child: Row(
                children: [
                  leading != null
                      ? leadingCircle == true
                          ? Container(
                              width: 42.w,
                              height: 42.w,
                              padding: EdgeInsets.all(Spacing.xSmall),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(leadingRadius ?? 42.w),
                                ),
                              ),
                              child: leading,
                            )
                          : SizedBox(
                              child: leading,
                            )
                      : const SizedBox(),
                  leading != null
                      ? SizedBox(width: Spacing.small)
                      : const SizedBox(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: titleStyle ??
                              Typo.medium.copyWith(
                                color: titleColor ?? colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        subTitle == null || subTitle == ''
                            ? const SizedBox.shrink()
                            : Text(
                                subTitle!,
                                style: Typo.small.copyWith(
                                  color: colorScheme.onSecondary,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                              ),
                        description == null || description == ''
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  SizedBox(height: 3.h),
                                  Text(
                                    description!,
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  trailing != null
                      ? InkWell(
                          onTap: onTapTrailing,
                          child: trailing!,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            if (!featureAvailable)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 6.w,
                    left: 6.w,
                    top: 6.w,
                    right: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.06),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(LemonRadius.xSmall),
                      topRight: Radius.circular(LemonRadius.xSmall),
                    ),
                  ),
                  child: Text(
                    t.home.comingSoon,
                    style: Typo.xSmall.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.54),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
