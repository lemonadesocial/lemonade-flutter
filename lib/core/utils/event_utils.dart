import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/service/device_calendar/device_calendar_service.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:collection/collection.dart';

class EventUtils {
  static bool isAttending({required Event event, required String userId}) {
    if (event.id == null) return false;
    return ((event.accepted ?? []) +
            (event.cohosts ?? []) +
            (event.speakerUsers ?? []))
        .toSet()
        .contains(userId);
  }

  static bool isOwnEvent({required Event event, required String userId}) {
    if (event.id == null) return false;
    return event.host == userId;
  }

  static bool isCohost({
    required Event event,
    required String userId,
    // EventUserRole? eventUserRole,
  }) {
    if (event.id == null) return false;
    // if (eventUserRole != null) {
    //   final cohostRole = eventUserRole.roles?.where(
    //     (element) => element.roleExpanded?.code == Enum$RoleCode.Cohost,
    //   );
    //   if (cohostRole?.isNotEmpty == true) {
    //     return true;
    //   }
    // }
    return event.cohosts?.contains(userId) ?? false;
  }

  static String getEventThumbnailUrl({required Event event}) {
    if (event.newNewPhotosExpanded == null ||
        event.newNewPhotosExpanded!.isEmpty) {
      return '';
    }
    return ImageUtils.generateUrl(
      file: event.newNewPhotosExpanded!.first,
      imageConfig: ImageConfig.eventPhoto,
    );
  }

  static bool hasPoapOffers(Event event) {
    return (event.offers ?? [])
        .where((item) => item.provider == OfferProvider.poap)
        .toList()
        .isNotEmpty;
  }

  static String getAddress({
    required Event event,
    bool showFullAddress = false,
    bool isAttending = false,
    bool isOwnEvent = false,
  }) {
    final address = event.address;
    if (address == null) return '';

    if (!showFullAddress) {
      return [
        if (isAttending || isOwnEvent) ...[address.title, address.city],
        if (!isAttending && !isOwnEvent) ...[address.city, address.country],
      ].where((part) => part != null && part.trim().isNotEmpty).join(', ');
    }

    return [
      address.additionalDirections,
      address.street1,
      address.street2,
      address.city,
      address.region,
      address.country,
    ].where((part) => part != null && part.trim().isNotEmpty).join(', ');
  }

  static bool isInvited(
    Event event, {
    required String userId,
  }) {
    return (event.invited ?? []).contains(userId);
  }

  static PageRouteInfo getAssignTicketsRouteForBuyFlow({
    required Event event,
    required userId,
  }) {
    // this case is for when users buy additional tickets
    if (isAttending(event: event, userId: userId)) {
      return MyEventTicketAssignmentRoute(
        event: event,
      );
    }
    return const EventPickMyTicketRoute();
  }

  static bool isEventLive(Event event) {
    final now = DateTime.now();
    return event.start != null &&
        event.end != null &&
        now.isAfter(event.start!) &&
        now.isBefore(event.end!);
  }

  static bool isLiveOrUpcoming(Event event) {
    return event.start != null &&
        (!date_utils.DateUtils.isPast(event.start) ||
            (date_utils.DateUtils.isPast(event.start) &&
                event.end != null &&
                !date_utils.DateUtils.isPast(event.end)));
  }

  static String? getDurationToEventText(
    Event event, {
    bool durationOnly = false,
  }) {
    final now = DateTime.now();
    if (event.start == null && event.end == null) return null;
    // Is Live event
    if (event.start!.isBefore(now) && event.end!.isAfter(now)) {
      final Duration difference = now.difference(event.start!);
      final int days = difference.inDays;
      if (durationOnly) {
        return prettyDuration(difference, tersity: DurationTersity.day);
      }
      if (days == 0) {
        return t.event.eventStarted;
      }
      return t.event.eventStartedDaysAgo(days: days);
    }
    // Is upcoming event
    else if (event.start!.isAfter(now) && event.end!.isAfter(now)) {
      final durationToEvent = event.start!.difference(now);
      final prettyDurationString = prettyDuration(
        durationToEvent,
        tersity: (durationToEvent.inDays) < 1
            ? (durationToEvent.inHours) >= 1
                ? DurationTersity.hour
                : DurationTersity.minute
            : DurationTersity.day,
        upperTersity: DurationTersity.day,
      );
      if (durationOnly) {
        return prettyDurationString;
      }
      return t.event.startingInTime(time: prettyDurationString);
    }
    return durationOnly ? null : t.event.eventEnded;
  }

