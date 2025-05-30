import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class PostGuestEventDetailSocialLoungeButton extends StatelessWidget {
  const PostGuestEventDetailSocialLoungeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

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
          color: appColors.cardBg,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: appColors.cardBorder,
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
                color: appColors.cardBg,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                border: Border.all(
                  color: appColors.cardBorder,
                  width: 1.w,
                ),
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
                    style: appText.sm.copyWith(
                      color: appColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    t.event.eventLounge.socialLoungeDescription,
                    style: appText.xs.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              child: ThemeSvgIcon(
                color: appColors.textTertiary,
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
