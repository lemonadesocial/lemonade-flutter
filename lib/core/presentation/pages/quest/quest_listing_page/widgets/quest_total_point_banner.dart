import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestTotalPointBanner extends StatelessWidget {
  final int totalPoint;
  const QuestTotalPointBanner({
    required this.totalPoint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.medium,
        vertical: Spacing.medium * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: Assets.images.questPointBg.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.icQuestLemonadeGradient.svg(
                  width: Sizing.large,
                  height: Sizing.large,
                ),
                SizedBox(width: Spacing.superExtraSmall),
                Text(
                  totalPoint.toString(),
                  style: Typo.extraSmall.copyWith(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onPrimary,
                    fontFamily: FontFamily.spaceMono,
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              t.quest.totalPointsEarned,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
