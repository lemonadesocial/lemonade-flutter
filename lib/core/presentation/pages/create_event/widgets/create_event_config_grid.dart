import 'package:app/core/presentation/pages/create_event/widgets/event_config_card.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEventConfigGrid extends StatelessWidget {
  final List<Map<String, dynamic>> cardData = [
    {
      'title': 'Public',
      'description': 'Anyone can discover',
      'icon': Icons.remove_red_eye_outlined
    },
    {
      'title': 'Guess limit',
      'description': '100 guests, 2 guests unlocks',
      'icon': Icons.groups_rounded
    },
    {
      'title': 'Mon, November 20 - 10:00',
      'description': 'Start',
      'icon': Icons.calendar_month_outlined
    },
    {
      'title': 'Mon, November 23 - 10:00',
      'description': 'End',
      'icon': Icons.calendar_month_outlined
    },
    {'title': 'Virtual', 'description': '', 'icon': Icons.videocam_rounded},
    {
      'title': 'Office',
      'description': 'Add location',
      'icon': Icons.factory_outlined
    },
  ];

  CreateEventConfigGrid({super.key});
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
                  vertical: Spacing.superExtraSmall,
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
