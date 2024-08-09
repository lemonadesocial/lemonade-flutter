import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestItemWidget extends StatelessWidget {
  const QuestItemWidget({
    super.key,
    required this.points,
    required this.title,
    required this.onTap,
    this.repeatable,
    this.trackingCount,
    required this.disabled,
  });
  final int points;
  final String title;
  final VoidCallback onTap;
  final bool? repeatable;
  final int? trackingCount;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        if (disabled == true) {
          return;
        }
        onTap.call();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.smMedium,
          horizontal: Spacing.xSmall,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ThemeSvgIcon(
                  color: LemonColor.chineseBlack,
                  builder: (filter) => Assets.icons.icQuestLemonade.svg(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    colorFilter: filter,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      points.toString(),
                      style: Typo.medium.copyWith(
                        color: disabled == true
                            ? colorScheme.onPrimary
                            : LemonColor.sunrise,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: Spacing.smMedium),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.mediumPlus.copyWith(
                      color: disabled == true
                          ? colorScheme.onSecondary
                          : colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  if (repeatable == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Assets.icons.icRepeatRounded.svg(
                              width: 18.w,
                              height: 18.w,
                            ),
                            SizedBox(width: Spacing.superExtraSmall),
                            Text(
                              t.quest.repeatable,
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            if ((trackingCount ?? 0) > 0) ...[
                              SizedBox(
                                width: Spacing.superExtraSmall,
                              ),
                              Text(
                                ' •  ${t.quest.completeCount(
                                  count: trackingCount ?? '',
                                )}',
                                style: Typo.small.copyWith(
                                  color: colorScheme.onSecondary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (disabled != true)
              LemonOutlineButton(
                borderColor: LemonColor.paleViolet,
                label: t.common.actions.go.toUpperCase(),
                radius: BorderRadius.circular(LemonRadius.button),
                textColor: LemonColor.paleViolet,
              ),
            if (disabled == true)
              Container(
                width: Sizing.medium,
                height: Sizing.medium,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LemonColor.malachiteGreen.withOpacity(0.18),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: LemonColor.malachiteGreen,
                    builder: (filter) => Assets.icons.icDone.svg(
                      colorFilter: filter,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
