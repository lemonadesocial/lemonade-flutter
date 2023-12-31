import 'package:app/core/application/event/event_detail_cohosts_bloc/event_detail_cohosts_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_configuration.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum EventPrivacy { public, private }

class EventCollaborationsGridConfig extends StatelessWidget {
  final Event? event;
  const EventCollaborationsGridConfig({super.key, this.event});

  onTap(
    BuildContext context,
    EventConfiguration eventConfig,
  ) {
    Vibrate.feedback(FeedbackType.light);
    Widget? page;
    final eventConfigType = eventConfig.type;
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
    final eventConfigs =
        EventConfiguration.collaborationsEventConfiguations(context);
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: eventConfigs.length,
        (BuildContext context, int index) {
          final eventConfig = eventConfigs[index];
          EventConfigurationType? eventConfigType = eventConfig.type;
          return EventConfigCard(
            title: eventConfig.title,
            description: eventConfig.description,
            icon: eventConfig.icon,
            onTap: () => onTap(context, eventConfig),
          );
        },
      ),
    );
  }
}
