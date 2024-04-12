import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/manage_event_cohost_requests_bloc/manage_event_cohost_requests_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_setting_page/widgets/event_cohost_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventCohostsSettingPage extends StatelessWidget {
  const EventCohostsSettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return EventCohostsSettingPageView(event: event);
  }
}

class EventCohostsSettingPageView extends StatefulWidget {
  const EventCohostsSettingPageView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventCohostsSettingPageView> createState() =>
      _EventCohostsSettingPageViewState();
}

class _EventCohostsSettingPageViewState
    extends State<EventCohostsSettingPageView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    List<EventCohostRequest> eventCohostsRequests =
        context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
              fetched: (eventCohostsRequests) => eventCohostsRequests,
              orElse: () => [],
            );
    final loadingEventCohostsRequests =
        context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
    final loadingManageEventCohostRequests =
        context.watch<ManageEventCohostRequestsBloc>().state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.background,
        title: t.event.configuration.coHosts,
      ),
      backgroundColor: colorScheme.background,
      resizeToAvoidBottomInset: true,
      body: BlocListener<ManageEventCohostRequestsBloc,
          ManageEventCohostRequestsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            success: () async {
              context.read<GetEventCohostRequestsBloc>().add(
                    GetEventCohostRequestsEvent.fetch(
                      eventId: widget.event?.id ?? '',
                    ),
                  );
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.small,
            vertical: Spacing.small,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: loadingEventCohostsRequests ||
                        loadingManageEventCohostRequests
                    ? Loading.defaultLoading(context)
                    : eventCohostsRequests.isEmpty
                        ? const EmptyList()
                        : CohostsList(
                            eventCohostsRequests: eventCohostsRequests,
                            event: widget.event,
                          ),
              ),
              BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: LinearGradientButton.primaryButton(
                        label: t.event.cohosts.addCohosts,
                        onTap: () {
                          AutoRouter.of(context)
                              .navigate(const EventAddCohostsRoute());
                        },
                        loadingWhen:
                            state.status == EditEventDetailBlocStatus.loading,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CohostsList extends StatelessWidget {
  const CohostsList({
    super.key,
    required this.eventCohostsRequests,
    required this.event,
  });

  final List<EventCohostRequest> eventCohostsRequests;
  final Event? event;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          itemBuilder: (context, index) => EventCohostItem(
            user: eventCohostsRequests[index].toExpanded,
            onTapRevoke: () {
              Vibrate.feedback(FeedbackType.light);
              context.read<ManageEventCohostRequestsBloc>().add(
                    ManageEventCohostRequestsEvent.saveChanged(
                      eventId: event?.id ?? '',
                      users: [
                        eventCohostsRequests[index].toExpanded?.userId ?? '',
                      ],
                      decision: false,
                    ),
                  );
            },
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: Spacing.small,
          ),
          itemCount: eventCohostsRequests.length,
        ),
      ],
    );
  }
}
