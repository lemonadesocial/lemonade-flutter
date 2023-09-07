enum EventTense {
  Current,
  Future,
  Past,
}

enum EventListingType {
  all,
  attending,
  hosting,
}

enum EventState {
  created,
  started,
  ended,
  cancelled,
}

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

enum OfferProvider { token, order, claimable, poap }

enum BroadcastProvider {
  local,
  twitch,
  youtube,
  zoom,
  video,
  embed,
}

enum BroadcastLifeCycleStatus {
  complete,
  created,
  live,
  liveStarting,
  ready,
  revoked,
  testStarting,
  testing,
}

enum BroadcastRecordingStatus {
  notRecording,
  recorded,
  recording,
}

enum EventRsvpState {
  accepted,
  declined,
  payment,
  pending,
}
