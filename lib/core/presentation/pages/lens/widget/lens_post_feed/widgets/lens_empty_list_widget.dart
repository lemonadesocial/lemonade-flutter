import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.medium,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.outline,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.all(Spacing.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: ThemeSvgIcon(
                builder: (filter) => Assets.icons.icLensEmpty.svg(),
              ),
            ),
            SizedBox(height: Spacing.small),
            Text(
              t.lens.noPostsYet,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 2.w),
            Text(
              t.lens.postsFromThisCommunityWillAppearHere,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
