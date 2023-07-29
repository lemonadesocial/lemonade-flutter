import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/// Provides extra functionality for formatting the time.
extension DateTimeExtension on DateTime {
  bool operator <(DateTime other) {
    return millisecondsSinceEpoch < other.millisecondsSinceEpoch;
  }

  bool operator >(DateTime other) {
    return millisecondsSinceEpoch > other.millisecondsSinceEpoch;
  }

  bool operator >=(DateTime other) {
    return millisecondsSinceEpoch >= other.millisecondsSinceEpoch;
  }

  bool operator <=(DateTime other) {
    return millisecondsSinceEpoch <= other.millisecondsSinceEpoch;
  }

  /// Two message events can belong to the same environment. That means that they
  /// don't need to display the time they were sent because they are close
  /// enaugh.
  static const minutesBetweenEnvironments = 10;

  /// Checks if two DateTimes are close enough to belong to the same
  /// environment.
  bool sameEnvironment(DateTime prevTime) {
    return millisecondsSinceEpoch - prevTime.millisecondsSinceEpoch <
        1000 * 60 * minutesBetweenEnvironments;
  }

  /// Returns a simple time String.
  /// TODO: Add localization
  String localizedTimeOfDay(BuildContext context) {
    if (MediaQuery.of(context).alwaysUse24HourFormat) {
      return '${_z(hour)}:${_z(minute)}';
    } else {
      return '${_z(hour % 12 == 0 ? 12 : hour % 12)}:${_z(minute)} ${hour > 11 ? "pm" : "am"}';
    }
  }

  /// Returns [localizedTimeOfDay()] if the ChatTime is today, the name of the week
  /// day if the ChatTime is this week and a date string else.
  String localizedTimeShort(BuildContext context) {
    final now = DateTime.now();

    final sameYear = now.year == year;

    final sameDay = sameYear && now.month == month && now.day == day;

    final sameWeek = sameYear &&
        !sameDay &&
        now.millisecondsSinceEpoch - millisecondsSinceEpoch <
            1000 * 60 * 60 * 24 * 7;

    if (sameDay) {
      return localizedTimeOfDay(context);
    } else if (sameWeek) {
      return DateFormat.EEEE(Localizations.localeOf(context).languageCode)
          .format(this);
    } else if (sameYear) {
      return Translations.of(context)!.matrix.dateWithoutYear(
        month: month.toString().padLeft(2, '0'),
        day: day.toString().padLeft(2, '0'),
      );
    }
    return Translations.of(context)!.matrix.dateWithYear(
      year: year.toString(),
      month: month.toString().padLeft(2, '0'),
      day: day.toString().padLeft(2, '0'),
    );
  }

  /// If the DateTime is today, this returns [localizedTimeOfDay()], if not it also
  /// shows the date.
  /// TODO: Add localization
  String localizedTime(BuildContext context) {
    final now = DateTime.now();

    final sameYear = now.year == year;

    final sameDay = sameYear && now.month == month && now.day == day;

    if (sameDay) return localizedTimeOfDay(context);
    return Translations.of(context)!.matrix.dateAndTimeOfDay(
      timeOfDay: localizedTimeShort(context),
      date: localizedTimeOfDay(context),
    );
  }

  static String _z(int i) => i < 10 ? '0${i.toString()}' : i.toString();
}
