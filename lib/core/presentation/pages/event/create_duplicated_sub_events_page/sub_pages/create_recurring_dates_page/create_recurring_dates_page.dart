import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/sub_pages/create_recurring_dates_page/widgets/recurring_dates_preview_widget.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/sub_pages/create_recurring_dates_page/widgets/select_days_of_week_widget.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/sub_pages/create_recurring_dates_page/widgets/select_recurring_end_mode_widget.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/sub_pages/create_recurring_dates_page/widgets/select_repeat_mode_dropdown.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/widgets/select_time_of_day_bottomsheet.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/backend/event/query/generate_recurring_dates.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:web3modal_flutter/utils/debouncer.dart';

enum RecurringEndMode {
  until,
  count,
}

class CreateRecurringDatesPage extends StatefulWidget {
  final Event subEvent;
  final String timezone;
  final DateTime? initialStartDate;
  final Function(List<DateTime> dates)? onConfirm;

  const CreateRecurringDatesPage({
    super.key,
    required this.subEvent,
    required this.timezone,
    this.onConfirm,
    this.initialStartDate,
  });

  @override
  State<CreateRecurringDatesPage> createState() =>
      _CreateRecurringDatesPageState();
}

class _CreateRecurringDatesPageState extends State<CreateRecurringDatesPage> {
  final debouncer = Debouncer(milliseconds: 500);
  List<DateTime> dates = [];
  Enum$RecurringRepeat repeatMode = Enum$RecurringRepeat.daily;
  RecurringEndMode endMode = RecurringEndMode.until;
  int count = 5;
  List<int> dayOfWeeks = [];
  late DateTime startDate;
  late DateTime endDate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final utcNow = DateTime.now().toUtc();
    startDate = widget.initialStartDate ??
        tz.TZDateTime.from(
          utcNow,
          location,
        );
    endDate = startDate.add(
      widget.subEvent.end!.difference(widget.subEvent.start!),
    );
    dayOfWeeks = [startDate.weekday];
    generateRecurringDates();
  }

  String get timezone => widget.timezone;

  tz.Location get location => tz.getLocation(timezone);

  double get offsetInMinutes {
    return location.currentTimeZone.offset / 60000;
  }

  Future<void> generateRecurringDates() async {
    debouncer.run(() async {
      final utcStartDate = tz.TZDateTime.from(startDate, tz.UTC);
      final utcEndDate = tz.TZDateTime.from(endDate, tz.UTC);
      final input = Input$GenerateRecurringDatesInput(
        utcOffsetMinutes: offsetInMinutes,
        start: utcStartDate,
        repeat: repeatMode,
        count: endMode == RecurringEndMode.count ? count.toDouble() : null,
        dayOfWeeks:
            repeatMode == Enum$RecurringRepeat.weekly ? dayOfWeeks : null,
        end: endMode == RecurringEndMode.until ? utcEndDate : null,
      );
      setState(() {
        isLoading = true;
      });
      final result = await getIt<AppGQL>().client.query$GenerateRecurringDates(
            Options$Query$GenerateRecurringDates(
              fetchPolicy: FetchPolicy.networkOnly,
              variables: Variables$Query$GenerateRecurringDates(
                input: input,
              ),
            ),
          );

      setState(() {
        dates = (result.parsedData?.generateRecurringDates ?? [])
            .map((e) => tz.TZDateTime.from(e, location))
            .toList();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: BottomSheetGrabber(),
                    ),
                    LemonAppBar(
                      backgroundColor: LemonColor.atomicBlack,
                      leading: const SizedBox.shrink(),
                      title: t.event.sessionDuplication.chooseTime,
                    ),
                    _StartingDateWidget(
                      timezone: timezone,
                      date: startDate,
                      onChangeStartDate: (date) {
                        setState(() {
                          startDate = date;
                        });
                        generateRecurringDates();
                      },
                    ),
                    SizedBox(height: Spacing.xSmall),
                    SelectRepeatModeDropdown(
                      repeatMode: repeatMode,
                      onChange: (mode) {
                        setState(() {
                          repeatMode = mode;
                        });
                        generateRecurringDates();
                      },
                    ),
                    SizedBox(height: Spacing.medium),
                    if (endMode == RecurringEndMode.count &&
                        repeatMode == Enum$RecurringRepeat.weekly) ...[
                      SelectDaysOfWeekWidget(
                        selectedDays: dayOfWeeks,
                        onChangeSelectedDays: (days) {
                          setState(() {
                            dayOfWeeks = days;
                          });
                          generateRecurringDates();
                        },
                      ),
                      SizedBox(height: Spacing.medium),
                    ],
                    SelectRecurringEndMode(
                      repeatMode: repeatMode,
                      endMode: endMode,
                      endDate: endDate,
                      count: count.toString(),
                      timezone: timezone,
                      selectedDays: dayOfWeeks,
                      onChangeEndMode: (mode) {
                        setState(() {
                          endMode = mode;
                        });
                        generateRecurringDates();
                      },
                      onChangeCount: (mCount) {
                        final parsedCount = int.tryParse(mCount);
                        setState(() {
                          count = parsedCount ?? 0;
                        });
                        generateRecurringDates();
                      },
                      onChangeEndDate: (date) {
                        setState(() {
                          endDate = date;
                        });
                        generateRecurringDates();
                      },
                      onChangeSelectedDays: (days) {
                        setState(() {
                          dayOfWeeks = days;
                        });
                        generateRecurringDates();
                      },
                    ),
                    SizedBox(height: Spacing.large),
                    if (dates.isNotEmpty && !isLoading)
                      RecurringDatesPreviewWidget(
                        dates: dates,
                      ),
                    if (isLoading)
                      SizedBox(
                        child: Center(
                          child: Loading.defaultLoading(context),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  left: Spacing.small,
                  right: Spacing.small,
                  top: Spacing.smMedium,
                ),
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  border: Border(top: BorderSide(color: colorScheme.outline)),
                ),
                child: LinearGradientButton.secondaryButton(
                  textStyle: Typo.medium.copyWith(
                    color: Colors.black,
                    fontFamily: FontFamily.nohemiVariable,
                  ),
                  mode: GradientButtonMode.light,
                  label: t.event.sessionDuplication.addTimes(n: dates.length),
                  loadingWhen: isLoading,
                  onTap: () {
                    if (isLoading) {
                      return;
                    }
                    Navigator.pop(context, dates);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartingDateWidget extends StatelessWidget {
  final DateTime date;
  final String timezone;
  final void Function(DateTime) onChangeStartDate;
  const _StartingDateWidget({
    required this.date,
    required this.timezone,
    required this.onChangeStartDate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.sessionDuplication.startingOn,
          style: Typo.medium.copyWith(color: colorScheme.onSecondary),
        ),
        SizedBox(height: Spacing.xSmall),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  final results = await showCalendarDatePicker2Dialog(
                    dialogBackgroundColor: LemonColor.atomicBlack,
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      firstDayOfWeek: 1,
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayTextStyle: Typo.medium.copyWith(
                        color: LemonColor.paleViolet,
                        fontWeight: FontWeight.w700,
                      ),
                      selectedDayHighlightColor: LemonColor.paleViolet18,
                      todayTextStyle:
                          Typo.medium.copyWith(color: colorScheme.onPrimary),
                      okButtonTextStyle: Typo.medium.copyWith(
                        color: LemonColor.paleViolet,
                        fontWeight: FontWeight.w600,
                      ),
                      cancelButtonTextStyle: Typo.medium.copyWith(
                        color: LemonColor.paleViolet,
                        fontWeight: FontWeight.w600,
                      ),
                      dayTextStyle:
                          Typo.small.copyWith(color: colorScheme.onPrimary),
                    ),
                    dialogSize: Size(1.sw, 0.5.sw),
                    value: [
                      date,
                    ],
                  );
                  if (results?.isNotEmpty == true) {
                    if (results?.firstOrNull != null) {
                      final selectedDate = results!.firstOrNull!;
                      final newStartDate = tz.TZDateTime(
                        tz.getLocation(timezone),
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        date.hour,
                        date.minute,
                      );
                      onChangeStartDate(newStartDate);
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: Text(
                    DateFormat('EE, MMMM d').format(
                      date,
                    ),
                    style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  final timeOfDay =
                      await showCupertinoModalBottomSheet<TimeOfDay?>(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.5),
                    builder: (context) =>
                        SelectTimeOfDayBottomSheet(date: date),
                  );
                  if (timeOfDay != null) {
                    final newDate = tz.TZDateTime(
                      tz.getLocation(timezone),
                      date.year,
                      date.month,
                      date.day,
                      timeOfDay.hour,
                      timeOfDay.minute,
                    );
                    onChangeStartDate(newDate);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: Text(
                    DateFormat(DateFormatUtils.timeOnlyFormat).format(
                      date,
                    ),
                    style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
