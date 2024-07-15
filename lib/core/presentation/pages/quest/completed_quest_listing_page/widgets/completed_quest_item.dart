import 'package:app/core/domain/quest/entities/point_tracking_info.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CompletedQuestItem extends StatelessWidget {
  const CompletedQuestItem({
    super.key,
    required this.title,
    required this.pointTrackingInfo,
  });

  final PointTrackingInfo pointTrackingInfo;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String formattedDateTime = DateFormat('d MMM, HH:mm').format(
      pointTrackingInfo.createdAt?.toLocal() ?? DateTime.now().toLocal(),
    );
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                formattedDateTime,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "+${pointTrackingInfo.points}",
                style: Typo.medium.copyWith(
                  color: LemonColor.malachiteGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                t.quest.points,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
