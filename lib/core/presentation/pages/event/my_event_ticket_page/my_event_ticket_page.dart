import 'dart:io';

import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/add_ticket_to_apple_wallet_button.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/add_ticket_to_calendar_button.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/my_ticket_card.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_actions.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

@RoutePage()
class MyEventTicketPage extends StatelessWidget {
  final Event event;

  const MyEventTicketPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final userId = AuthUtils.getUserId(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetEventDetailBloc()
            ..add(GetEventDetailEvent.fetch(eventId: event.id ?? '')),
        ),
        BlocProvider(
          create: (context) => GetMyTicketsBloc(
            input: GetTicketsInput(
              skip: 0,
              limit: 100,
              event: event.id,
              user: userId,
            ),
          )..add(
              GetMyTicketsEvent.fetch(),
            ),
        ),
      ],
      child: MyEventTicketPageView(
        event: event,
      ),
    );
  }
}

class MyEventTicketPageView extends StatelessWidget {
  const MyEventTicketPageView({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(
        title: '',
      ),
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) {
          return state.when(
            failure: () => EmptyList(
              emptyText: t.common.somethingWrong,
            ),
            loading: () => Loading.defaultLoading(context),
            fetched: (eventDetail) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventDetail.title ?? '',
                            style: Typo.superLarge.copyWith(
                              color: colorScheme.onPrimary.withOpacity(0.87),
                            ),
                          ),
                          Text(
                            DateFormatUtils.custom(
                              eventDetail.start,
                              pattern: 'EEEE, dd MMMM  •  hh:mm a',
                            ),
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(height: Spacing.medium),
                          BlocBuilder<GetMyTicketsBloc, GetMyTicketsState>(
                            builder: (context, myTicketsState) {
                              List<EventTicket> ingTickets =
                                  myTicketsState.maybeWhen(
                                orElse: () => [],
                                success: (myTickets) => myTickets
                                    .where(
                                      (ticket) => !EventTicketUtils
                                          .isTicketAssignedToMe(
                                        ticket,
                                        userId: userId,
                                      ),
                                    )
                                    .toList(),
                              );
                              return EventTicketActions(
                                event: eventDetail,
                                remainingTickets: ingTickets,
                              );
                            },
                          ),
                          SizedBox(height: Spacing.medium),
                          const AddTicketToCalendarButton(),
                          if (Platform.isIOS) ...[
                            SizedBox(height: Spacing.xSmall),
                            const AddTicketToAppleWalletButton(),
                          ],
                          SizedBox(height: Spacing.medium),
                          BlocBuilder<GetMyTicketsBloc, GetMyTicketsState>(
                            builder: (context, myTicketsState) {
                              final myTicket = myTicketsState.maybeWhen(
                                orElse: () => null,
                                success: (myTickets) =>
                                    myTickets.firstWhereOrNull(
                                  (ticket) =>
                                      EventTicketUtils.isTicketAssignedToMe(
                                    ticket,
                                    userId: userId,
                                  ),
                                ),
                              );
                              return MyTicketCard(
                                event: eventDetail,
                                myTicket: myTicket,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
