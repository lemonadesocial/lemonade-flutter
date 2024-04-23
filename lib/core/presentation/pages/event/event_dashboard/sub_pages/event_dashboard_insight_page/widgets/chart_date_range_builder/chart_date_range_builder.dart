import 'package:app/core/utils/calendar_utils.dart';
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

  void _selectStartDate() {
    showCalendar(
      context,
      initialDay: _timeRange.start,
      onDateSelect: (selectedDate) {
        if (selectedDate.isAfter(_timeRange.end)) {
          return;
        }
        setState(() {
          _timeRange = DateTimeRange(start: selectedDate, end: _timeRange.end);
        });
      },
    );
  }

  void _selectEndDate() {
    showCalendar(
      context,
      initialDay: _timeRange.end,
      onDateSelect: (selectedDate) {
        if (selectedDate.isBefore(_timeRange.start)) {
          return;
        }
        setState(() {
          _timeRange =
              DateTimeRange(start: _timeRange.start, end: selectedDate);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      _timeRange,
      selectEndDate: _selectEndDate,
      selectStartDate: _selectStartDate,
    );
  }
}
