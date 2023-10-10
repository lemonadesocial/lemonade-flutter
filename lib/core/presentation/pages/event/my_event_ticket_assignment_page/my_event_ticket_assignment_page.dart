import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_assignment_page/widgets/my_event_ticket_assignment_list.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/ticket_assign_popup.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyEventTicketAssignmentPage extends StatelessWidget {
  final Event event;
  const MyEventTicketAssignmentPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final userId = AuthUtils.getUserId(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetEventTicketTypesBloc(event: event)
            ..add(GetEventTicketTypesEvent.fetch()),
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
      child: MyEventTicketAssignmentView(event: event),
    );
  }
}

class MyEventTicketAssignmentView extends StatelessWidget {
  const MyEventTicketAssignmentView({
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
      appBar: const LemonAppBar(),
      body: BlocBuilder<GetEventTicketTypesBloc, GetEventTicketTypesState>(
        builder: (context, state) {
          return state.when(
            loading: () => Loading.defaultLoading(context),
            failure: () => EmptyList(
              emptyText: t.common.somethingWrong,
            ),
            success: (eventTicketTypesResponse) {
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
                              MyEventTicketAssignmentList(
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
