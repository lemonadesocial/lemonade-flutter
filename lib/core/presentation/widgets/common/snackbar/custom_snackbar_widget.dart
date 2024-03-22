library dotted_line;

import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Basic settings
/// * [title] - title of snackbar
/// * [subTitle] - sub-title if needed
/// * [icon] - left icon
class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({
    super.key,
    this.title = '',
    this.subTitle = '',
    this.icon,
    this.colorScheme,
  });

  /// The title of snackbar
  final String title;

  /// The sub-title of snackbar
  final String subTitle;

  /// The custom icon of snackbar
  final Widget? icon;

  final ColorScheme? colorScheme;

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
          icon != null
              ? SizedBox(
                  width: Sizing.medium,
                  height: Sizing.medium,
                  child: icon,
                )
              : const SizedBox(),
          SizedBox(
            width: Spacing.xSmall,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Typo.medium.copyWith(
                    color: colorScheme?.onPrimary, fontWeight: FontWeight.w600),
              ),
              subTitle != ''
                  ? Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        subTitle,
                        style:
                            Typo.small.copyWith(color: colorScheme?.onSecondary),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
