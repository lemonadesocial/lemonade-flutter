import 'package:app/core/presentation/widgets/common/circle_dot_widget.dart';
import 'package:app/core/presentation/widgets/common/wheel_time_picker/wheel_time_picker.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

enum EventDatetimeTabs {
  date(tabIndex: 0),
  time(tabIndex: 1);

  const EventDatetimeTabs({
    required this.tabIndex,
  });

  final int tabIndex;
}

class _TabItem {
  final String title;
  const _TabItem({
    required this.title,
  });
}

class EventDatetimeSettingRowItem extends StatefulWidget {
  final EventDatetimeTabs? initialTab;
  final bool? expanded;

  const EventDatetimeSettingRowItem({
    super.key,
    this.initialTab,
    this.expanded = false,
  });

  @override
  State<EventDatetimeSettingRowItem> createState() =>
      _EventDatetimeSettingRowItemState();
}

class _EventDatetimeSettingRowItemState
    extends State<EventDatetimeSettingRowItem> with TickerProviderStateMixin {
  late TabController _tabController;
  late final List<_TabItem> tabItems;
  int activeIndex = 0;

  @override
  initState() {
    super.initState();
    tabItems = [
      const _TabItem(
        title: "22 Jan",
      ),
      const _TabItem(
        title: "8:00pm",
      ),
    ];
    _tabController = TabController(length: tabItems.length, vsync: this);
    _tabController.addListener(() {
      if (activeIndex != _tabController.index) {
        setState(() {
          activeIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const CircleDot(color: LemonColor.snackBarSuccess),
                  SizedBox(
                    width: Spacing.smMedium,
                  ),
                  Text(
                    t.event.datetimeSettings.starts,
                    style: Typo.mediumPlus
                        .copyWith(color: colorScheme.onSecondary),
                  ),
                ],
              ),
              Row(
                children: [
                  _CustomTab(
                    tabItem: tabItems[0],
                    onPress: () => _tabController.animateTo(0),
                    isActive: activeIndex == 0,
                  ),
                  SizedBox(width: Spacing.smMedium / 2),
                  _CustomTab(
                    tabItem: tabItems[1],
                    onPress: () => _tabController.animateTo(1),
                    isActive: activeIndex == 1,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (widget.expanded == true) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
            child: SizedBox(
              height: 300.h,
              child: TabBarView(
                controller: _tabController,
                children: [
                  CalendarDatePicker2(
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayTextStyle: TextStyle(
                        color: LemonColor.paleViolet,
                        fontWeight: FontWeight.w700,
                      ),
                      selectedDayHighlightColor: LemonColor.paleViolet18,
                      customModePickerIcon: const SizedBox(),
                      todayTextStyle:
                          Typo.small.copyWith(color: colorScheme.onPrimary),
                      dayTextStyle:
                          Typo.small.copyWith(color: colorScheme.onPrimary),
                    ),
                    value: [],
                    onValueChanged: (dates) {},
                  ),
                  const WheelTimePicker(),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _CustomTab extends StatelessWidget {
  const _CustomTab({
    required this.tabItem,
    required this.onPress,
    this.isActive = false,
  });

  final _TabItem tabItem;
  final Function() onPress;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => onPress(),
      child: Container(
        width: 96.w,
        height: 40.h,
        decoration: ShapeDecoration(
          color: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(LemonRadius.xSmall)),
        ),
        child: Center(
          child: Text(
            tabItem.title,
            style: Typo.mediumPlus.copyWith(
              color: isActive == true
                  ? colorScheme.tertiary
                  : colorScheme.onSecondary,
              fontWeight: isActive == true ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
