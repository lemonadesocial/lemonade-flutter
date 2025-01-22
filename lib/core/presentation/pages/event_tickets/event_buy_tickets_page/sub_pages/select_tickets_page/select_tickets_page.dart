import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/accept_event_bloc/accept_event_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_rsvp.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_item.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_submit_button.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/event_utils.dart';
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
        ),
        BlocProvider(
          create: (context) => RedeemTicketsBloc(event: event),
        ),
      ],
      child: SelectTicketView(event: event),
    );
  }
}

class SelectTicketView extends StatefulWidget {
  const SelectTicketView({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<SelectTicketView> createState() => _SelectTicketViewState();
}

class _SelectTicketViewState extends State<SelectTicketView> {
  String? networkFilter;

  @override
  void initState() {
    super.initState();
    _updatePaymentMethod();
    _handleAutoSelect();
  }

  bool get isAttending {
    final userId = AuthUtils.getUserId(context);
    return EventUtils.isAttending(event: widget.event, userId: userId);
  }

  void _updatePaymentMethod() {
    final getEventTicketTypesBloc = context.read<GetEventTicketTypesBloc>();
    if (getEventTicketTypesBloc.state is! GetEventTicketTypesStateSuccess) {
      return;
    }
    final response =
        (getEventTicketTypesBloc.state as GetEventTicketTypesStateSuccess)
            .eventTicketTypesResponse;
    context.read<SelectEventTicketsBloc>().add(
          SelectEventTicketsEvent.onEventTicketTypesResponseLoaded(
            eventTicketTypesResponse: response,
          ),
        );
  }

  void _handleAutoSelect() {
    final getEventTicketTypesBloc = context.read<GetEventTicketTypesBloc>();
    if (getEventTicketTypesBloc.state is! GetEventTicketTypesStateSuccess) {
      return;
    }
    final response =
        (getEventTicketTypesBloc.state as GetEventTicketTypesStateSuccess)
            .eventTicketTypesResponse;
    final selectTicketBloc = context.read<SelectEventTicketsBloc>();
    final selectedTickets = selectTicketBloc.state.selectedTickets;

    // if user already selected tickets (maybe in other category) then no need to init payment method
    if (selectedTickets.isNotEmpty) {
      return;
    }

    final selectedTicketCategory =
        selectTicketBloc.state.selectedTicketCategory;
    context.read<SelectEventTicketsBloc>().add(
          SelectEventTicketsEvent.onEventTicketTypesResponseLoaded(
            eventTicketTypesResponse: response,
          ),
        );
    final ticketTypesByCategory = EventTicketUtils.filterTicketTypeByCategory(
      response.ticketTypes ?? [],
      category: selectedTicketCategory?.id,
    );

    // auto select if only 1 ticket tier and only 1 price option in that tier
    if (ticketTypesByCategory.length == 1 &&
        ticketTypesByCategory.first.prices?.isNotEmpty == true &&
        ticketTypesByCategory.first.prices?.length == 1) {
      final isPublic = ticketTypesByCategory.first.limited == null ||
          ticketTypesByCategory.first.limited == false;
      final isWhitelisted = ticketTypesByCategory.first.limited == true &&
          ticketTypesByCategory.first.whitelisted == true;

      if (isPublic || isWhitelisted) {
        context.read<SelectEventTicketsBloc>().add(
              SelectEventTicketsEvent.select(
                ticket: PurchasableItem(
                  count: 1,
                  id: ticketTypesByCategory.first.id!,
                ),
              ),
            );
      }
    }
  }

  void _handleRedeemSingleTicketSuccess({
    EventRsvp? eventRsvp,
  }) async {
    // pop whole buy event page stack
    await AutoRouter.of(context).root.pop();
    AutoRouter.of(context).root.replace(
          RSVPEventSuccessPopupRoute(
            event: widget.event,
            eventRsvp: eventRsvp,
            onPressed: (outerContext) {
              AutoRouter.of(outerContext).replace(
                EventDetailRoute(
                  eventId: widget.event.id ?? '',
                ),
              );
            },
          ),
        );
  }

  void _handleRedeemMultipleTicketsSuccess({
    int? ticketsCount,
  }) {
    final userId = AuthUtils.getUserId(context);
    AutoRouter.of(context).replaceAll(
      [
        RSVPEventSuccessPopupRoute(
          event: widget.event,
          primaryMessage:
              isAttending ? t.event.eventBuyTickets.ticketsPurchased : null,
          secondaryMessage: isAttending
              ? t.event.eventBuyTickets
                  .addictionalTicketsPurchasedSuccess(count: ticketsCount ?? 0)
              : null,
          buttonBuilder: (newContext) => LinearGradientButton(
            onTap: () => AutoRouter.of(newContext).replace(
              EventUtils.getAssignTicketsRouteForBuyFlow(
                event: widget.event,
                userId: userId,
              ),
            ),
            height: Sizing.large,
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.87),
              fontFamily: FontFamily.nohemiVariable,
            ),
            radius: BorderRadius.circular(LemonRadius.small * 2),
            label: t.common.next,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: (() => ''),
          authenticated: (session) => session.userId,
        );
    final selectTicketBloc = context.watch<SelectEventTicketsBloc>();
    final selectedTicketCategory =
        selectTicketBloc.state.selectedTicketCategory;
    return MultiBlocListener(
      listeners: [
        BlocListener<GetEventTicketTypesBloc, GetEventTicketTypesState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (response, supportedCurrencies) {
                _updatePaymentMethod();
                _handleAutoSelect();
              },
            );
          },
        ),
        BlocListener<RedeemTicketsBloc, RedeemTicketsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (redeemTicketsResponse) async {
                final tickets = redeemTicketsResponse.tickets ?? [];
                if (redeemTicketsResponse.joinRequest != null) {
                  AutoRouter.of(context).root.popUntil(
                        (route) => route.data?.name == EventDetailRoute.name,
                      );
                  return;
                }
                // if guest already joined the event but
                // buy additional tickets then go to pick tickets page
                if (isAttending) {
                  _handleRedeemMultipleTicketsSuccess(
                    ticketsCount: tickets.length,
                  );
                  return;
                }

                if (tickets.length == 1) {
                  // then trigger assign ticket to the user
                  context.read<AssignTicketsBloc>().add(
                        AssignTicketsEvent.assign(
                          assignees: [
                            TicketAssignee(
                              ticket: tickets.first.id ?? '',
                              user: userId,
                            ),
                          ],
                        ),
                      );
                } else {
                  // go to event rsvp success with button go to pick my ticket page
                  _handleRedeemMultipleTicketsSuccess();
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
                  context.read<AcceptEventBloc>().add(
                        AcceptEventBlocEvent.accept(),
                      );
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
                _handleRedeemSingleTicketSuccess(eventRsvp: eventRsvp);
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: LemonAppBar(
          leading: const LemonBackButton(),
          title: t.event.eventBuyTickets.selectTickets,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<GetEventTicketTypesBloc,
                      GetEventTicketTypesState>(
                    builder: (context, state) => state.when(
                      loading: () => Loading.defaultLoading(context),
                      failure: () =>
                          EmptyList(emptyText: t.common.somethingWrong),
                      success: (response, supportedCurrencies) {
                        final ticketTypesByCategory =
                            EventTicketUtils.filterTicketTypeByCategory(
                          response.ticketTypes ?? [],
                          category: selectedTicketCategory?.id,
                        )..sort(
                                (a, b) {
                                  final aOrder = a.limited == true &&
                                          a.whitelisted == false
                                      ? -1
                                      : 1;
                                  final bOrder = b.limited == true &&
                                          b.whitelisted == false
                                      ? -1
                                      : 1;
                                  return bOrder.compareTo(aOrder);
                                },
                              );
                        final filteredTicketTypes = ticketTypesByCategory;
                        return Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  padding: EdgeInsets.only(
                                    left: Spacing.small,
                                    right: Spacing.small,
                                    bottom: 200.w,
                                  ),
                                  itemBuilder: (context, index) {
                                    final ticketType =
                                        filteredTicketTypes[index];
                                    return SelectTicketItem(
                                      networkFilter: networkFilter,
                                      event: widget.event,
                                      ticketType: ticketType,
                                      allTicketTypes: filteredTicketTypes,
                                      onCountChange: (count) {
                                        context
                                            .read<SelectEventTicketsBloc>()
                                            .add(
                                              SelectEventTicketsEvent.select(
                                                ticket: PurchasableItem(
                                                  count: count,
                                                  id: ticketType.id ?? '',
                                                ),
                                              ),
                                            );
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: Spacing.xSmall),
                                  itemCount: filteredTicketTypes.length,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(
                    top: Spacing.medium,
                    bottom: Spacing.smMedium,
                  ),
                  color: colorScheme.background,
                  child: SelectTicketSubmitButton(
                    event: widget.event,
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
