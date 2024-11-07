import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final itemWidth = (1.sw - 2 * Spacing.small - 24.w) / 5;

class RecurringDatesPreviewWidget extends StatelessWidget {
  final List<DateTime> dates;
  const RecurringDatesPreviewWidget({
    required this.dates,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DottedBorder(
      dashPattern: [
        4.w,
      ],
      radius: Radius.circular(LemonRadius.medium),
      borderType: BorderType.RRect,
      color: colorScheme.outline,
      padding: EdgeInsets.all(4.w),
      child: SizedBox(
        height: 72.w,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(width: 4.w),
          itemBuilder: (context, index) {
            if (dates.length < 5) {
              if (index > dates.length - 1) {
                return const SizedBox.shrink();
              }
              final date = dates[index];
              return _DateItem(
                date: date,
              );
            }

            if (dates.length == 5) {
              final date = dates[index];
              return _DateItem(
                date: date,
              );
            }

            if (dates.length > 5) {
              if (index == 2) {
                return _CountItem(
                  count: dates.length - 4,
                );
              }
              final date = index == 3
                  ? dates[dates.length - 2]
                  : index == 4
                      ? dates[dates.length - 1]
                      : dates[index];
              return _DateItem(
                date: date,
              );
            }
            return Text(dates[index].toString());
          },
        ),
      ),
    );
  }
}

class _DateItem extends StatelessWidget {
  final DateTime date;
  const _DateItem({
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        color: LemonColor.chineseBlack,
      ),
      padding: EdgeInsets.all(Spacing.xSmall),
      child: Column(
        children: [
          Text(
            DateFormat('MMM').format(date),
            style: Typo.xSmall.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          Text(
            date.day.toString(),
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          Text(
            DateFormat('EEE').format(date),
            style: Typo.xSmall.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountItem extends StatelessWidget {
  final int count;
  const _CountItem({required this.count});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: Center(
        child: Text(
          '+ $count',
          style: Typo.medium.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
