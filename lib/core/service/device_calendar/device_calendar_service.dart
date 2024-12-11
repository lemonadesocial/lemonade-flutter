import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as add_2_calendar;

class DeviceCalendarEvent {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String? description;
  final String? location;
  final String? url;

  DeviceCalendarEvent({
    required this.title,
    required this.startTime,
    required this.endTime,
    this.description,
    this.location,
    this.url,
  });
}

class DeviceCalendarService {
  /// Adds an event to Google Calendar using a web URL
  /// Returns true if the URL was launched successfully
  static Future<bool> addToGoogleCalendar({
    required DeviceCalendarEvent event,
  }) async {
    /// Pads a number with leading zero if needed
    String padZero(int number) => number.toString().padLeft(2, '0');

    /// Formats DateTime to Google Calendar format (YYYYMMDDTHHMMSSZ)
    String formatDateTime(DateTime dateTime) {
      // Convert to UTC and format
      final utcDateTime = dateTime.toUtc();

      return '${utcDateTime.year}'
          '${padZero(utcDateTime.month)}'
          '${padZero(utcDateTime.day)}'
          'T'
          '${padZero(utcDateTime.hour)}'
          '${padZero(utcDateTime.minute)}'
          '${padZero(utcDateTime.second)}'
          'Z';
    }

    // Format dates to Google Calendar format (YYYYMMDDTHHMMSSZ)
    final String startTimeStr = formatDateTime(event.startTime);
    final String endTimeStr = formatDateTime(event.endTime);

    // Construct Google Calendar URL
    final Uri googleEventUrl = Uri.parse(
        'https://www.google.com/calendar/render?action=TEMPLATE'
        '&text=${Uri.encodeComponent(event.title)}'
        '${event.description != null ? '&details=${Uri.encodeComponent(event.description!)}' : ''}'
        '${event.location != null ? '&location=${Uri.encodeComponent(event.location!)}' : ''}'
        '&dates=$startTimeStr/$endTimeStr');

    // Check if URL can be launched and launch it
    if (await canLaunchUrl(googleEventUrl)) {
      return await launchUrl(
        googleEventUrl,
        mode: LaunchMode.externalApplication,
      );
    }

    return false;
  }

  /// Adds an event to Apple Calendar using device_calendar package
  /// Returns true if the event was added successfully
  static Future<bool> addToAppleCalendar({
    required DeviceCalendarEvent event,
  }) async {
    try {
      final data = add_2_calendar.Event(
        title: event.title,
        description: event.description,
        location: event.location,
        startDate: event.startTime,
        endDate: event.endTime,
        iosParams: add_2_calendar.IOSParams(
          url: event.url,
        ),
      );
      final result = await add_2_calendar.Add2Calendar.addEvent2Cal(data);
      return result;
    } catch (e) {
      return false;
    }
  }
}
