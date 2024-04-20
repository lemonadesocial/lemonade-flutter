import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackViewItem extends StatelessWidget {
  final Widget icon;
  final String count;
  final String label;
  const TrackViewItem({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.superExtraSmall),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.large,
            height: 52.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.xSmall),
              color: colorScheme.secondaryContainer,
            ),
            child: Center(
              child: icon,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                label,
                style: Typo.small,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
