import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_configuration.dart';
import 'package:app/core/presentation/pages/event/create_event/widgets/event_config_card.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum EventPrivacy { public, private }

class EventTicketsGridConfig extends StatelessWidget {
  final Event? event;
  const EventTicketsGridConfig({super.key, this.event});

  onTap(
    BuildContext context,
    EventConfiguration eventConfig,
  ) {
    Vibrate.feedback(FeedbackType.light);
    final eventConfigType = eventConfig.type;
    switch (eventConfigType) {
      case EventConfigurationType.ticketTiers:
        AutoRouter.of(context).navigate(const EventTicketTierSettingRoute());
        break;
      case EventConfigurationType.rewards:
        AutoRouter.of(context).navigate(const EventRewardSettingRoute());
        break;
      default:
        showComingSoonDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Event eventDetail = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => Event(),
          fetched: (eventDetail) => eventDetail,
        );
    final eventConfigs =
        EventConfiguration.ticketsEventConfiguations(context, eventDetail);
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
            loading: false,
          );
        },
      ),
    );
  }
}
