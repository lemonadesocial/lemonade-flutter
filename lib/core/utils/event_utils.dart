import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:duration/duration.dart';

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

  static String getAddress(Event event) {
    final address = event.address;
    return [
      address?.street1,
      address?.street2,
      address?.city,
      address?.region,
      address?.country,
    ].where((element) => element != null).join(', ');
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
      return t.event.eventStartIn(time: prettyDurationString);
    }
    return durationOnly ? null : t.event.eventEnded;
  }
}
