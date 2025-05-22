// ignore_for_file: unused_element

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class CreateSubSideEventButton extends StatelessWidget {
  final Event event;
  const CreateSubSideEventButton({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Button(
          onTap: () {
            AutoRouter.of(context).push(
              CreateEventRoute(
                parentEventId: event.id ?? '',
                parentEventStart: event.start ?? DateTime.now(),
                parentEventEnd: event.end ?? DateTime.now(),
                parentTimezone: event.timezone ?? '',
              ),
            );
          },
          icon: Assets.icons.icSessionsGradient.svg(),
          title: t.event.subEvent.createSubEvent,
          subTitle: t.event.subEvent.createSubEventDescription,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: appColors.cardBorder,
            width: 1.w,
          ),
        ),
        // TODO: Coming soon feature
        // SizedBox(height: Spacing.superExtraSmall),
        // _Button(
        //   onTap: () {
        //     SnackBarUtils.showComingSoon();
        //   },
        //   icon: Assets.icons.icSisternodeOutline.svg(),
        //   title: t.event.sideEvent.createSideEvent,
        //   subTitle: t.event.sideEvent.createSideEventDescription,
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(LemonRadius.extraSmall),
        //     topRight: Radius.circular(LemonRadius.extraSmall),
        //     bottomLeft: Radius.circular(LemonRadius.medium),
        //     bottomRight: Radius.circular(LemonRadius.medium),
        //   ),
        // ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Function()? onTap;
  final Widget icon;
  final String title;
  final String subTitle;
  final BorderRadius? borderRadius;
  final Border? border;

  const _Button({
    required this.icon,
    required this.title,
    required this.subTitle,
    this.borderRadius,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: appColors.cardBg,
          borderRadius:
              borderRadius ?? BorderRadius.circular(LemonRadius.extraSmall),
          border: border,
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
                child: icon,
              ),
            ),
            SizedBox(
              width: Spacing.small,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: appText.sm,
                ),
                SizedBox(height: 2.w),
                Text(
                  subTitle,
                  style: appText.xs.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
