import 'package:app/core/application/event_tickets/issue_tickets_bloc/issue_tickets_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_issue_tickets_setting_page/sub_pages/event_issue_tickets_processing_page/view/event_issue_tickets_loading_view.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_issue_tickets_setting_page/sub_pages/event_issue_tickets_processing_page/view/event_issue_tickets_success_view.dart';
import 'package:app/graphql/backend/event/mutation/create_tickets.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class EventIssueTicketsProcessingPage extends StatelessWidget {
  const EventIssueTicketsProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: Spacing.smMedium),
          child: Mutation$CreateTickets$Widget(
            options: WidgetOptions$Mutation$CreateTickets(
              onError: (error) {
                AutoRouter.of(context).replaceAll([
                  EventIssueTicketsFormRoute(),
                  const EventIssueTicketsSummaryRoute(),
                ]);
              },
            ),
            builder: (runMutation, result) {
              return EventIssueTicketsProcessingPageView(
                result: result,
                runMutation: () {
                  final issueTicketsBlocState =
                      context.read<IssueTicketsBloc>().state;
                  runMutation(
                    Variables$Mutation$CreateTickets(
                      ticketType:
                          issueTicketsBlocState.selectedTicketType?.id ?? '',
                      ticketAssignments:
                          issueTicketsBlocState.ticketAssignments,
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

class EventIssueTicketsProcessingPageView extends StatefulWidget {
  final Function() runMutation;
  final QueryResult<Mutation$CreateTickets>? result;
  const EventIssueTicketsProcessingPageView({
    super.key,
    required this.runMutation,
    this.result,
  });

  @override
  State<EventIssueTicketsProcessingPageView> createState() =>
      _EventIssueTicketsProcessingPageViewState();
}

class _EventIssueTicketsProcessingPageViewState
    extends State<EventIssueTicketsProcessingPageView> {
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
      return const EventIssueTicketsLoadingView();
    }
    return const EventIssueTicketsSuccessView();
  }
}
