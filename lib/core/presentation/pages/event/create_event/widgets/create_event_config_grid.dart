import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_configuration.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/presentation/pages/event/event_datetime_settings_page/event_datetime_settings_page.dart';
import 'package:app/core/presentation/pages/event/event_guest_settings_page/event_guest_settings_page.dart';
import 'package:app/core/presentation/pages/event/event_location_setting_page/event_location_setting_page.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum EventPrivacy { public, private }

class CreateEventConfigGrid extends StatelessWidget {
  final List<EventConfiguration> eventConfigs = [
    EventConfiguration(
      type: EventConfigurationType.visibility,
      title: 'Public',
      description: 'Anyone can discover',
      icon: const Icon(Icons.remove_red_eye_outlined),
      selected: false,
    ),
    EventConfiguration(
      type: EventConfigurationType.guestSettings,
      title: 'Guest limit',
      description: '100 guests, 2 guests unlocks',
      icon: const Icon(Icons.groups_rounded),
      selected: false,
    ),
    EventConfiguration(
      type: EventConfigurationType.startDateTime,
      title: 'Mon, November 20 - 10:00',
      description: 'Start',
      icon: const Icon(Icons.calendar_month_outlined),
      selected: false,
    ),
    EventConfiguration(
      type: EventConfigurationType.endDateTime,
      title: 'Mon, November 20 - 10:00',
      description: 'End',
      icon: const Icon(Icons.calendar_month_outlined),
      selected: false,
    ),
    EventConfiguration(
      type: EventConfigurationType.virtual,
      title: 'Virtual',
      description: '',
      icon: const Icon(Icons.videocam_rounded),
      selected: false,
    ),
    EventConfiguration(
      type: EventConfigurationType.location,
      title: 'Offline',
      description: 'Add location',
      icon: const Icon(Icons.factory_outlined),
      selected: false,
    ),
  ];

  final Event? event;
  CreateEventConfigGrid({super.key, this.event});

  onTap(
    BuildContext context,
    EventConfiguration eventConfig,
  ) {
    Vibrate.feedback(FeedbackType.light);
    Widget? page;
    final eventConfigType = eventConfig.type;
    switch (eventConfigType) {
      case EventConfigurationType.visibility ||
            EventConfigurationType.guestSettings:
        page = const EventGuestSettingsPage();
        break;
      case EventConfigurationType.startDateTime:
        page = const EventDatetimeSettingsPage();
        break;
      case EventConfigurationType.endDateTime:
        page = const EventDatetimeSettingsPage();
        break;
      case EventConfigurationType.location:
        page = const EventLocationSettingPage();
        break;
      default:
        page = null;
        break;
    }
    if (page == null) {
      return showComingSoonDialog(context);
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        clipBehavior: Clip.hardEdge,
        child: FractionallySizedBox(
          heightFactor: 0.95,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 35,
                height: 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Expanded(
                child: page ?? const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        (eventConfigs.length / 2).ceil(),
        (rowIndex) {
          final startIndex = rowIndex * 2;
          final endIndex = (startIndex + 2 <= eventConfigs.length)
              ? startIndex + 2
              : eventConfigs.length;
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: Spacing.extraSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: eventConfigs
                      .sublist(startIndex, endIndex)
                      .asMap()
                      .entries
                      .map(
                        (entry) => Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              left:
                                  entry.key == 1 ? Spacing.superExtraSmall : 0,
                              right:
                                  entry.key == 0 ? Spacing.superExtraSmall : 0,
                            ), // Adjust horizontal spacing
                            child: _buildCard(entry.value, context),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildCard(EventConfiguration eventConfig, BuildContext context) {
    EventConfigurationType? eventConfigType = eventConfig.type;
    switch (eventConfigType) {
      case EventConfigurationType.visibility:
        return BlocBuilder<CreateEventBloc, CreateEventState>(
          builder: (context, state) {
            return EventConfigCard(
              title: state.private == true ? t.event.private : t.event.public,
              description: state.private == true
                  ? t.event.privateDescription
                  : t.event.publicDescription,
              icon: eventConfig.icon,
              onTap: () => onTap(context, eventConfig),
            );
          },
        );
      case EventConfigurationType.guestSettings:
        return BlocBuilder<CreateEventBloc, CreateEventState>(
          builder: (context, state) {
            return EventConfigCard(
              title: eventConfig.title,
              description: t.event.eventCreation.guestSettingDescription(
                guestLimit: state.guestLimit ?? 'unlimited',
                guestLimitPer: state.guestLimitPer ?? 'no',
              ),
              icon: eventConfig.icon,
              onTap: () => onTap(context, eventConfig),
            );
          },
        );
      case EventConfigurationType.startDateTime:
        return BlocBuilder<EventDateTimeSettingsBloc,
            EventDateTimeSettingsState>(
          builder: (context, state) {
            return EventConfigCard(
              title: DateFormatUtils.custom(
                state.start.value,
                pattern: 'EEE, MMMM dd - HH:mm',
              ),
              description: eventConfig.description,
              icon: eventConfig.icon,
              onTap: () => onTap(context, eventConfig),
            );
          },
        );
      case EventConfigurationType.endDateTime:
        return BlocBuilder<EventDateTimeSettingsBloc,
            EventDateTimeSettingsState>(
          builder: (context, state) {
            return EventConfigCard(
              title: DateFormatUtils.custom(
                state.end.value,
                pattern: 'EEE, MMMM dd - HH:mm',
              ),
              description: eventConfig.description,
              icon: eventConfig.icon,
              onTap: () => onTap(context, eventConfig),
            );
          },
        );
      case EventConfigurationType.virtual:
        return BlocBuilder<CreateEventBloc, CreateEventState>(
          builder: (context, state) {
            return EventConfigCard(
              title: eventConfig.title,
              description: eventConfig.description,
              icon: eventConfig.icon,
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                context.read<CreateEventBloc>().add(
                      VirtualChanged(virtual: !state.virtual),
                    );
              },
              selected: state.virtual,
            );
          },
        );
      case EventConfigurationType.location:
        return BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
          builder: (context, state) {
            return EventConfigCard(
              title: eventConfig.title,
              description: state.selectedAddress?.title ??
                  t.event.locationSetting.addLocation,
              icon: eventConfig.icon,
              onTap: () => onTap(context, eventConfig),
              selected: state.selectedAddress != null,
            );
          },
        );

      default:
        return EventConfigCard(
          title: '',
          description: '',
          icon: eventConfig.icon,
          onTap: () => null,
        );
    }
  }
}
