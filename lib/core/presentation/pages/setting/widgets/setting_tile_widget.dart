import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingTileWidget extends StatelessWidget {
  const SettingTileWidget({
    Key? key,
    required this.title,
    this.leading,
    required this.onTap,
    this.subTitle,
    this.trailing,
    this.featureAvailable = true,
    this.titleColor,
    this.color,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool featureAvailable;
  final Color? titleColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? colorScheme.onPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(Spacing.small),
              child: Row(
                children: [
                  leading != null
                      ? Container(
                          width: 42.w,
                          height: 42.w,
                          padding: EdgeInsets.all(Spacing.xSmall),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.secondaryContainer,
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
                      children: [
                        Text(
                          title,
                          style: Typo.medium.copyWith(
                            color: titleColor ?? colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        subTitle == null
                            ? const SizedBox.shrink()
                            : Text(
                                subTitle!,
                                style: Typo.small.copyWith(
                                  color:
                                      colorScheme.onPrimary.withOpacity(0.36),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  trailing ?? const SizedBox.shrink(),
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
