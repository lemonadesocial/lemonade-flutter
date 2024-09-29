import 'package:app/core/constants/event/event_constants.dart';
import 'package:intl/intl.dart';

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

  static String getGMTOffsetText(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    try {
      final option = EventConstants.timezoneOptions.firstWhere(
        (option) => option['value'] == value,
        orElse: () => {'text': '', 'value': value},
      );
      final text = option['text'] ?? '';
      final match = RegExp(r'\(([^)]+)\)').firstMatch(text);

      return match?.group(1) ?? '';
    } catch (e) {
      return '';
    }
  }

  static String dateWithTimezone({
    required DateTime dateTime,
    required String timezone,
    String? pattern = 'MMM d, yyyy h:mm a',
    bool withTimezoneOffset = true,
  }) {
    final formattedDate = DateFormat(pattern).format(dateTime.toLocal());
    return withTimezoneOffset
        ? '$formattedDate ${getGMTOffsetText(timezone)}'
        : formattedDate;
  }
}
