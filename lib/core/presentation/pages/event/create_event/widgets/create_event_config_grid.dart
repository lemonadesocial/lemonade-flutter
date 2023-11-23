import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/presentation/pages/event/event_guest_settings_page/event_guest_settings_page.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum EventPrivacy { public, private }

enum EventConfigGrid {
  visibility,
  guestSettings,
  dateAndTime,
  virtual,
  location
}

class CreateEventConfigGrid extends StatelessWidget {
  final List<Map<String, dynamic>> eventConfigs = [
    {
      'type': EventConfigGrid.visibility,
      'title': 'Public',
      'description': 'Anyone can discover',
      'icon': Icons.remove_red_eye_outlined
    },
    {
      'type': EventConfigGrid.guestSettings,
      'title': 'Guess limit',
      'description': '100 guests, 2 guests unlocks',
      'icon': Icons.groups_rounded
    },
    {
      'type': EventConfigGrid.dateAndTime,
      'title': 'Mon, November 20 - 10:00',
      'description': 'Start',
      'icon': Icons.calendar_month_outlined
    },
    {
      'type': EventConfigGrid.dateAndTime,
      'title': 'Mon, November 23 - 10:00',
      'description': 'End',
      'icon': Icons.calendar_month_outlined
    },
    {
      'type': EventConfigGrid.virtual,
      'title': 'Virtual',
      'description': '',
      'icon': Icons.videocam_rounded
    },
    {
      'type': EventConfigGrid.location,
      'title': 'Offline',
      'description': 'Add location',
      'icon': Icons.factory_outlined
    },
  ];

  final Event? event;
  CreateEventConfigGrid({super.key, this.event});

  onTap(
    BuildContext context,
    Map<String, dynamic> eventConfig,
    CreateEventState state,
  ) {
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
              const Expanded(
                child: EventGuestSettingsPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
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
                                  left: entry.key == 1
                                      ? Spacing.superExtraSmall
                                      : 0,
                                  right: entry.key == 0
                                      ? Spacing.superExtraSmall
                                      : 0,
                                ), // Adjust horizontal spacing
                                child: EventConfigCard(
                                  title: getTitle(context, entry.value, state),
                                  description: getDescription(
                                    context,
                                    entry.value,
                                    state,
                                  ),
                                  icon: Icon(
                                    entry.value['icon'],
                                    color: colorScheme.onPrimary,
                                    size: 16.w,
                                  ),
                                  onTap: () =>
                                      onTap(context, entry.value, state),
                                ),
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
      },
    );
  }

  String getTitle(
    BuildContext context,
    Map<String, dynamic> eventConfig,
    CreateEventState state,
  ) {
    EventConfigGrid eventConfigType = eventConfig['type'];
    String title = eventConfig['title'];
    switch (eventConfigType) {
      case EventConfigGrid.visibility:
        return state.private == true ? t.event.private : t.event.public;
      default:
        return title;
    }
  }

  String getDescription(
    BuildContext context,
    Map<String, dynamic> eventConfig,
    CreateEventState state,
  ) {
    final t = Translations.of(context);
    EventConfigGrid eventConfigType = eventConfig['type'];
    String description = eventConfig['description'];
    switch (eventConfigType) {
      case EventConfigGrid.visibility:
        return state.private == true
            ? t.event.privateDescription
            : t.event.publicDescription;
      case EventConfigGrid.guestSettings:
        return t.event.eventCreation.guestSettingDescription(
          guestLimit: state.guestLimit ?? 'unlimited',
          guestLimitPer: state.guestLimitPer ?? 'no',
        );
      default:
        return description;
    }
  }
}
