import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class ViewMoreEventsCard extends StatelessWidget {
  final int moreEventsCount;
  const ViewMoreEventsCard({
    super.key,
    required this.moreEventsCount,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(MyEventsRoute());
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.s3),
        decoration: ShapeDecoration(
          color: appColors.cardBg,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: appColors.cardBorder,
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
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icSubdirectoryArrowRight.svg(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.s4),
            Expanded(
              child: Text(
                '$moreEventsCount more',
                style: context.theme.appTextTheme.md.copyWith(
                  color: appColors.textTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
