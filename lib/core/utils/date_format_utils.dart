import 'package:app/core/utils/date_utils.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class DateFormatUtils {
  static const String fullDateFormat = 'EE, MMM d • hh:mm a';

  static const String dateOnlyFormat = 'EE, MMM d';

  static const String monthYearOnlyFormat = 'MMMM, yyyy';

  static const String timeOnlyFormat = 'hh:mm a';

  static String fullDateWithTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat(fullDateFormat).format(date.toLocal());
  }

  static String dateOnly(DateTime? date) {
    if (date == null) return '';
    return DateFormat(dateOnlyFormat).format(date.toLocal());
  }

  static String monthYearOnly(DateTime? date) {
    if (date == null) return '';
    return DateFormat(monthYearOnlyFormat).format(date.toLocal());
  }

  static String timeOnly(DateTime? date) {
    if (date == null) return '';
    return DateFormat(timeOnlyFormat).format(date.toLocal());
  }

  static String custom(DateTime? date, {required String pattern}) {
    if (date == null) return '';
    return DateFormat(pattern).format(date.toLocal());
  }

  static String dateWithTimezone({
    required DateTime dateTime,
    required String timezone,
    String? pattern = 'MMM d, yyyy h:mm a',
    bool withTimezoneOffset = true,
  }) {
    final location =
        timezone.isNotEmpty == true ? tz.getLocation(timezone) : null;
    final timezoneDateTime =
        location != null ? tz.TZDateTime.from(dateTime, location) : dateTime;
    final formattedDate = DateFormat(pattern).format(timezoneDateTime);
    return withTimezoneOffset
        ? '$formattedDate ${DateUtils.getGMTOffsetText(timezone)}'
        : formattedDate;
  }
}
