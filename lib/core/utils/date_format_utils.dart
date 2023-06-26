import 'package:intl/intl.dart';

class DateFormatUtils {
  static String fullDateWithTime(DateTime? date) {
    if(date == null) return '';
    return DateFormat('EE, MMM d • HH:mm ').format(date.toLocal());
  }
}