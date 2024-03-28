import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDateTimeSettingSection extends StatelessWidget {
  const EventDateTimeSettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: LemonColor.atomicBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.small),
                topRight: Radius.circular(LemonRadius.small),
                bottomLeft: Radius.circular(LemonRadius.extraSmall),
                bottomRight: Radius.circular(LemonRadius.extraSmall),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DateTimeRowItem(
                color: LemonColor.malachiteGreen,
                text: 'Starts',
                date: '15 Jan at 8:00pm',
              ),
              SizedBox(height: Spacing.smMedium),
              const _DateTimeRowItem(
                color: LemonColor.coralReef,
                text: 'Ends',
                date: '16 Jan at 9:00pm',
              ),
            ],
          ),
        ),
        SizedBox(
          height: Spacing.superExtraSmall,
        ),
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: LemonColor.atomicBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.extraSmall),
                topRight: Radius.circular(LemonRadius.extraSmall),
                bottomLeft: Radius.circular(LemonRadius.small),
                bottomRight: Radius.circular(LemonRadius.small),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.icons.icGlobe.svg(),
                  SizedBox(
                    width: Spacing.smMedium / 2,
                  ),
                  Text(
                    'Timezone',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'GMT+05:30 Calcutta',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(width: Spacing.superExtraSmall),
                  Assets.icons.icArrowUpDown.svg(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DateTimeRowItem extends StatelessWidget {
  const _DateTimeRowItem({
    required this.color,
    required this.text,
    required this.date,
  });
  final Color color;
  final String text;
  final String date;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: Sizing.medium / 2,
          height: Sizing.medium / 2,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizing.medium / 2),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 6.5,
                top: 6.5,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: ShapeDecoration(
                    color: color,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              Text(
                date,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
