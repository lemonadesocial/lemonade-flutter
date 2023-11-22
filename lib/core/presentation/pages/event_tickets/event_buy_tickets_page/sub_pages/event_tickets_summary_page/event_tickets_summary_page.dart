import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/buy_tickets_bloc/buy_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/application/event_tickets/calculate_event_tickets_pricing_bloc/calculate_event_tickets_pricing_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/get_payment_cards_bloc/get_payment_cards_bloc.dart';
import 'package:app/core/application/payment/payment_listener/payment_listener.dart';
import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/handler/buy_tickets_listener.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/handler/buy_tickets_with_crypto_listener.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/add_promo_code_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_summary_footer.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_tickets_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/pay_by_crypto_button.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/common/slide_to_act/slide_to_act.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
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
class EventTicketsSummaryPage extends StatelessWidget {
  const EventTicketsSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventId = context.read<EventProviderBloc>().event.id;
    final selectTicketBlocState = context.read<SelectEventTicketsBloc>().state;
    final selectedTickets = selectTicketBlocState.selectedTickets;
    final selectedCurrency = selectTicketBlocState.selectedCurrency;
    final selectedNetwork = selectTicketBlocState.selectedNetwork;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalculateEventTicketPricingBloc()
            ..add(
              CalculateEventTicketPricingEvent.calculate(
                input: CalculateTicketsPricingInput(
                  eventId: eventId ?? '',
                  items: selectedTickets,
                  currency: selectedCurrency!,
                  network: selectedNetwork,
                ),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => BuyTicketsBloc(),
        ),
        BlocProvider(
          create: (context) => BuyTicketsWithCryptoBloc(
            selectedNetwork: selectedNetwork,
          ),
        ),
      ],
      child: EventTicketsSummaryPageView(),
    );
  }
}

class EventTicketsSummaryPageView extends StatelessWidget {
  EventTicketsSummaryPageView({
    super.key,
  });

  final _slideActionKey = GlobalKey<SlideActionState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;
    final selectTicketsBlocState = context.read<SelectEventTicketsBloc>().state;
    final selectedTickets = selectTicketsBlocState.selectedTickets;
    final selectedCurrency = selectTicketsBlocState.selectedCurrency;
    final selectedNetwork = selectTicketsBlocState.selectedNetwork;
    final ticketTypes =
        context.watch<GetEventTicketTypesBloc>().state.maybeWhen(
              orElse: () => [] as List<PurchasableTicketType>,
              success: (response, _) => response.ticketTypes ?? [],
            );
    final isCryptoCurrency = PaymentUtils.isCryptoCurrency(selectedCurrency!);

