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
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/other_ticket_types_list.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/payment_methods_switcher.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_item.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_submit_button.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

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
    _updatePaymentMethod(context);
  }

  void _updatePaymentMethod(BuildContext context) {
    final getEventTicketTypesBloc = context.read<GetEventTicketTypesBloc>();
    if (getEventTicketTypesBloc.state is! GetEventTicketTypesStateSuccess) {
      return;
    }
    final response =
        (getEventTicketTypesBloc.state as GetEventTicketTypesStateSuccess)
            .eventTicketTypesResponse;
    final selectTicketBloc = context.read<SelectEventTicketsBloc>();
    final selectedTicketCategory =
        selectTicketBloc.state.selectedTicketCategory;
    context.read<SelectEventTicketsBloc>().add(
          SelectEventTicketsEvent.onEventTicketTypesResponseLoaded(
            eventTicketTypesResponse: response,
          ),
        );
    final ticketTypesByCategory = EventTicketUtils.filterTicketTypeByCategory(
      response.ticketTypes ?? [],
      category: selectedTicketCategory,
    );

    if (ticketTypesByCategory.isEmpty) {
      return;
    }

    final stripeTicketTypes = EventTicketUtils.getTicketTypesSupportStripe(
      ticketTypes: ticketTypesByCategory,
    );
    final erc20TicketTypes = EventTicketUtils.getTicketTypesSupportCrypto(
      ticketTypes: ticketTypesByCategory,
    );

    if (stripeTicketTypes.isEmpty) {
      context.read<SelectEventTicketsBloc>().add(
            SelectEventTicketsEvent.selectPaymentMethod(
              paymentMethod: SelectTicketsPaymentMethod.wallet,
            ),
          );
    }

    if (erc20TicketTypes.isEmpty) {
      context.read<SelectEventTicketsBloc>().add(
            SelectEventTicketsEvent.selectPaymentMethod(
              paymentMethod: SelectTicketsPaymentMethod.card,
            ),
          );
    }

    // auto increase if only 1 ticket tier and only 1 price option in that tier
    if (ticketTypesByCategory.length == 1 &&
        ticketTypesByCategory.first.prices?.isNotEmpty == true &&
        ticketTypesByCategory.first.prices?.length == 1) {
      final price = ticketTypesByCategory.first.prices!.first;
      context.read<SelectEventTicketsBloc>().add(
            SelectEventTicketsEvent.select(
              ticket: PurchasableItem(
                count: 1,
                id: ticketTypesByCategory.first.id!,
              ),
              currency: price.currency ?? '',
              network: price.network,
            ),
          );
    }
  }

  void _handleEventRequireApproval() async {
    // pop whole buy event page stack
    await AutoRouter.of(context).root.pop();
    AutoRouter.of(context).root.replace(
          RSVPEventSuccessPopupRoute(
            event: widget.event,
            primaryMessage: t.event.eventApproval.waitingApproval,
            secondaryMessage: t.event.eventApproval.waitingApprovalDescription,
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

  void _handleRedeemMultipleTicketsSuccess() {
    AutoRouter.of(context).replaceAll(
      [
        RSVPEventSuccessPopupRoute(
          event: widget.event,
          buttonBuilder: (newContext) => LinearGradientButton(
            onTap: () => AutoRouter.of(newContext).replace(
              const EventPickMyTicketRoute(),
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
    final selectedPaymentMethod = selectTicketBloc.state.paymentMethod;
    final selectedTickets = selectTicketBloc.state.selectedTickets;
    final selectedCurrency = selectTicketBloc.state.selectedCurrency;
    final selectedNetwork = selectTicketBloc.state.selectedNetwork;
    final totalAmount = selectTicketBloc.state.totalAmount;

    return MultiBlocListener(
      listeners: [
        BlocListener<GetEventTicketTypesBloc, GetEventTicketTypesState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (response, supportedCurrencies) {
                _updatePaymentMethod(context);
              },
            );
          },
        ),
        BlocListener<RedeemTicketsBloc, RedeemTicketsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (redeemTicketsResponse) async {
                // if event join request available
                // navigate to success page with with different content saying that
                // need to wait for approval
                if (redeemTicketsResponse.eventJoinRequest != null) {
                  return _handleEventRequireApproval();
                }
                final tickets = redeemTicketsResponse.tickets ?? [];
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
        appBar: const LemonAppBar(
          leading: LemonBackButton(),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
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
                          "${widget.event.title}  •  ${DateFormatUtils.dateOnly(widget.event.start)}",
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Spacing.smMedium),
                  BlocBuilder<GetEventTicketTypesBloc,
                      GetEventTicketTypesState>(
                    builder: (context, state) {
                      return state.when(
                        loading: () => const SizedBox.shrink(),
                        failure: () => const SizedBox.shrink(),
                        success: (response, supportedCurrencies) {
                          final ticketTypesByCategory =
                              EventTicketUtils.filterTicketTypeByCategory(
                            response.ticketTypes ?? [],
                            category: selectedTicketCategory,
                          );
                          final stripeTicketTypes =
                              EventTicketUtils.getTicketTypesSupportStripe(
                            ticketTypes: ticketTypesByCategory,
                          );
                          final erc20TicketTypes =
                              EventTicketUtils.getTicketTypesSupportCrypto(
                            ticketTypes: ticketTypesByCategory,
                          );

                          // if there's only one supported payment methods (wallet or card)
                          // then no need to render payment methods switcher
                          if (stripeTicketTypes.isEmpty ||
                              erc20TicketTypes.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: Spacing.smMedium,
                              left: Spacing.smMedium,
                              right: Spacing.smMedium,
                            ),
                            child: PaymentMethodsSwitcher(
                              selectedTickets: selectedTickets,
                              selectedPaymentMethod: selectedPaymentMethod,
                              onSelect: (paymentMethod) => context
                                  .read<SelectEventTicketsBloc>()
                                  .add(
                                    SelectEventTicketsEvent.selectPaymentMethod(
                                      paymentMethod: paymentMethod,
                                    ),
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),
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
                          category: selectedTicketCategory,
                        );
                        final filteredTicketTypes = selectedPaymentMethod ==
                                SelectTicketsPaymentMethod.card
                            ? EventTicketUtils.getTicketTypesSupportStripe(
                                ticketTypes: ticketTypesByCategory,
                              )
                            : EventTicketUtils.getTicketTypesSupportCrypto(
                                ticketTypes: ticketTypesByCategory,
                              );
                        final supportedPaymentNetworks =
                            EventTicketUtils.getEventSupportedPaymentNetworks(
                          currencies: supportedCurrencies,
                        );

                        return Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (selectedPaymentMethod ==
                                  SelectTicketsPaymentMethod.wallet)
                                SizedBox(
                                  height: Sizing.medium,
                                  child: ListView.separated(
                                    padding:
                                        EdgeInsets.only(left: Spacing.smMedium),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return LemonOutlineButton(
                                          onTap: () {
                                            setState(() {
                                              networkFilter = null;
                                            });
                                          },
                                          backgroundColor:
                                              LemonColor.atomicBlack,
                                          borderColor: LemonColor.atomicBlack,
                                          label: StringUtils.capitalize(
                                            t.event.all,
                                          ),
                                        );
                                      }

                                      final selected =
                                          supportedPaymentNetworks[index - 1] ==
                                              networkFilter;
                                      return Row(
                                        children: [
                                          ChainQuery(
                                            chainId: supportedPaymentNetworks[
                                                index - 1],
                                            builder: (
                                              chain, {
                                              required bool isLoading,
                                            }) =>
                                                LemonOutlineButton(
                                              onTap: () {
                                                setState(() {
                                                  networkFilter =
                                                      supportedPaymentNetworks[
                                                          index - 1];
                                                });
                                              },
                                              leading: chain?.logoUrl != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Sizing.xSmall,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            chain?.logoUrl ??
                                                                '',
                                                        placeholder: (_, __) =>
                                                            const SizedBox
                                                                .shrink(),
                                                        errorWidget: (
                                                          _,
                                                          __,
                                                          ___,
                                                        ) =>
                                                            const SizedBox
                                                                .shrink(),
                                                        width: Sizing.xSmall,
                                                        height: Sizing.xSmall,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : null,
                                              label: chain?.name,
                                              backgroundColor: selected
                                                  ? LemonColor.atomicBlack
                                                  : null,
                                              textColor: selected
                                                  ? colorScheme.onPrimary
                                                      .withOpacity(0.72)
                                                  : null,
                                              borderColor: selected
                                                  ? Colors.transparent
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: Spacing.extraSmall,
                                      );
                                    },
                                    itemCount:
                                        supportedPaymentNetworks.length + 1,
                                  ),
                                ),
                              Expanded(
                                child: ListView.separated(
                                  padding: EdgeInsets.only(bottom: 200.w),
                                  itemBuilder: (context, index) {
                                    if (index == filteredTicketTypes.length) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Spacing.smMedium,
                                        ),
                                        child:
                                            OtherPaymentMethodTicketTypesList(
                                          ticketTypes: ticketTypesByCategory,
                                          networkFilter: networkFilter,
                                          selectedCurrency: selectedCurrency,
                                          selectedNetwork: selectedNetwork,
                                          selectedPaymentMethod:
                                              selectedPaymentMethod,
                                        ),
                                      );
                                    }

                                    if (index ==
                                        filteredTicketTypes.length + 1) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Spacing.smMedium,
                                        ),
                                        child: OtherChainTicketTypesList(
                                          ticketTypes: ticketTypesByCategory,
                                          networkFilter: networkFilter,
                                          selectedCurrency: selectedCurrency,
                                          selectedNetwork: selectedNetwork,
                                          selectedPaymentMethod:
                                              selectedPaymentMethod,
                                        ),
                                      );
                                    }

                                    return SelectTicketItem(
                                      networkFilter: networkFilter,
                                      selectedCurrency: selectedCurrency,
                                      selectedNetwork: selectedNetwork,
                                      selectedPaymentMethod:
                                          selectedPaymentMethod,
                                      event: widget.event,
                                      ticketType: filteredTicketTypes[index],
                                      count: selectedTickets
                                              .firstWhereOrNull(
                                                (element) =>
                                                    element.id ==
                                                    filteredTicketTypes[index]
                                                        .id,
                                              )
                                              ?.count ??
                                          0,
                                      onCountChange:
                                          (count, currency, network) {
                                        context
                                            .read<SelectEventTicketsBloc>()
                                            .add(
                                              SelectEventTicketsEvent.select(
                                                ticket: PurchasableItem(
                                                  count: count,
                                                  id: filteredTicketTypes[index]
                                                          .id ??
                                                      '',
                                                ),
                                                currency: currency,
                                                network: network,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    if (index == filteredTicketTypes.length ||
                                        index ==
                                            filteredTicketTypes.length + 1) {
                                      return SizedBox(height: Spacing.xSmall);
                                    }

                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: index ==
                                                filteredTicketTypes.length - 1
                                            ? Spacing.xSmall
                                            : 0,
                                      ),
                                      child: Divider(
                                        height: 1.w,
                                        thickness: 1.w,
                                        color: colorScheme.onPrimary
                                            .withOpacity(0.05),
                                      ),
                                    );
                                  },
                                  itemCount: filteredTicketTypes.length + 2,
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
                    paymentMethod: selectedPaymentMethod,
                    selectedCurrency: selectedCurrency,
                    selectedNetwork: selectedNetwork,
                    totalAmount: totalAmount,
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
