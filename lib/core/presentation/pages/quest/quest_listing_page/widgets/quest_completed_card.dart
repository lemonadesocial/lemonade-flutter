import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestCompletedCard extends StatelessWidget {
  const QuestCompletedCard({
    super.key,
    required this.completedCount,
    required this.pointsCount,
    required this.typeTitle,
  });
  final int completedCount;
  final int pointsCount;
  final String? typeTitle;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.w,
            color: colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: LemonColor.white09,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LemonRadius.normal),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.icDoneAllRoundedGreen.svg(),
              ],
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.quest.questsTypeCompleted(
                    count: completedCount,
                    type: typeTitle ?? '',
                  ),
                  // '12 Events Quests completed',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    height: 0,
                  ),
                ),
                SizedBox(height: 2.w),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    t.quest.pointsEarned(n: pointsCount, count: pointsCount),
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Assets.icons.icArrowBack.svg(
            width: 18.w,
            height: 18.w,
          ),
        ],
      ),
    );
  }
}
