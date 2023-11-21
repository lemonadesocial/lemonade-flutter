import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/presentation/pages/event/event_guest_settings_page/event_guest_settings_page.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum EventPrivacy { public, private }

class CreateEventConfigGrid extends StatelessWidget {
  final List<Map<String, dynamic>> cardData = [
    {
      'type': 'guest_settings',
      'title': 'Public',
      'description': 'Anyone can discover',
      'icon': Icons.remove_red_eye_outlined
    },
    {
      'type': 'guest_settings',
      'title': 'Guess limit',
      'description': '100 guests, 2 guests unlocks',
      'icon': Icons.groups_rounded
    },
    {
      'type': 'date_and_time',
      'title': 'Mon, November 20 - 10:00',
      'description': 'Start',
      'icon': Icons.calendar_month_outlined
    },
    {
      'type': 'date_and_time',
      'title': 'Mon, November 23 - 10:00',
      'description': 'End',
      'icon': Icons.calendar_month_outlined
    },
    {
      'type': 'virtual',
      'title': 'Virtual',
      'description': '',
      'icon': Icons.videocam_rounded
    },
    {
      'type': 'location',
      'title': 'Offline',
      'description': 'Add location',
      'icon': Icons.factory_outlined
    },
  ];

  CreateEventConfigGrid({super.key});

  onTap(String type, BuildContext context) {
    const EventGuestSettingsPage()
        .showAsBottomSheet(context, heightFactor: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: List.generate(
        (cardData.length / 2).ceil(),
        (rowIndex) {
          final startIndex = rowIndex * 2;
          final endIndex = (startIndex + 2 <= cardData.length)
              ? startIndex + 2
              : cardData.length;

          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: Spacing.extraSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: cardData
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
                            child: EventConfigCard(
                              title: entry.value['title']!,
                              description: entry.value['description']!,
                              icon: Icon(
                                entry.value['icon'],
                                color: colorScheme.onPrimary,
                                size: 16.w,
                              ),
                              onTap: () => onTap(entry.value['type'], context),
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
  }
}
