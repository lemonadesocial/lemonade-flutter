import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/invite_event_bloc/invite_event_bloc.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_invite_setting_page/sub_pages/event_invite_processing_page/view/event_invite_loading_view.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_invite_setting_page/sub_pages/event_invite_processing_page/view/event_invite_success_view.dart';
import 'package:app/graphql/backend/event/mutation/invite_event.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class EventInviteProcessingPage extends StatelessWidget {
  const EventInviteProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context
        .read<GetEventDetailBloc>()
        .state
        .maybeWhen(orElse: () => null, fetched: (event) => event);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: Spacing.smMedium),
          child: Mutation$InviteEvent$Widget(
            options: WidgetOptions$Mutation$InviteEvent(
              onCompleted: (_, __) {
                context.read<GetEventDetailBloc>().add(
                      GetEventDetailEvent.fetch(eventId: event?.id ?? ''),
                    );
              },
              onError: (error) {
                AutoRouter.of(context).replaceAll([
                  EventInviteFormRoute(),
                ]);
              },
            ),
            builder: (runMutation, result) {
              return EventInviteProcessingPageView(
                result: result,
                runMutation: () {
                  final state = context.read<InviteEventBloc>().state;
                  runMutation(
                    Variables$Mutation$InviteEvent(
                      input: Input$InviteEventInput(
                        $_id: event?.id ?? '',
                        emails: state.emails,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class EventInviteProcessingPageView extends StatefulWidget {
  final Function() runMutation;
  final QueryResult<Mutation$InviteEvent>? result;
  const EventInviteProcessingPageView({
    super.key,
    required this.runMutation,
    this.result,
  });

  @override
  State<EventInviteProcessingPageView> createState() =>
      _EventInviteProcessingPageViewState();
}

class _EventInviteProcessingPageViewState
    extends State<EventInviteProcessingPageView> {
  @override
  initState() {
    super.initState();
    widget.runMutation();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.result?.isLoading == true ||
        widget.result?.hasException == true ||
        widget.result?.parsedData == null) {
      return const EventInviteLoadingView();
    }
    return const EventInviteSuccessView();
  }
}
