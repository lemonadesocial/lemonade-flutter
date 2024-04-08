import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventConfigCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget icon;
  final Function() onTap;
  final bool? selected;
  final bool? loading;

  const EventConfigCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.onTap,
    this.selected,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall, vertical: Spacing.xSmall),
        decoration: BoxDecoration(
          color: selected == true ? LemonColor.atomicBlack : Colors.transparent,
          border:
              selected == true ? null : Border.all(color: LemonColor.white09),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Sizing.medium,
              height: Sizing.medium,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              ),
              child: loading == true ? Loading.defaultLoading(context) : icon,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (description?.isNotEmpty == true)
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        description!,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
