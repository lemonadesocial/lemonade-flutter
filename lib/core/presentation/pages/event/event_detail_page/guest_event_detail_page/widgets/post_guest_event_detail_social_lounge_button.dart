import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostGuestEventDetailSocialLoungeButton extends StatelessWidget {
  const PostGuestEventDetailSocialLoungeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          const GuestEventStoriesRoute(),
        );
      },
      child: Container(
        padding: EdgeInsets.all(
          Spacing.small,
        ),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: colorScheme.outlineVariant,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(
                Spacing.extraSmall,
              ),
              decoration: BoxDecoration(
                color: LemonColor.chineseBlack,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              ),
              child: Center(
                child: Assets.icons.icLoungeGradient.svg(),
              ),
            ),
            SizedBox(
              width: Spacing.small,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.event.eventLounge.socialLounge,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    t.event.eventLounge.socialLoungeDescription,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icArrowRight.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
