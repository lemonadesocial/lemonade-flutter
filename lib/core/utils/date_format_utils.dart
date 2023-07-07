import 'package:intl/intl.dart';

class DateFormatUtils {
  static const String defaultDateFormat = 'EE, MMM d • hh:mm a';

  static const String dateOnlyFormat = 'EE, MMM d';

  static const String monthYearOnlyFormat = 'MMMM, yyyy';

  static String fullDateWithTime(DateTime? date) {
    if(date == null) return '';
    return DateFormat(defaultDateFormat).format(date.toLocal());
  }

  static String dateOnly(DateTime? date) {
    if(date == null) return '';
    return DateFormat(dateOnlyFormat).format(date.toLocal());
  }

  static String monthYearOnly(DateTime? date) {
    if(date == null) return '';
    return DateFormat(monthYearOnlyFormat).format(date.toLocal());
  }
}