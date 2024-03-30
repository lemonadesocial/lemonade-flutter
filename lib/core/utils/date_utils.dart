import 'package:app/core/constants/event/event_constants.dart';
import 'package:intl/intl.dart';

class DateUtils {
  static DateTime get today => DateTime.now();
  static const dateFormatDayMonthYear = 'dd/MM/yyyy';

  /// return [start, end] of current week
  static List<DateTime> get thisWeek {
    DateTime thisWeekStart =
        DateTime(today.year, today.month, today.day - today.weekday + 1);
    DateTime thisWeekEnd = thisWeekStart
        .add(const Duration(days: 7))
        .subtract(const Duration(days: 1));

    return [thisWeekStart, thisWeekEnd];
  }

  /// return [start, end] of current weekend
  static List<DateTime> get thisWeekend {
    int todayWeekday = today.weekday;
    final [startWeek, endWeek] = thisWeek;

    DateTime thisWeekendStart;

    if (todayWeekday <= DateTime.friday) {
      thisWeekendStart =
          startWeek.add(Duration(days: DateTime.saturday - startWeek.weekday));
    } else {
      thisWeekendStart = endWeek.subtract(const Duration(days: 1));
    }

    DateTime thisWeekendEnd = thisWeekendStart.add(const Duration(days: 1));

    return [thisWeekendStart, thisWeekendEnd];
  }

  /// return [start, end] of current weekend
  static List<DateTime> get nextMonth {
    DateTime nextMonthStart = DateTime(today.year, today.month + 1);
    DateTime nextMonthEnd =
        DateTime(today.year, today.month + 2).subtract(const Duration(days: 1));

    return [nextMonthStart, nextMonthEnd];
  }

  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isTomorrow(DateTime? date) {
    if (date == null) return false;
    return DateUtils.isToday(date.subtract(const Duration(days: 1)));
  }

  static bool isThisWeek(DateTime? date) {
    if (date == null) return false;

    final [start, end] = DateUtils.thisWeek;

    return date.isAfter(start) && date.isBefore(end);
  }

  static bool isThisWeekend(DateTime? date) {
    if (date == null) return false;

    final [start, end] = DateUtils.thisWeekend;

    return date.isAfter(start) && date.isBefore(end);
  }

  static bool isNextWeek(DateTime? date) {
    if (date == null) return false;

    final [thisWeekStart, thisWeekEnd] = DateUtils.thisWeek;

    DateTime nextWeekStart = thisWeekStart.add(const Duration(days: 7));
    DateTime nextWeekEnd = thisWeekEnd.add(const Duration(days: 7));

    return date.isAfter(nextWeekStart) && date.isBefore(nextWeekEnd);
  }

  static bool isNextWeekend(DateTime? date) {
    if (date == null) return false;

    final [start, end] = DateUtils.thisWeekend;

    DateTime nextWeekendStart = start.add(const Duration(days: 7));
    DateTime nextWeekendEnd = end.add(const Duration(days: 7));

    return date.isAfter(nextWeekendStart) && date.isBefore(nextWeekendEnd);
  }

  static bool isNextMonth(DateTime? date) {
    if (date == null) return false;

    final [start, end] = DateUtils.nextMonth;

    return date.isAfter(start) && date.isBefore(end);
  }

  static bool isPast(DateTime? date) {
    if (date == null) return false;
    final originToday = DateTime(today.year, today.month, today.day);
    return date.isBefore(originToday);
  }

  static String formatTimeRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) return '';
    String formattedStartTime = DateFormat.jm().format(start);
    String formattedEndTime = DateFormat.jm().format(end);
    String formattedTimeRange = '$formattedStartTime - $formattedEndTime';
    return formattedTimeRange;
  }

  static String toLocalDateString(DateTime input) {
    return DateFormat(DateUtils.dateFormatDayMonthYear).format(
      input.toLocal(),
    );
  }

  static DateTime parseDateString(String dateString) {
    DateFormat format = DateFormat(DateUtils.dateFormatDayMonthYear);
    return DateTime.parse(
      format.parse(dateString).toUtc().toIso8601String(),
    );
  }

  static bool isValidDateTime(String input) {
    try {
      DateTime.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  static formatDateTimeToDDMMYYYY(String input) {
    DateTime dateTime = DateTime.parse(input);
    String formattedDate =
        DateFormat(DateUtils.dateFormatDayMonthYear).format(dateTime);
    return formattedDate;
  }

  static formatForDateSetting(DateTime dateTime) {
    String formattedDate = DateFormat('d MMM').format(dateTime);
    String formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();
    return '$formattedDate at $formattedTime';
  }

  static String padWithZero(int time) {
    return time.toString().padLeft(2, '0');
  }

  static String getUserTimezoneOptionText() {
    Duration offset = DateTime.now().timeZoneOffset;
    String sign = (offset.inHours.isNegative) ? '-' : '+';
    int hours = offset.inHours;
    int minutes = offset.inMinutes.remainder(60);
    String timezone = 'GMT$sign${padWithZero(hours)}:${padWithZero(minutes)}';
    Map<String, String>? selectedOption =
        EventConstants.timezoneOptions.firstWhere(
      (option) => option['text']!.contains(timezone),
      orElse: () => {},
    );
    return selectedOption['text'] ?? '';
  }

  static String getUserTimezoneOptionValue() {
    Duration offset = DateTime.now().timeZoneOffset;
    String sign = (offset.inHours.isNegative) ? '-' : '+';
    int hours = offset.inHours;
    int minutes = offset.inMinutes.remainder(60);
    String timezone = 'GMT$sign${padWithZero(hours)}:${padWithZero(minutes)}';
    Map<String, String>? selectedOption =
        EventConstants.timezoneOptions.firstWhere(
      (option) => option['text']!.contains(timezone),
      orElse: () => {},
    );
    return selectedOption['value'] ?? '';
  }
}
