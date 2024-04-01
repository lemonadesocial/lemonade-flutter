library dotted_line;

import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Basic settings
/// * [title] - title of snackbar
/// * [message] - sub-title if needed
/// * [icon] - left icon
class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({
    super.key,
    this.title = '',
    this.message = '',
    this.icon,
    this.colorScheme,
    this.showIconContainer = false,
    this.iconContainerColor,
  });

  /// The title of snackbar
  final String title;

  /// The sub-title of snackbar
  final String message;

  /// The custom icon of snackbar
  final Widget? icon;

  final ColorScheme? colorScheme;

  final bool? showIconContainer;

  final Color? iconContainerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
      margin: EdgeInsets.only(
        top: Spacing.xSmall,
        right: Spacing.xSmall,
        left: Spacing.xSmall,
      ),
      decoration: ShapeDecoration(
        color: LemonColor.raisinBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Row(
        children: [
          showIconContainer == true
              ? Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color:
                        iconContainerColor ?? colorScheme?.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: icon != null
                      ? SizedBox(
                          width: Sizing.medium,
                          height: Sizing.medium,
                          child: icon,
                        )
                      : const SizedBox(),
                )
              : icon != null
                  ? SizedBox(
                      width: Sizing.small,
                      height: Sizing.small,
                      child: icon,
                    )
                  : const SizedBox(),
          SizedBox(
            width: Spacing.xSmall,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Typo.medium.copyWith(
                    color: colorScheme?.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                message != ''
                    ? Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          message,
                          style: Typo.small
                              .copyWith(color: colorScheme?.onSecondary),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
