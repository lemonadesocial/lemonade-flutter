import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/sub_pages/guest_event_application_page/sub_pages/guest_event_application_form_processing_page/view/guest_event_application_form_loading_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/sub_pages/guest_event_application_page/sub_pages/guest_event_application_form_processing_page/view/guest_event_application_form_success_view.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/user/mutation/update_user.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class GuestEventApplicationFormProcessingPage extends StatelessWidget {
  const GuestEventApplicationFormProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: Spacing.smMedium),
          child: Mutation$UpdateUser$Widget(
            options: WidgetOptions$Mutation$UpdateUser(
              onCompleted: (_, __) {
                context.read<AuthBloc>().add(const AuthEvent.refreshData());
              },
              onError: (error) {
                AutoRouter.of(context).replaceAll([
                  EventIssueTicketsFormRoute(),
                  const EventIssueTicketsSummaryRoute(),
                ]);
              },
            ),
            builder: (runMutation, result) {
              return GuestEventApplicationFormProcessingPageView(
                result: result,
                runMutation: () {
                  final inputFields = context
                      .read<EventApplicationFormBloc>()
                      .state
                      .fieldsState;
                  runMutation(
                    Variables$Mutation$UpdateUser(
                      input: Input$UserInput.fromJson(inputFields),
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

class GuestEventApplicationFormProcessingPageView extends StatefulWidget {
  final Function() runMutation;
  final QueryResult<Mutation$UpdateUser>? result;
  const GuestEventApplicationFormProcessingPageView({
    super.key,
    required this.runMutation,
    this.result,
  });

  @override
  State<GuestEventApplicationFormProcessingPageView> createState() =>
      _GuestEventApplicationFormProcessingPageViewState();
}

class _GuestEventApplicationFormProcessingPageViewState
    extends State<GuestEventApplicationFormProcessingPageView> {
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
      return const GuestEventApplicationFormLoadingView();
    }
    return const GuestEventApplicationFormSuccessView();
  }
}
