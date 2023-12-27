import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

enum EventPrivacy { public, private }

enum EventConfigurationType {
  visibility,
  guestSettings,
  startDateTime,
  endDateTime,
  virtual,
  location
}

class EventConfiguration {
  EventConfiguration({
    required this.type,
    required this.title,
    this.description,
    required this.icon,
  });

  final EventConfigurationType type;
  String title;
  String? description;
  final Widget icon;

  static List<EventConfiguration> defaultEventConfigurations() {
    final List<EventConfiguration> eventConfigs = [
      EventConfiguration(
        type: EventConfigurationType.visibility,
        title: 'Public',
        description: 'Anyone can discover',
        icon: const Icon(Icons.remove_red_eye_outlined),
      ),
      EventConfiguration(
        type: EventConfigurationType.guestSettings,
        title: 'Guest limit',
        description: '100 guests, 2 guests unlocks',
        icon: const Icon(Icons.groups_rounded),
      ),
      EventConfiguration(
        type: EventConfigurationType.startDateTime,
        title: 'Mon, November 20 - 10:00',
        description: 'Start',
        icon: const Icon(Icons.calendar_month_outlined),
      ),
      EventConfiguration(
        type: EventConfigurationType.endDateTime,
        title: 'Mon, November 20 - 10:00',
        description: 'End',
        icon: const Icon(Icons.calendar_month_outlined),
      ),
      EventConfiguration(
        type: EventConfigurationType.virtual,
        title: 'Virtual',
        description: '',
        icon: const Icon(Icons.videocam_rounded),
      ),
      EventConfiguration(
        type: EventConfigurationType.location,
        title: 'Offline',
        description: 'Add location',
        icon: const Icon(Icons.factory_outlined),
      ),
    ];
    return eventConfigs;
  }

  static List<EventConfiguration> createEventConfigurations({
    Event? event,
  }) {
    List<EventConfiguration> result = List.from(defaultEventConfigurations());
    for (var element in result) {
      if (element.type == EventConfigurationType.guestSettings) {
        element.description = t.event.eventCreation.guestSettingDescription(
          guestLimit: event?.guestLimit ?? 'unlimited',
          guestLimitPer: event?.guestLimitPer ?? 'no',
        );
      }
      if (element.type == EventConfigurationType.startDateTime) {
        element.title = DateFormatUtils.custom(
          event?.start,
          pattern: 'EEE, MMMM dd - HH:mm',
        );
      }
      if (element.type == EventConfigurationType.endDateTime) {
        element.title = DateFormatUtils.custom(
          event?.end,
          pattern: 'EEE, MMMM dd - HH:mm',
        );
      }
    }
    return result;
  }
}
