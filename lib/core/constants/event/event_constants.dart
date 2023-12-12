class EventConstants {
  /// Guest limit per 2
  static String defaultEventGuestLimitPer = '2';

  /// Guest limit 100
  static String defaultEventGuestLimit = '100';
}

class EventDateTimeConstants {
  static final DateTime currentDateTime = DateTime.now();

  static final DateTime defaultStartDateTime = DateTime(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day + 3,
    10,
  );

  static final DateTime defaultEndDateTime = DateTime(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day + 6,
    18,
  );
}
