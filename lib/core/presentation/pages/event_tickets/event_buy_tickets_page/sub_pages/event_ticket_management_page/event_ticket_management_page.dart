import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/my_ticket_card.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/ticket_assign_popup.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/ticket_assignments_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
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
  const EventTicketManagementView({
    super.key,
    required this.event,
  });

  final Event event;

  void showAssignPopup(
    BuildContext context, {
    required EventTicket eventTicket,
    PurchasableTicketType? ticketType,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => TicketAssignPopup(
        event: event,
        eventTicket: eventTicket,
        ticketType: ticketType,
        onAssignSuccess: () => {
          context.read<GetMyTicketsBloc>().add(GetMyTicketsEvent.fetch()),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    final myAssignedTicket = myTickets.firstWhere(
                      (ticket) =>
                          EventTicketUtils.isTicketAccepted(ticket) &&
                          EventTicketUtils.isTicketAssignedToMe(
                            ticket,
                            userId: userId,
                          ),
                    );
                    final myAssignedTicketType =
                        EventTicketUtils.getTicketTypeById(
                      eventTicketTypesResponse.ticketTypes ?? [],
                      ticketTypeId: myAssignedTicket.type ?? '',
                    );

                    final otherTickets = myTickets
                        .where(
                          (ticket) =>
                              !EventTicketUtils.isTicketAccepted(ticket) &&
                              !EventTicketUtils.isTicketAssignedToMe(
                                ticket,
                                userId: userId,
                              ),
                        )
                        .toList();

                    return SafeArea(
                      child: Stack(
                        children: [
                          CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.smMedium,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        t.event.eventTicketManagement.myTicket,
                                        style: Typo.extraLarge.copyWith(
                                          color: colorScheme.onPrimary,
                                          fontFamily: FontFamily.nohemiVariable,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        t.event.eventTicketManagement
                                            .myTicketDescription,
                                        style: Typo.mediumPlus.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(height: Spacing.smMedium),
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Spacing.smMedium,
                                  ),
                                  child: MyTicketCard(
                                    event: event,
                                    eventTicket: myAssignedTicket,
                                    ticketType: myAssignedTicketType,
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(height: Spacing.large),
                              ),
                              TicketAssignmentList(
                                controller: this,
                                ticketTypes:
                                    eventTicketTypesResponse.ticketTypes ?? [],
                                eventTickets: otherTickets,
                                event: event,
                              ),
                              SliverPadding(
                                padding:
                                    EdgeInsets.only(bottom: Spacing.medium * 4),
                              ),
                            ],
                          ),
                          Align(
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
                                child: SizedBox(
                                  height: Sizing.large,
                                  child: Opacity(
                                    opacity: 1, // 0.5 for disabled state,
                                    child: LinearGradientButton(
                                      onTap: () async {
                                        final hasEventsList =
                                            AutoRouter.of(context)
                                                .root
                                                .stack
                                                .any(
                                                  (route) =>
                                                      route.routeData.name ==
                                                      EventsListingRoute.name,
                                                );
                                        if (!hasEventsList) {
                                          AutoRouter.of(context)
                                              .root
                                              .popUntilRoot();
                                        } else {
                                          AutoRouter.of(context)
                                              .root
                                              .popUntilRouteWithPath(
                                                '/events',
                                              );
                                        }
                                        AutoRouter.of(context).root.push(
                                              EventDetailRoute(
                                                key: UniqueKey(),
                                                eventId: event.id ?? '',
                                              ),
                                            );
                                      },
                                      radius: BorderRadius.circular(
                                        LemonRadius.small * 2,
                                      ),
                                      mode: GradientButtonMode.lavenderMode,
                                      label: t.event.takeMeToEvent,
                                      textStyle: Typo.medium.copyWith(
                                        fontFamily: FontFamily.nohemiVariable,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.onPrimary
                                            .withOpacity(0.87),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
