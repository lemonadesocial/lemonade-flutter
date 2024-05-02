import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';

class ChartDateRangeBuilder extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Widget Function(
    DateTimeRange timeRange, {
    required void Function() selectStartDate,
    required void Function() selectEndDate,
  }) builder;

  const ChartDateRangeBuilder({
    super.key,
    this.startDate,
    this.endDate,
    required this.builder,
  });

  @override
  State<ChartDateRangeBuilder> createState() => _ChartDateRangeBuilderState();
}

class _ChartDateRangeBuilderState extends State<ChartDateRangeBuilder> {
  late DateTimeRange _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = DateTimeRange(
      start: widget.startDate ?? DateTime.now(),
      end: widget.endDate ?? DateTime.now()
        ..add(
          const Duration(days: 7),
        ),
    );
  }

  void _selectTimeRange() async {
    final newTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
      initialDateRange: _timeRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            datePickerTheme: DatePickerThemeData(
              rangePickerBackgroundColor: LemonColor.atomicBlack,
              rangeSelectionBackgroundColor: LemonColor.paleViolet12,
            ),
            colorScheme: ThemeData.dark().colorScheme.copyWith(
                  primary: LemonColor.paleViolet,
                  onPrimary: LemonColor.white,
                ),
          ),
          child: child!,
        );
      },
    );
    if (newTimeRange == null) {
      return;
    }
    setState(() {
      _timeRange = newTimeRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      _timeRange,
      selectEndDate: _selectTimeRange,
      selectStartDate: _selectTimeRange,
    );
  }
}
