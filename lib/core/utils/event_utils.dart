import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

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

  static bool isCohost({required Event event, required String userId}) {
    if (event.id == null) return false;
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
      return const EventTicketManagementRoute();
    }
    return const EventPickMyTicketRoute();
  }
}
