import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  rewards,
  promotions,
  applicationForm
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
        icon: Icon(
          Icons.remove_red_eye_outlined,
          size: 18,
          color: LemonColor.white54,
        ),
      ),
      EventConfiguration(
        type: EventConfigurationType.guestSettings,
        title: 'Guest limit',
        description: '100 guests, 2 guests unlocks',
        icon: Icon(
          Icons.groups_rounded,
          size: 18,
          color: LemonColor.white54,
        ),
      ),
      EventConfiguration(
        type: EventConfigurationType.virtual,
        title: 'Virtual',
        description: '',
        icon: Icon(
          Icons.videocam_rounded,
          size: 18,
          color: LemonColor.white54,
        ),
      ),
      EventConfiguration(
        type: EventConfigurationType.location,
        title: 'Offline',
        description: 'Add location',
        icon: Icon(
          Icons.factory_outlined,
          size: 18,
          color: LemonColor.white54,
        ),
      ),
    ];
    return eventConfigs;
  }

  static List<EventConfiguration> collaborationsEventConfiguations(
    BuildContext context,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final eventCohostRequests =
        context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
              fetched: (eventCohostRequests) => eventCohostRequests,
              orElse: () => [],
            );
    final speakerUsers = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail.speakerUsers,
          orElse: () => null,
        );
    final List<EventConfiguration> eventConfigs = [
      EventConfiguration(
        type: EventConfigurationType.coHosts,
        title: t.event.configuration.coHosts,
        description: eventCohostRequests.isNotEmpty
            ? '${eventCohostRequests.length} ${t.event.cohosts.cohostsCountInfo(n: eventCohostRequests.length)}'
            : t.common.actions.add,
        icon: Icon(
          Icons.person_add,
          color: colorScheme.onSecondary,
          size: 18.w,
        ),
      ),
      EventConfiguration(
        type: EventConfigurationType.speakers,
        title: t.event.configuration.speakers,
        description: speakerUsers!.isNotEmpty
            ? '${speakerUsers.length} ${t.event.speakers.speakersCountInfo(
                n: speakerUsers.length,
              )}'
            : t.common.actions.add,
        icon: Icon(
          Icons.speaker,
          color: colorScheme.onSecondary,
          size: 18.w,
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

  static List<EventConfiguration> ticketsEventConfiguations(
    BuildContext context,
    Event? event,
  ) {
    final eventTicketTypesCount = event?.eventTicketTypes?.length ?? 0;
    final eventRewardsCount = event?.rewards?.length ?? 0;
    final eventPromotionsCount = event?.paymentTicketDiscounts?.length ?? 0;
    final colorScheme = Theme.of(context).colorScheme;
    final List<EventConfiguration> eventConfigs = [
      EventConfiguration(
        type: EventConfigurationType.ticketTiers,
        title: t.event.ticketTier,
        description:
            '$eventTicketTypesCount ${t.event.ticketTypesCount(n: eventTicketTypesCount)}',
        icon: Center(
          child: Assets.icons.icTicket.svg(
            width: 18.w,
            height: 18.w,
            color: colorScheme.onSecondary,
          ),
        ),
      ),
      EventConfiguration(
        type: EventConfigurationType.rewards,
        title: t.event.configuration.rewards,
        description:
            '$eventRewardsCount ${t.event.rewardsCount(n: eventRewardsCount)}',
        icon: Center(
          child: Icon(
            Icons.star_border_outlined,
            color: colorScheme.onSecondary,
            size: 18.w,
          ),
        ),
      ),
      EventConfiguration(
        type: EventConfigurationType.promotions,
        title: t.event.configuration.promitions,
        description: eventPromotionsCount > 0
            ? t.event.eventPromotions.promotions(n: eventPromotionsCount)
            : t.common.actions.add,
        icon: Center(
          child: Icon(
            Icons.discount_outlined,
            color: colorScheme.onSecondary,
            size: 18.w,
          ),
        ),
      ),
    ];
    return eventConfigs;
  }
}
