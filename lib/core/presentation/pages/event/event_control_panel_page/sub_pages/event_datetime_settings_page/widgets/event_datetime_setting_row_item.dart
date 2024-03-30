import 'package:app/core/presentation/widgets/common/circle_dot_widget.dart';
import 'package:app/core/presentation/widgets/common/wheel_time_picker/wheel_time_picker.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
  final String label;
  final Color? dotColor;
  final DateTime selectedDateTime;
  final Function() onSelectTab;

  const EventDatetimeSettingRowItem({
    super.key,
    this.initialTab,
    this.expanded = false,
    required this.label,
    this.dotColor,
    required this.selectedDateTime,
    required this.onSelectTab,
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
    if (widget.expanded == true) {
      setState(() {
        activeIndex = 0;
      });
    }
    tabItems = [
      _TabItem(
        title: DateFormat('dd MMM').format(widget.selectedDateTime.toLocal()),
      ),
      _TabItem(
        title: DateFormat('h:mma').format(widget.selectedDateTime.toLocal()),
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
                  CircleDot(
                    color: widget.dotColor ?? LemonColor.snackBarSuccess,
                  ),
                  SizedBox(
                    width: Spacing.smMedium,
                  ),
                  Text(
                    widget.label,
                    style: Typo.mediumPlus
                        .copyWith(color: colorScheme.onSecondary),
                  ),
                ],
              ),
              Row(
                children: [
                  _CustomTab(
                    tabItem: tabItems[0],
                    onPress: () {
                      _tabController.animateTo(0);
                      widget.onSelectTab();
                    },
                    isActive: activeIndex == 0 && widget.expanded == true,
                  ),
                  SizedBox(width: Spacing.smMedium / 2),
                  _CustomTab(
                    tabItem: tabItems[1],
                    onPress: () {
                      _tabController.animateTo(1);
                      widget.onSelectTab();
                    },
                    isActive: activeIndex == 1 && widget.expanded == true,
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
                    value: [widget.selectedDateTime.toLocal()],
                    onValueChanged: (dates) {},
                  ),
                  WheelTimePicker(
                    timeOfDay: TimeOfDay.fromDateTime(widget.selectedDateTime.toLocal()),
                  ),
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
            borderRadius: BorderRadius.circular(LemonRadius.xSmall),
          ),
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
