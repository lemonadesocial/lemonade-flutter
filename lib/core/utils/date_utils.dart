
class DateUtils {
  static DateTime get today => DateTime.now();

  /// return [start, end] of current week
  static List<DateTime> get thisWeek {
    final thisWeekStart = DateTime(today.year, today.month, today.day - today.weekday + 1);
    final thisWeekEnd = thisWeekStart.add(const Duration(days: 7)).subtract(const Duration(days: 1));

    return [thisWeekStart, thisWeekEnd];
  }

  /// return [start, end] of current weekend
  static List<DateTime> get thisWeekend {
    final todayWeekday = today.weekday;
    final [startWeek, endWeek] = thisWeek;

    DateTime thisWeekendStart;

    if(todayWeekday <= DateTime.friday) {
      thisWeekendStart = startWeek.add(Duration(days: DateTime.saturday - startWeek.weekday));
    } else {
      thisWeekendStart = endWeek.subtract(const Duration(days: 1));
    }

    final thisWeekendEnd = thisWeekendStart.add(const Duration(days: 1));

    return [thisWeekendStart, thisWeekendEnd];
  }

  /// return [start, end] of current weekend
  static List<DateTime> get nextMonth {
    final nextMonthStart = DateTime(today.year, today.month + 1);
    final nextMonthEnd = DateTime(today.year, today.month + 2).subtract(const Duration(days: 1));

    return [nextMonthStart, nextMonthEnd];
  }

  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
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

    final nextWeekStart = thisWeekStart.add(const Duration(days: 7));
    final nextWeekEnd = thisWeekEnd.add(const Duration(days: 7));

    return date.isAfter(nextWeekStart) && date.isBefore(nextWeekEnd);
  }

  static bool isNextWeekend(DateTime? date) {
    if (date == null) return false;

    final [start, end] = DateUtils.thisWeekend;

    final nextWeekendStart = start.add(const Duration(days: 7));
    final nextWeekendEnd = end.add(const Duration(days: 7));

    return date.isAfter(nextWeekendStart) && date.isBefore(nextWeekendEnd);
  }

  static bool isNextMonth(DateTime? date) {
    if (date == null) return false;

    final [start, end] = DateUtils.nextMonth;

    return date.isAfter(start) && date.isBefore(end);
  }

  static bool isPast(DateTime? date) {
    if(date == null) return false;
    final originToday = DateTime(today.year, today.month, today.day);
    return date.isBefore(originToday);
  }
}
