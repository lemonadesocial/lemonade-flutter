import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_configuration.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
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
    final eventConfigType = eventConfig.type;
    switch (eventConfigType) {
      case EventConfigurationType.coHosts:
        AutoRouter.of(context).navigate(const EventCohostsSettingRoute());
        break;
      case EventConfigurationType.speakers:
        AutoRouter.of(context).navigate(const EventSpeakersRoute());
        break;
      // case EventConfigurationType.team:
      //   AutoRouter.of(context).navigate(const EventTeamMembersSettingRoute());
      //   break;
      default:
        SnackBarUtils.showComingSoon();
    }
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
          if (eventConfig.type == EventConfigurationType.coHosts) {
            bool loading =
                context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
            return EventConfigCard(
              title: eventConfig.title,
              description: eventConfig.description,
              icon: eventConfig.icon,
              onTap: () => onTap(context, eventConfig),
              loading: loading,
            );
          } else if (eventConfig.type == EventConfigurationType.speakers) {
            bool loading = context.watch<GetEventDetailBloc>().state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );
            return EventConfigCard(
              title: eventConfig.title,
              description: eventConfig.description,
              icon: eventConfig.icon,
              onTap: () => onTap(context, eventConfig),
              loading: loading,
            );
          }
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
