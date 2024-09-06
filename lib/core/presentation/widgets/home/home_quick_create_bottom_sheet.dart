import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
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

class HomeQuickCreateBottomSheet extends StatelessWidget {
  const HomeQuickCreateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.common.actions.create,
                  style: Typo.extraLarge.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  t.home.quickCreate.quickCreateDesc,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                Row(
                  children: [
                    Expanded(
                      child: _Item(
                        icon: Assets.icons.icPencil.svg(),
                        title: t.home.quickCreate.post,
                        subTitle: t.home.quickCreate.postDesc,
                        onTap: () {
                          AutoRouter.of(context).push(const CreatePostRoute());
                        },
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Expanded(
                      child: _Item(
                        icon: ThemeSvgIcon(
                          color: LemonColor.paleViolet,
                          builder: (filter) => Assets.icons.icHouseParty.svg(
                            colorFilter: filter,
                          ),
                        ),
                        title: t.home.quickCreate.event,
                        subTitle: t.home.quickCreate.eventDesc,
                        onTap: () {
                          AutoRouter.of(context).push(CreateEventRoute());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subTitle;
  final void Function() onTap;
  const _Item({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.xSmall),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              LemonColor.arsenic.withOpacity(0.55),
              LemonColor.charlestonGreen.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.01),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: Spacing.small),
            Text(
              title,
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 2.w),
            Text(
              subTitle,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
