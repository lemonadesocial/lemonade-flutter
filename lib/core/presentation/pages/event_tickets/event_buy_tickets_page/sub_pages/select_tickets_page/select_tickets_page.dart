import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/accept_event_bloc/accept_event_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_submit_button.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_tickets_list.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SelectTicketsPage extends StatelessWidget {
  const SelectTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AssignTicketsBloc(event: event),
        ),
        BlocProvider(
          create: (context) => AcceptEventBloc(event: event),
        )
      ],
      child: SelectTicketView(event: event),
    );
  }
}

class SelectTicketView extends StatelessWidget {
  const SelectTicketView({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: (() => ''),
          authenticated: (session) => session.userId,
        );

    return MultiBlocListener(
      listeners: [
        BlocListener<GetEventTicketTypesBloc, GetEventTicketTypesState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (response) =>
                  context.read<SelectEventTicketTypesBloc>().add(
                        SelectEventTicketTypesEvent
                            .onEventTicketTypesResponseLoaded(
                          eventTicketTypesResponse: response,
                        ),
                      ),
            );
          },
        ),
        BlocListener<RedeemTicketsBloc, RedeemTicketsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (eventTickets) async {
                if (eventTickets.length == 1) {
                  // then trigger assign ticket to the user
                  context.read<AssignTicketsBloc>().add(
                        AssignTicketsEvent.assign(
                          assignees: [
                            TicketAssignee(
                              ticket: eventTickets.first.id ?? '',
                              user: userId,
                            ),
                          ],
                        ),
                      );
                } else {
                  // go to event rsvp success with button go to pick my ticket page
                  AutoRouter.of(context).replaceAll(
                    [
                      RSVPEventSuccessPopupRoute(
                        event: event,
                        buttonBuilder: (newContext) => LinearGradientButton(
                          onTap: () => AutoRouter.of(newContext)
                              .replace(const EventPickMyTicketRoute()),
                          height: Sizing.large,
                          textStyle: Typo.medium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimary.withOpacity(0.87),
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                          radius: BorderRadius.circular(LemonRadius.small * 2),
                          label: t.common.next,
                        ),
                      ),
                    ],
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
              success: (success) {
                if (success) {
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
              success: (eventRsvp) async {
                // pop whole buy event page stack
                await AutoRouter.of(context).root.pop();
                AutoRouter.of(context).root.replace(
                      RSVPEventSuccessPopupRoute(
                        event: event,
                        eventRsvp: eventRsvp,
                        onPressed: (outerContext) {
                          AutoRouter.of(outerContext).replace(
                            GuestEventDetailRoute(eventId: event.id ?? ''),
                          );
                        },
                      ),
                    );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: const LemonAppBar(
          leading: LemonBackButton(),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.event.eventBuyTickets.selectTickets,
                      style: Typo.extraLarge.copyWith(
                        color: colorScheme.onPrimary,
                        fontFamily: FontFamily.nohemiVariable,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "${event.title}  •  ${DateFormatUtils.dateOnly(event.start)}",
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.smMedium),
              BlocBuilder<GetEventTicketTypesBloc, GetEventTicketTypesState>(
                builder: (context, state) => state.when(
                  loading: () => Loading.defaultLoading(context),
                  failure: () => EmptyList(emptyText: t.common.somethingWrong),
                  success: (eventTicketTypesResponse) => SelectTicketsList(
                    event: event,
                    eventTicketTypesResponse: eventTicketTypesResponse,
                  ),
                ),
              ),
              const Spacer(),
              BlocBuilder<GetEventTicketTypesBloc, GetEventTicketTypesState>(
                builder: (context, state) => SelectTicketSubmitButton(
                  event: event,
                  listTicket: state.maybeWhen(
                    orElse: () => [],
                    success: (response) => response.ticketTypes ?? [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
