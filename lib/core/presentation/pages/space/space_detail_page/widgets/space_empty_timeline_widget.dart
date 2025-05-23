import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class SpaceEmptyTimelineWidget extends StatelessWidget {
  const SpaceEmptyTimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 160.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.md),
                border: Border.all(
                  color: appColors.cardBorder,
                ),
                color: appColors.cardBg,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    appColors.cardBg.withOpacity(0.9),
                    appColors.pageBg,
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.s4),
            Container(
              height: 160.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.md),
                border: Border.all(
                  color: appColors.cardBorder,
                ),
                color: appColors.pageBg,
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     appColors.cardBg.withOpacity(0.9),
                //     appColors.pageBg,
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
