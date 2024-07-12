import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestItemWidget extends StatelessWidget {
  const QuestItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    this.repeatable,
    this.trackingCount,
  });

  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final bool? repeatable;
  final int? trackingCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Spacing.small),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        subTitle == ''
                            ? const SizedBox.shrink()
                            : Text(
                                subTitle,
                                style: Typo.medium.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Assets.icons.icArrowBack.svg(
                    width: 18.w,
                    height: 18.w,
                  ),
                ],
              ),
            ),
            repeatable == true
                ? Container(
                    color: LemonColor.white03,
                    padding: EdgeInsets.all(Spacing.small),
                    child: Row(
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
                          ],
                        ),
                        (trackingCount ?? 0) > 0
                            ? Row(
                                children: [
                                  Text(
                                    t.quest.completeCount(
                                      count: trackingCount ?? '',
                                    ),
                                    style: Typo.small.copyWith(
                                      color: colorScheme.onSecondary,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: Spacing.superExtraSmall),
                                  Assets.icons.icDoneAllRounded.svg(
                                    width: 18.w,
                                    height: 18.w,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
