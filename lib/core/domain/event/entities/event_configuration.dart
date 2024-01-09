import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum EventPrivacy { public, private }

enum EventConfigurationType {
  visibility,
  guestSettings,
  startDateTime,
  endDateTime,
  virtual,
  location,
  coHosts,
  speakers,
  ticketTiers,
}

class EventConfiguration {
  EventConfiguration({
    required this.type,
    required this.title,
    this.description,
    required this.icon,
    this.selected,
  });

  final EventConfigurationType type;
  String title;
  String? description;
  final Widget icon;
  bool? selected;

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

  static List<EventConfiguration> collaborationsEventConfiguations(
    BuildContext context,
  ) {
    final eventCohostRequests =
        context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
              fetched: (eventCohostRequests) => eventCohostRequests,
              orElse: () => [],
            );
    final colorScheme = Theme.of(context).colorScheme;
    final speakerUsers = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail.speakerUsers,
          orElse: () => null,
        );
    final List<EventConfiguration> eventConfigs = [
      EventConfiguration(
        type: EventConfigurationType.coHosts,
        title: t.event.configuration.coHosts,
        description: eventCohostRequests.isNotEmpty
            ? t.event.cohosts
                .cohostInfo(cohostsCount: eventCohostRequests.length.toString())
            : t.common.actions.add,
        icon: const Icon(Icons.person_add),
      ),
      EventConfiguration(
        type: EventConfigurationType.speakers,
        title: t.event.configuration.speakers,
        description: speakerUsers!.isNotEmpty
            ? '${speakerUsers.length} ${t.event.speakers.speakersCountInfo(
                n: speakerUsers.length,
              )}'
            : t.common.actions.add,
        icon: const Icon(Icons.speaker),
      ),
      EventConfiguration(
        type: EventConfigurationType.ticketTiers,
        title: t.event.ticketTier,
        description: "",
        icon: Center(
          child: Assets.icons.icTicket.svg(
            colorFilter: ColorFilter.mode(
              colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    ];
    return eventConfigs;
  }

  static List<EventConfiguration> createEventConfigurations({
    Event? event,
  }) {
    List<EventConfiguration> result = List.from(defaultEventConfigurations());
    for (var element in result) {
      if (element.type == EventConfigurationType.visibility) {
        element.title =
            event?.private == true ? t.event.private : t.event.public;
        element.description = event?.private == true
            ? t.event.privateDescription
            : t.event.publicDescription;
      }
      if (element.type == EventConfigurationType.guestSettings) {
        element.description = t.event.eventCreation.guestSettingDescription(
          guestLimit: event?.guestLimit?.toStringAsFixed(0) ?? 'unlimited',
          guestLimitPer: event?.guestLimitPer?.toStringAsFixed(0) ?? 'no',
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
      if (element.type == EventConfigurationType.location) {
        element.description = event?.address?.title;
      }
      if (element.type == EventConfigurationType.virtual) {
        element.selected = event?.virtual;
      }
    }
    return result;
  }
}
