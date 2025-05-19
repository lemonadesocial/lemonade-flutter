import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LensEmptyListSize {
  small,
  large,
}

class LensEmptyList extends StatelessWidget {
  const LensEmptyList({
    super.key,
  });

  Size? get iconSize {
    return Size(120.w, 120.w);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.medium,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: appColors.cardBg,
          border: Border.all(
            color: appColors.pageDivider,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.md),
        ),
        padding: EdgeInsets.all(Spacing.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: ThemeSvgIcon(
                builder: (filter) => Assets.icons.icLensEmpty.svg(
                  width: Sizing.s14,
                  height: Sizing.s14,
                ),
              ),
            ),
            SizedBox(height: Spacing.small),
            Text(
              t.lens.noPostsYet,
              style: appText.md,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 2.w),
            Text(
              t.lens.postsFromThisCommunityWillAppearHere,
              style: appText.sm.copyWith(
                color: appColors.textTertiary,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
