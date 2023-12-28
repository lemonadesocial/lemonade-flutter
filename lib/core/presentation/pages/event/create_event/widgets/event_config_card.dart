import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventConfigCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget icon;
  final Function() onTap;
  final bool? selected;

  const EventConfigCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.onTap,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: selected == true ? LemonColor.white12 : Colors.transparent,
          border: selected == true
              ? null
              : Border.all(color: colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                color:
                    selected == true ? LemonColor.white12 : colorScheme.surface,
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
                  description != ""
                      ? Text(
                          description!,
                          style: Typo.extraSmall.copyWith(
                            fontFamily: FontFamily.switzerVariable,
                            color: colorScheme.onSurface,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
