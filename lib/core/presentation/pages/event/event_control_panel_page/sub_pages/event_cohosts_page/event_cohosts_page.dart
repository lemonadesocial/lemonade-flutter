import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_detail_cohosts_bloc/event_detail_cohosts_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event/manage_event_cohost_requests_bloc/manage_event_cohost_requests_bloc.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_page/widgets/event_cohost_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventCohostsPage extends StatelessWidget {
  const EventCohostsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    return EventCohostsPageView(event: event);
  }
}

class EventCohostsPageView extends StatefulWidget {
  const EventCohostsPageView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventCohostsPageView> createState() => _EventCohostsPageViewState();
}

class _EventCohostsPageViewState extends State<EventCohostsPageView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.onPrimaryContainer,
        title: t.event.configuration.coHosts,
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      resizeToAvoidBottomInset: true,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final t = Translations.of(context);
    List<EventCohostRequest> eventCohostsRequests =
        context.watch<EventDetailCohostsBloc>().state.maybeWhen(
              fetched: (eventCohostsRequests) => eventCohostsRequests,
              orElse: () => [],
            );
    return BlocListener<ManageEventCohostRequestsBloc,
        ManageEventCohostRequestsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: () async {
            context.read<EventDetailCohostsBloc>().add(
                  EventDetailCohostsEvent.fetch(
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
            Text(
              t.common.pending,
              style: Typo.mediumPlus,
            ),
            SizedBox(
              height: Spacing.smMedium,
            ),
            Expanded(
              child: CohostsList(
                eventCohostsRequests: eventCohostsRequests,
                event: widget.event,
              ),
            ),
            _buildAddCohostsButton(),
          ],
        ),
      ),
    );
  }

  _buildAddCohostsButton() {
    return BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
      builder: (context, state) {
        return LinearGradientButton(
          label: t.event.cohosts.addCohosts,
          height: 48.h,
          radius: BorderRadius.circular(24),
          textStyle: Typo.medium.copyWith(),
          mode: GradientButtonMode.lavenderMode,
          onTap: () {
            AutoRouter.of(context).navigate(const EventAddCohostsRoute());
          },
          loadingWhen: state.status == EditEventDetailBlocStatus.loading,
        );
      },
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
    return ListView.separated(
      padding: EdgeInsets.only(bottom: Spacing.medium),
      shrinkWrap: true,
      itemBuilder: (context, index) => EventCohostItem(
        user: User.fromDto(
          UserDto.fromJson(
            eventCohostsRequests[index].toExpanded!.toJson(),
          ),
        ),
        onTapRevoke: () {
          Vibrate.feedback(FeedbackType.light);
          context.read<ManageEventCohostRequestsBloc>().add(
                ManageEventCohostRequestsEvent.saveChanged(
                  eventId: event?.id ?? '',
                  users: [eventCohostsRequests[index].toExpanded?.id ?? ''],
                  decision: false,
                ),
              );
        },
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: Spacing.small,
      ),
      itemCount: eventCohostsRequests.length,
    );
  }
}
