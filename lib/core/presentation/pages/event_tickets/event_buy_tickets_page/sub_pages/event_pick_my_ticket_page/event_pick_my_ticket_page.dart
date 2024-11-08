import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/accept_event_bloc/accept_event_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_self_assign_ticket_bloc/select_self_assign_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_pick_my_ticket_page/widgets/pick_my_tickets_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventPickMyTicketPage extends StatefulWidget {
  const EventPickMyTicketPage({super.key});

  @override
  State<EventPickMyTicketPage> createState() => _EventPickMyTicketPageState();
}

class _EventPickMyTicketPageState extends State<EventPickMyTicketPage> {
  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetMyTicketsBloc(
            input: GetTicketsInput(
              skip: 0,
              limit: 100,
              user: userId,
              event: event.id ?? '',
            ),
          )..add(GetMyTicketsEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => SelectSelfAssignTicketBloc(),
        ),
        BlocProvider(
          create: (context) => AssignTicketsBloc(event: event),
        ),
        BlocProvider(
          create: (context) => AcceptEventBloc(event: event),
        ),
      ],
      child: EventPickMyTicketView(event: event),
    );
  }
}

class EventPickMyTicketView extends StatelessWidget {
  final Event event;
  const EventPickMyTicketView({
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
    final assignTicketsState = context.watch<AssignTicketsBloc>().state;
    final acceptEventState = context.watch<AcceptEventBloc>().state;
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );

    final t = Translations.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<GetMyTicketsBloc, GetMyTicketsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (myTickets) {
                context.read<SelectSelfAssignTicketBloc>().add(
                      SelectSelfAssignTicketEvent.onMyTicketsLoaded(
                        myTickets: myTickets,
                      ),
                    );
                if (myTickets.length == 1) {
                  context.read<AssignTicketsBloc>().add(
                        AssignTicketsEvent.assign(
                          assignees: [
                            TicketAssignee(
                              ticket: myTickets.firstOrNull?.id ?? '',
                              user: userId,
                            ),
                          ],
                        ),
                      );
                }
              },
            );
          },
        ),
        BlocListener<AssignTicketsBloc, AssignTicketsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (isSuccess) {
                if (isSuccess) {
                  context
                      .read<AcceptEventBloc>()
                      .add(AcceptEventBlocEvent.accept());
                }
              },
            );
          },
        ),
        BlocListener<AcceptEventBloc, AcceptEventState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (eventRsvp) {
                final myTickets =
                    context.read<GetMyTicketsBloc>().state.maybeWhen(
                          orElse: () => [],
                          success: (myTickets) => myTickets,
                        );
                if (myTickets.length > 1) {
                  AutoRouter.of(context)
                      .replaceAll([const EventTicketManagementRoute()]);
                } else {
                  popToEventDetail(context);
                }
              },
            );
          },
        ),
      ],
      child: BlocBuilder<GetEventTicketTypesBloc, GetEventTicketTypesState>(
        builder: (context, state) {
          return state.when(
            loading: () => Scaffold(
              body: Center(
                child: Loading.defaultLoading(context),
              ),
            ),
            failure: () => Scaffold(
              backgroundColor: colorScheme.background,
              body: Center(
                child: EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
              ),
            ),
            success: (eventTicketTypesResponse, supportedCurrencies) {
              return BlocBuilder<GetMyTicketsBloc, GetMyTicketsState>(
                builder: (context, state) => state.when(
                  loading: () => Scaffold(
                    body: Center(
                      child: Loading.defaultLoading(context),
                    ),
                  ),
                  failure: () => Scaffold(
                    backgroundColor: colorScheme.background,
                    body: Center(
                      child: EmptyList(
                        emptyText: t.common.somethingWrong,
                      ),
                    ),
                  ),
                  success: (myTickets) {
                    if (myTickets.length == 1) {
                      return Scaffold(
                        backgroundColor: colorScheme.background,
                        body: Center(
                          child: Loading.defaultLoading(context),
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        Scaffold(
                          backgroundColor: colorScheme.background,
                          appBar: const LemonAppBar(
                            leading: SizedBox.shrink(),
                          ),
                          body: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.smMedium,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        t.event.eventPickMyTickets
                                            .pickYourTicket,
                                        style: Typo.extraLarge.copyWith(
                                          color: colorScheme.onPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        t.event.eventPickMyTickets
                                            .pickYourTicketDescription,
                                        style: Typo.medium.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Spacing.smMedium),
                                PickMyTicketsList(
                                  event: event,
                                  ticketGroupsMap:
                                      EventTicketUtils.groupTicketsByTicketType(
                                    EventTicketUtils.getNotAssignedTicketOnly(
                                      myTickets,
                                    ),
                                  ),
                                  ticketTypes:
                                      eventTicketTypesResponse.ticketTypes ??
                                          [],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SafeArea(
                            child: BlocBuilder<SelectSelfAssignTicketBloc,
                                SelectSelfAssignTicketState>(
                              builder: (context, state) {
                                final isButtonLoading = assignTicketsState
                                        is AssignTicketsStateLoading ||
                                    acceptEventState is AcceptEventStateLoading;
                                final isInvalid =
                                    state.selectedTicketType == null;
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.smMedium,
                                    vertical: Spacing.smMedium,
                                  ),
                                  child: Opacity(
                                    opacity:
                                        isButtonLoading || isInvalid ? 0.5 : 1,
                                    child: LinearGradientButton.primaryButton(
                                      onTap: () {
                                        if (isButtonLoading || isInvalid) {
                                          return;
                                        }
                                        final ticketToAssign = context
                                            .read<SelectSelfAssignTicketBloc>()
                                            .getTicketToAssign();
                                        if (ticketToAssign == null) return;

                                        context.read<AssignTicketsBloc>().add(
                                              AssignTicketsEvent.assign(
                                                assignees: [
                                                  TicketAssignee(
                                                    ticket:
                                                        ticketToAssign.id ?? '',
                                                    user: userId,
                                                  ),
                                                ],
                                              ),
                                            );
                                      },
                                      label: t.common.confirm,
                                      loadingWhen: isButtonLoading,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
