enum EventTimeFilter {
  today(labelKey: 'today', value: 'today'),
  tomorrow(labelKey: 'tomorrow', value: 'tomorrow'),
  thisWeek(labelKey: 'thisWeek', value: 'this_week'),
  thisWeekend(labelKey: 'thisWeekend', value: 'this_weekend'),
  nextWeek(labelKey: 'nextWeek', value: 'next_week'),
  nextWeekend(labelKey: 'nextWeekend', value: 'next_weekend'),
  nextMonth(labelKey: 'nextMonth', value: 'next_month');

  final String labelKey;
  final String value;
  const EventTimeFilter({
    required this.labelKey,
    required this.value,
  });
}
