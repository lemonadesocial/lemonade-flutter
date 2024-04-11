import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/host_event_publish_flow_page.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';

class EventPublishHelper {
  static bool isTicketsFulfilled(Event event) {
    // ticket not fullfiled if there's only 1 ticket types and 1 prices
    if (event.eventTicketTypes?.length == 1) {
      final ticketType = event.eventTicketTypes?.first;
      if ((ticketType?.prices?.length ?? 0) <= 1) {
        return false;
      }
      return true;
    }
    return true;
  }

  static bool isCoverPhotoFulfilled(Event event) {
    return event.newNewPhotosExpanded?.isNotEmpty == true;
  }

  static bool isCollectiblesFulfilled(Event event) {
    return event.offers?.isNotEmpty == true;
  }

  static bool isRewardsFulfilled(Event event) {
    return event.rewards?.isNotEmpty == true;
  }

  static bool isProgramsFulfilled(Event event) {
    return event.sessions?.isNotEmpty == true;
  }

  static bool isCohostsFulfilled(Event event) {
    return event.cohosts?.isNotEmpty == true;
  }

  static bool isSpeakersFulfilled(Event event) {
    return event.speakerUsers?.isNotEmpty == true;
  }

  static bool isFAQsFulfilled(Event event) {
    return event.frequentQuestions?.isNotEmpty == true;
  }

  static Map<EventPublishRating, double> get progressByRating => {
        EventPublishRating.average: 0.15,
        EventPublishRating.good: 0.4,
        EventPublishRating.great: 0.625,
        EventPublishRating.awesome: 1,
      };

  static Map<EventPublishRating, Color> get colorByRating => {
        EventPublishRating.average: LemonColor.coralReef,
        EventPublishRating.good: LemonColor.sunrise,
        EventPublishRating.great: LemonColor.malachiteGreen,
        EventPublishRating.awesome: LemonColor.paleViolet,
      };
}
