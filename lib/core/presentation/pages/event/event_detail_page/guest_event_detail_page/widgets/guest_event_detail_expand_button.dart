import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class GuestEventDetailExpandButton extends StatelessWidget {
  final VoidCallback? onTap;
  const GuestEventDetailExpandButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizing.small,
        height: Sizing.small,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizing.small),
          border: Border.all(
            color: appColors.pageDivider,
          ),
        ),
        child: Center(
          child: Assets.icons.icExpand.svg(
            width: 12.w,
            height: 12.w,
          ),
        ),
      ),
    );
  }
}
