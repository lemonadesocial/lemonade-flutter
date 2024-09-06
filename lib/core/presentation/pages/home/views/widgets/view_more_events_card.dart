import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';

class ViewMoreEventsCard extends StatelessWidget {
  final int moreEventsCount;
  const ViewMoreEventsCard({
    super.key,
    required this.moreEventsCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(const MyEventsRoute());
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: LemonColor.white12,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.medium),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) => Assets.icons.icSubdirectoryArrowRight.svg(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Text(
                '$moreEventsCount more',
                style: Typo.medium.copyWith(
                  color: LemonColor.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
