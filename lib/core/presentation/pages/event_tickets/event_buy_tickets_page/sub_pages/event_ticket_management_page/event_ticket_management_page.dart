import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/assign_multiple_tickets_form_bloc/assign_multiple_tickets_form_bloc.dart';
import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/ticket_assignments_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTicketManagementPage extends StatelessWidget {
  const EventTicketManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    final userId = AuthUtils.getUserId(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AssignTicketsBloc(event: event),
        ),
        BlocProvider(
          create: (context) => AssignMultipleTicketsFormBloc(),
        ),
        BlocProvider(
          create: (context) => GetMyTicketsBloc(
            input: GetTicketsInput(
              skip: 0,
              limit: 100,
              event: event.id,
              user: userId,
            ),
          )..add(GetMyTicketsEvent.fetch()),
        ),
      ],
      child: EventTicketManagementView(event: event),
    );
  }
}

class EventTicketManagementView extends StatelessWidget {
  final Event event;

  const EventTicketManagementView({
    super.key,
    required this.event,
  });

  void popToEventDetail(BuildContext context) {
    final hasEventsList = AutoRouter.of(context).root.stack.any(
          (route) => route.routeData.name == EventsListingRoute.name,
        );
    if (!hasEventsList) {
      AutoRouter.of(context).root.popUntilRoot();
    } else {
      AutoRouter.of(context).root.popUntilRouteWithPath(
            '/events',
          );
    }
    AutoRouter.of(context).root.push(
          EventDetailRoute(
            key: UniqueKey(),
            eventId: event.id ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(
        leading: SizedBox.shrink(),
      ),
      body: BlocBuilder<GetEventTicketTypesBloc, GetEventTicketTypesState>(
        builder: (context, state) {
          return state.when(
            loading: () => Loading.defaultLoading(context),
            failure: () => EmptyList(
              emptyText: t.common.somethingWrong,
            ),
            success: (eventTicketTypesResponse, supportedCurrencies) {
              return BlocBuilder<GetMyTicketsBloc, GetMyTicketsState>(
                builder: (context, state) => state.when(
                  loading: () => Loading.defaultLoading(context),
                  failure: () => EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                  success: (myTickets) {
                    final otherTickets = myTickets
                        .where(
                          (ticket) =>
                              EventTicketUtils.isTicketNotAssigned(ticket) &&
                              !EventTicketUtils.isTicketAccepted(ticket) &&
                              !EventTicketUtils.isTicketAssignedToMe(
                                ticket,
                                userId: userId,
                              ),
                        )
                        .toList();
                    context.read<AssignMultipleTicketsFormBloc>().add(
                          AssignMultipleTicketsFormEvent.add(
                            assignees: otherTickets
                                .map(
                                  (e) => TicketAssignee(
                                    ticket: e.id ?? '',
                                    email: '',
                                  ),
                                )
                                .toList(),
                          ),
                        );
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: SafeArea(
                        child: Stack(
                          children: [
                            CustomScrollView(
                              slivers: [
                                TicketAssignmentList(
                                  controller: this,
                                  ticketTypes:
                                      eventTicketTypesResponse.ticketTypes ??
                                          [],
                                  eventTickets: otherTickets,
                                  event: event,
                                ),
                                SliverPadding(
                                  padding: EdgeInsets.only(
                                    bottom: Spacing.medium * 4,
                                  ),
                                ),
                              ],
                            ),
                            BlocBuilder<AssignMultipleTicketsFormBloc,
                                AssignMultipleTicketsFormState>(
                              builder: (context, state) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SafeArea(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Spacing.smMedium,
                                        horizontal: Spacing.smMedium,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.background,
                                        border: Border(
                                          top: BorderSide(
                                            width: 2.w,
                                            color: colorScheme.onPrimary
                                                .withOpacity(0.06),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: LinearGradientButton
                                                .secondaryButton(
                                              mode: GradientButtonMode.light,
                                              textColor: Colors.black,
                                              label: t.common.actions.skip,
                                              onTap: () async {
                                                popToEventDetail(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(width: Spacing.small),
                                          BlocConsumer<AssignTicketsBloc,
                                              AssignTicketsState>(
                                            listener: (context, assignState) {
                                              if (assignState
                                                  is AssignTicketsStateSuccess) {
                                                popToEventDetail(context);
                                              }
                                            },
                                            builder: (context, assignState) {
                                              return Expanded(
                                                child: Opacity(
                                                  opacity:
                                                      state.isValid ? 1 : 0.5,
                                                  child: LinearGradientButton
                                                      .primaryButton(
                                                    loadingWhen: assignState
                                                        is AssignTicketsStateLoading,
                                                    onTap: () {
                                                      if (!state.isValid) {
                                                        return;
                                                      }
                                                      if (assignState
                                                          is AssignTicketsStateLoading) {
                                                        return;
                                                      }
                                                      context
                                                          .read<
                                                              AssignTicketsBloc>()
                                                          .add(
                                                            AssignTicketsEvent
                                                                .assign(
                                                              assignees: state
                                                                  .assignees
                                                                  .where(
                                                                    (element) =>
                                                                        element.email?.isNotEmpty ==
                                                                            true ||
                                                                        element.user?.isNotEmpty ==
                                                                            true,
                                                                  )
                                                                  .toList(),
                                                            ),
                                                          );
                                                    },
                                                    label: t
                                                        .event
                                                        .eventTicketManagement
                                                        .assignTicket,
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
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
