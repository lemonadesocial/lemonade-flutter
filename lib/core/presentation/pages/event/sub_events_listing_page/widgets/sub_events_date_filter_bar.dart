import 'package:app/core/presentation/pages/event/sub_events_listing_page/sub_events_listing_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventsDateFilterBar extends StatelessWidget {
  final SubEventViewMode viewMode;
  final DateTime selectedDate;
  final Function()? onToggle;
  final Function(SubEventViewMode viewMode)? onViewModeChange;
  const SubEventsDateFilterBar({
    super.key,
    required this.selectedDate,
    required this.viewMode,
    this.onToggle,
    this.onViewModeChange,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: InkWell(
            onTap: onToggle,
            child: Container(
              height: Sizing.large,
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.medium),
                border: Border.all(
                  color: colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Center(
                      child: Icon(
                        Icons.today_outlined,
                        size: 18.w,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  VerticalDivider(
                    width: 1.w,
                    color: colorScheme.outline,
                    thickness: 1.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        SizedBox(width: Spacing.small),
                        Text(
                          DateFormatUtils.monthYearOnly(selectedDate),
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Assets.icons.icArrowDown.svg(
                          color: colorScheme.onSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          flex: 2,
          child: ToggleButtons(
            borderRadius: BorderRadius.circular(LemonRadius.medium),
            fillColor: LemonColor.chineseBlack,
            splashColor: Colors.transparent,
            isSelected: [
              viewMode == SubEventViewMode.listing,
              viewMode == SubEventViewMode.calendar,
            ],
            onPressed: (index) {
              if (index == 0) {
                onViewModeChange?.call(SubEventViewMode.listing);
              } else {
                onViewModeChange?.call(SubEventViewMode.calendar);
              }
            },
            children: [
              ThemeSvgIcon(
                color: viewMode == SubEventViewMode.listing
                    ? colorScheme.onPrimary
                    : colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icListBullets.svg(
                  colorFilter: filter,
                ),
              ),
              ThemeSvgIcon(
                color: viewMode == SubEventViewMode.calendar
                    ? colorScheme.onPrimary
                    : colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icCalendarViewDay.svg(
                  colorFilter: filter,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
