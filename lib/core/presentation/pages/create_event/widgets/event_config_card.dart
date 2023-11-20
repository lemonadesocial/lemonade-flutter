import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventConfigCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;

  const EventConfigCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        // Handle tap action for the card
        if (kDebugMode) {
          print('Card tapped! $title');
        }
      },
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: icon,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.small.copyWith(
                      fontFamily: FontFamily.nohemiVariable,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    description,
                    style: Typo.extraSmall.copyWith(
                      fontFamily: FontFamily.switzerVariable,
                      color: colorScheme.onSurface,
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
