import 'package:app/core/domain/event/entities/event.dart';
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

class CreateSubSideEventButton extends StatelessWidget {
  final Event event;
  const CreateSubSideEventButton({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Button(
          onTap: () {
            AutoRouter.of(context).push(
              CreateEventRoute(parentEventId: event.id ?? ''),
            );
          },
          icon: Assets.icons.icSessionsGradient.svg(),
          title: t.event.subEvent.createSubEvent,
          subTitle: t.event.subEvent.createSubEventDescription,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: colorScheme.outlineVariant,
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
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
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
                color: LemonColor.chineseBlack,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
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
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  subTitle,
                  style: Typo.xSmall.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
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
