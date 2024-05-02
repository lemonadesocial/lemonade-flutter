import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverIcebreakersSection extends StatelessWidget {
  const CollaboratorDiscoverIcebreakersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: LemonColor.white06,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LemonRadius.normal),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  builder: (colorFilter) => Assets.icons.icQuote.svg(
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
                SizedBox(width: Spacing.smMedium / 2),
                Expanded(
                  child: Text(
                    t.collaborator.iceBreakers,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(LemonRadius.medium),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '5 more',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                          height: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.smMedium),
            Text(
              'My most unusual traits are...',
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: Spacing.smMedium / 2),
            Text(
              'Dad jokes, eye color mismatch, constant fidgeting when happy',
              style: Typo.extraMedium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