  /// Formats the event date and time for display.
  ///
  /// This function handles both single-day and multi-day events:
  ///
  /// 1. Single-day events:
  ///    - Date: Full day name and date (e.g., "Thursday, September 26")
  ///    - Time: Start and end times with GMT offset (e.g., "11:00 AM - 1:00 PM GMT+4")
  ///
  /// 2. Multi-day events:
  ///    - Date: Start day's full name and date (e.g., "Thursday, September 26")
  ///    - Time: Start time, end date, end time, and GMT offset
  ///      (e.g., "11:00 AM - September 30, 12:00 PM GMT+1")
  ///
  /// Returns a tuple of (formattedDate, formattedTime).
  /// If event data is incomplete, returns empty strings.
  static (String, String) getFormattedEventDateAndTime(Event event) {
    if (event.start == null ||
        event.end == null ||
        event.timezone?.isNotEmpty != true) {
      return ('', '');
    }
    final location = tz.getLocation(event.timezone!);
    final timezoneStartDate = tz.TZDateTime.from(event.start!, location);
    final timezoneEndDate = tz.TZDateTime.from(event.end!, location);

    final isSameDay = timezoneStartDate.year == timezoneEndDate.year &&
        timezoneStartDate.month == timezoneEndDate.month &&
        timezoneStartDate.day == timezoneEndDate.day;

    final dateFormatter = DateFormat('EEE, MMM d');
    final timeFormatter = DateFormat('h:mma');
    final endDateFormatter = DateFormat('MMM d');

    final startDateStr = dateFormatter.format(timezoneStartDate);
    final startTimeStr = timeFormatter.format(timezoneStartDate).toLowerCase();
    final endTimeStr = timeFormatter.format(timezoneEndDate).toLowerCase();
    final gmtOffset = date_utils.DateUtils.getGMTOffsetText(event.timezone!);

    if (isSameDay) {
      return (startDateStr, '$startTimeStr - $endTimeStr $gmtOffset');
    } else {
      final endDateStr = endDateFormatter.format(timezoneEndDate);
      return (
        startDateStr,
        '$startTimeStr - $endDateStr, $endTimeStr $gmtOffset'
      );
    }
  }

  static bool isRegisterFormRequired({
    required Event event,
  }) {
    final isFormRequired = (event.applicationProfileFields ?? []).isNotEmpty ||
        (event.applicationQuestions ?? []).isNotEmpty;
    return isFormRequired;
  }

  static bool isOnlyOneTicketTypeAndFreeAndLimited({
    required Event event,
  }) {
    final isOnlyOneTicket = event.eventTicketTypes?.length == 1;
    if (!isOnlyOneTicket) {
      return false;
    }
    final ticketType = event.eventTicketTypes?.first;
    final isOnlyOnePrice = ticketType?.prices?.length == 1;

    if (!isOnlyOnePrice) {
      return false;
    }

    final isOnlyFreeAndLimited = ticketType?.ticketLimitPer == 1 &&
        ticketType?.prices?.firstOrNull?.cost == '0';
    return isOnlyFreeAndLimited;
  }

  static bool isOneClickRegister({
    required Event event,
  }) {
    if (isRegisterFormRequired(event: event)) {
      return false;
    }

    return isOnlyOneTicketTypeAndFreeAndLimited(event: event);
  }

  static List<User> getVisibleCohosts(Event event) {
    final visibleCohosts =
        (event.visibleCohostsExpanded ?? []).whereType<User>().toList();

    bool isCohost(String userId) {
      return (event.cohosts ?? []).contains(userId);
    }

    if (event.hideCohosts == true) {
      return visibleCohosts.where((user) => !isCohost(user.userId)).toList();
    }
    return visibleCohosts;
  }

  static DeviceCalendarEvent generateDeviceCalendarEvent(
    BuildContext context, {
    required Event event,
  }) {
    final eventUrl = '${AppConfig.webUrl}/e/${event.shortId}';
    final t = Translations.of(context);
    return DeviceCalendarEvent(
      title: event.title ?? '',
      description: t.common.deviceCalendar.eventPlaceholder(url: eventUrl),
      startTime: event.start ?? DateTime.now(),
      endTime: event.end ?? DateTime.now(),
      location: EventUtils.getAddress(event: event),
      url: eventUrl,
    );
  }

  static bool isWalletVerifiedRequired(
    Event event, {
    required Enum$BlockchainPlatform platform,
  }) {
    final applicationBlockchainPlatforms = event.rsvpWalletPlatforms;
    final isRequired = applicationBlockchainPlatforms
            ?.firstWhereOrNull((element) => element.platform == platform)
            ?.isRequired ??
        false;
    return isRequired;
  }

  static DateTime getDefaultStartDateTime({
    DateTime? parentEventStart,
    DateTime? parentEventEnd,
  }) {
    final now = DateTime.now();

    // If parent event has not started: session datetime defaults to parent event date
    if (parentEventStart != null && parentEventStart.isAfter(now)) {
      return parentEventStart;
    }
    // Round up to next 30 minutes
    final minutes = now.minute;
    final roundedMinutes = minutes <= 30 ? 30 : 60;

    return DateTime(
      now.year,
      now.month,
      now.day,
      now.hour + (roundedMinutes == 60 ? 1 : 0),
      roundedMinutes == 60 ? 0 : roundedMinutes,
    );
  }

  static DateTime getDefaultEndDateTime({
    DateTime? parentEventStart,
    DateTime? parentEventEnd,
  }) {
    final now = DateTime.now();

    // If parent event has not started: session datetime defaults to parent event date
    if (parentEventStart != null &&
        parentEventEnd != null &&
        parentEventStart.isAfter(now)) {
      return parentEventEnd;
    }
    // Add 1 hour to start time
    return getDefaultStartDateTime().add(const Duration(hours: 1));
  }
}