    return MultiBlocListener(
      listeners: [
        BlocListener<GetPaymentCardsBloc, GetPaymentCardsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              success: (cards) {
                if (cards.isEmpty) return;
                context
                    .read<SelectPaymentCardCubit>()
                    .selectPaymentCard(paymentCard: cards.first);
              },
            );
          },
        ),
        BlocListener<CalculateEventTicketPricingBloc,
            CalculateEventTicketPricingState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (pricingInfo) {
                if (isCryptoCurrency) return;
                if (pricingInfo.paymentAccounts?.isEmpty == true) return;
                context.read<GetPaymentCardsBloc>().add(
                      GetPaymentCardsEvent.fetch(
                        input: GetStripeCardsInput(
                          limit: 25,
                          skip: 0,
                          paymentAccount:
                              pricingInfo.paymentAccounts?.first.id ?? '',
                        ),
                      ),
                    );
              },
              orElse: () => null,
            );
          },
        ),
        BuyTicketsListener.create(
          onFailure: () => _slideActionKey.currentState?.reset(),
        ),
        BuyTicketsWithCryptoListener.create(),
      ],
      child: PaymentListener(
        onReceivedPaymentSuccess: (eventId, payment) {
          final currentPayment = isCryptoCurrency
              ? context.read<BuyTicketsWithCryptoBloc>().state.data.payment
              : context.read<BuyTicketsBloc>().currentPayment;
          if (currentPayment?.id == payment.id && eventId == event.id) {
            AutoRouter.of(context).replaceAll(
              [
                RSVPEventSuccessPopupRoute(
                  event: event,
                  buttonBuilder: (newContext) => LinearGradientButton(
                    onTap: () => AutoRouter.of(newContext).replace(
                      const EventPickMyTicketRoute(),
                    ),
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
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: colorScheme.background,
              appBar: const LemonAppBar(),
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.event.eventBuyTickets.orderSummary,
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
                          SizedBox(height: Spacing.large),
                          BlocBuilder<CalculateEventTicketPricingBloc,
                              CalculateEventTicketPricingState>(
                            builder: (context, state) {
                              return state.when(
                                idle: () => const SizedBox.shrink(),
                                loading: () => Loading.defaultLoading(context),
                                failure: () => EmptyList(
                                  emptyText: t.common.somethingWrong,
                                ),
                                success: (pricingInfo) => EventTicketsSummary(
                                  ticketTypes: ticketTypes,
                                  selectedTickets: selectedTickets,
                                  selectedCurrency: selectedCurrency,
                                  selectedNetwork: selectedNetwork,
                                  pricingInfo: pricingInfo,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: Spacing.smMedium),
                          const AddPromoCodeInput(),
                          SizedBox(height: Spacing.smMedium),
                          BlocBuilder<CalculateEventTicketPricingBloc,
                              CalculateEventTicketPricingState>(
                            builder: (context, state) {
                              return state.when(
                                idle: () => const SizedBox.shrink(),
                                loading: () => Loading.defaultLoading(context),
                                failure: () => EmptyList(
                                  emptyText: t.common.somethingWrong,
                                ),
                                success: (pricingInfo) => EventOrderSummary(
                                  selectedCurrency: selectedCurrency,
                                  pricingInfo: pricingInfo,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 150.w + Spacing.medium),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocBuilder<CalculateEventTicketPricingBloc,
                          CalculateEventTicketPricingState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const SizedBox.shrink(),
                            success: (pricingInfo) {
                              if (isCryptoCurrency) {
                                return PayByCryptoButton(
                                  selectedTickets: selectedTickets,
                                  selectedCurrency: selectedCurrency,
                                  selectedNetwork: selectedNetwork,
                                  pricingInfo: pricingInfo,
                                );
                              }

                              return EventOrderSummaryFooter(
                                onSlideToPay: () {
                                  if (pricingInfo.paymentAccounts == null ||
                                      pricingInfo.paymentAccounts?.isEmpty ==
                                          true) {
                                    return const SizedBox.shrink();
                                  }
                                  final selectedCard = context
                                      .read<SelectPaymentCardCubit>()
                                      .state
                                      .when(
                                        empty: () => null,
                                        cardSelected: (selectedCard) =>
                                            selectedCard,
                                      );
                                  context.read<BuyTicketsBloc>().add(
                                        BuyTicketsEvent.buy(
                                          input: BuyTicketsInput(
                                            eventId: event.id ?? '',
                                            accountId: pricingInfo
                                                    .paymentAccounts
                                                    ?.first
                                                    .id ??
                                                '',
                                            currency: selectedCurrency,
                                            items: selectedTickets,
                                            total: pricingInfo.total ?? '0',
                                            transferParams:
                                                BuyTicketsTransferParamsInput(
                                              paymentMethod:
                                                  selectedCard?.providerId ??
                                                      '',
                                            ),
                                          ),
                                        ),
                                      );
                                },
                                pricingInfo: pricingInfo,
                                slideActionKey: _slideActionKey,
                                onCardAdded: (newCard) {
                                  context.read<GetPaymentCardsBloc>().add(
                                        GetPaymentCardsEvent
                                            .manuallyAddMoreCard(
                                          paymentCard: newCard,
                                        ),
                                      );
                                  context
                                      .read<SelectPaymentCardCubit>()
                                      .selectPaymentCard(
                                        paymentCard: newCard,
                                      );
                                },
                                onSelectCard: (selectedCard) {
                                  context
                                      .read<SelectPaymentCardCubit>()
                                      .selectPaymentCard(
                                        paymentCard: selectedCard,
                                      );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<BuyTicketsBloc, BuyTicketsState>(
              builder: (context, state) => state.maybeWhen(
                idle: () => const SizedBox.shrink(),
                failure: (failureReason) => const SizedBox.shrink(),
                orElse: () => Positioned.fill(
                  child: Container(
                    color: colorScheme.background.withOpacity(0.5),
                    child: Loading.defaultLoading(context),
                  ),
                ),
              ),
            ),
            BlocBuilder<BuyTicketsWithCryptoBloc, BuyTicketsWithCryptoState>(
              builder: (context, state) => state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                loading: (_) => Positioned.fill(
                  child: Container(
                    color: colorScheme.background.withOpacity(0.5),
                    child: Loading.defaultLoading(context),
                  ),
                ),
                done: (_) => Positioned.fill(
                  child: Container(
                    color: colorScheme.background.withOpacity(0.5),
                    child: Loading.defaultLoading(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
