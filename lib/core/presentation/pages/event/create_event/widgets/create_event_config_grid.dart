import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_configuration.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/presentation/pages/event/event_datetime_settings_page/event_datetime_settings_page.dart';
import 'package:app/core/presentation/pages/event/event_guest_settings_page/event_guest_settings_page.dart';
import 'package:app/core/presentation/pages/event/event_location_setting_page/event_location_setting_page.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum EventPrivacy { public, private }

class CreateEventConfigGrid extends StatelessWidget {
  final Event? event;
  const CreateEventConfigGrid({super.key, this.event});

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
    // Edit event case
    if (event != null) {
      final eventConfigs =
          EventConfiguration.createEventConfigurations(event: event);
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.2,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: 6,
          (BuildContext context, int index) {
            final eventConfig = eventConfigs[index];
            EventConfigurationType? eventConfigType = eventConfig.type;
            switch (eventConfigType) {
              default:
                return EventConfigCard(
                  title: eventConfig.title,
                  description: eventConfig.description,
                  icon: eventConfig.icon,
                  onTap: () => null,
                );
            }
          },
        ),
      );
    }
    final eventConfigs = EventConfiguration.defaultEventConfigurations();
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 6,
        (BuildContext context, int index) {
          final eventConfig = eventConfigs[index];
          EventConfigurationType? eventConfigType = eventConfig.type;
          switch (eventConfigType) {
            case EventConfigurationType.visibility:
              return BlocBuilder<CreateEventBloc, CreateEventState>(
                builder: (context, state) {
                  return EventConfigCard(
                    title: state.private == true
                        ? t.event.private
                        : t.event.public,
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
              return EventConfigCard(
                title: eventConfig.title,
                description: eventConfig.description,
                icon: eventConfig.icon,
                onTap: () => onTap(context, eventConfig),
              );
            case EventConfigurationType.location:
              return EventConfigCard(
                title: eventConfig.title,
                description: eventConfig.description,
                icon: eventConfig.icon,
                onTap: () => onTap(context, eventConfig),
              );

            default:
              return EventConfigCard(
                title: '',
                description: '',
                icon: eventConfig.icon,
                onTap: () => null,
              );
          }
        },
      ),
    );
  }
}
