import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/calculate_event_tickets_pricing_bloc/calculate_event_tickets_pricing_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/get_payment_cards_bloc/get_payment_cards_bloc.dart';
import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_info_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_total_price_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_tickets_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/payment_footer/pay_by_crypto_footer.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/payment_footer/pay_by_stripe_footer.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/promo_code/promo_code_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_application_form/rsvp_application_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
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
        BlocProvider.value(
          value: context.read<CalculateEventTicketPricingBloc>()
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
      ],
      child: const EventTicketsSummaryPageView(),
    );
  }
}

class EventTicketsSummaryPageView extends StatelessWidget {
  const EventTicketsSummaryPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;
    final selectTicketsBlocState = context.read<SelectEventTicketsBloc>().state;
    final selectedTickets = selectTicketsBlocState.selectedTickets;
    final selectedCurrency = selectTicketsBlocState.selectedCurrency!;
    final selectedNetwork = selectTicketsBlocState.selectedNetwork;
    final isCryptoCurrency = selectedNetwork?.isNotEmpty == true;
    final isApplicationFormRequired =
        event.applicationProfileFields?.isNotEmpty == true ||
            event.applicationQuestions?.isNotEmpty == true;
    final isApplicationFormValid = !isApplicationFormRequired
        ? true
        : event.applicationFormSubmission != null
            ? true
            : context.watch<EventApplicationFormBloc>().state.isValid;

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
              success: (pricingInfo, isFree) {
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
      ],
      child: BlocBuilder<GetEventTicketTypesBloc, GetEventTicketTypesState>(
        builder: (context, state) {
          return state.when(
            failure: () => Scaffold(
              backgroundColor: colorScheme.background,
              appBar: LemonAppBar(
                title: t.event.eventBuyTickets.registration,
              ),
              body: Center(
                child: EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
              ),
            ),
            loading: () => Scaffold(
              backgroundColor: colorScheme.background,
              appBar: LemonAppBar(
                title: t.event.eventBuyTickets.registration,
              ),
              body: Center(
                child: Loading.defaultLoading(context),
              ),
            ),
            success: (ticketTypesResponse, supportedCurrencies) {
              final ticketTypes = ticketTypesResponse.ticketTypes ?? [];
              return WillPopScope(
                // prevent accidentally swipe back
                onWillPop: () async => true,
                child: Stack(
                  children: [
                    Scaffold(
                      backgroundColor: colorScheme.background,
                      appBar: LemonAppBar(
                        title: t.event.eventBuyTickets.registration,
                      ),
                      body: SafeArea(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Spacing.xSmall,
                                    ),
                                    child: EventInfoSummary(
                                      event: event,
                                    ),
                                  ),
                                  SizedBox(height: Spacing.medium),
                                  BlocBuilder<CalculateEventTicketPricingBloc,
                                      CalculateEventTicketPricingState>(
                                    builder: (context, state) {
                                      return state.when(
                                        idle: () => const SizedBox.shrink(),
                                        loading: () =>
                                            Loading.defaultLoading(context),
                                        failure: (pricingInfo, isFree) {
                                          if (pricingInfo != null) {
                                            return _TicketsAndTotalPricingSummary(
                                              ticketTypes: ticketTypes,
                                              selectedTickets: selectedTickets,
                                              selectedCurrency:
                                                  selectedCurrency,
                                              selectedNetwork: selectedNetwork,
                                              pricingInfo: pricingInfo,
                                            );
                                          }
                                          return EmptyList(
                                            emptyText: t.common.somethingWrong,
                                          );
                                        },
                                        success: (pricingInfo, isFree) =>
                                            _TicketsAndTotalPricingSummary(
                                          ticketTypes: ticketTypes,
                                          selectedTickets: selectedTickets,
                                          selectedCurrency: selectedCurrency,
                                          selectedNetwork: selectedNetwork,
                                          pricingInfo: pricingInfo,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: Spacing.medium),
                                  if (event.applicationFormSubmission ==
                                      null) ...[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Spacing.xSmall,
                                      ),
                                      child: const RSVPApplicationForm(),
                                    ),
                                    SizedBox(height: 150.w),
                                  ],
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: BlocBuilder<
                                  CalculateEventTicketPricingBloc,
                                  CalculateEventTicketPricingState>(
                                builder: (context, state) {
                                  final pricingInfo = state.maybeWhen(
                                    orElse: () => null,
                                    failure: ((pricingInfo, isFree) =>
                                        pricingInfo),
                                    success: (pricingInfo, isFree) =>
                                        pricingInfo,
                                  );
                                  final isFree = state.maybeWhen(
                                    orElse: () => false,
                                    failure: (pricingInfo, isFree) => isFree,
                                    success: (pricingInfo, isFree) => isFree,
                                  );

                                  if (pricingInfo == null) {
                                    return const SizedBox.shrink();
                                  }
                                  if (isCryptoCurrency) {
                                    return PayByCryptoFooter(
                                      selectedTickets: selectedTickets,
                                      selectedCurrency: selectedCurrency,
                                      selectedNetwork: selectedNetwork,
                                      pricingInfo: pricingInfo,
                                      isFree: isFree,
                                      disabled: !isApplicationFormValid,
                                    );
                                  }

                                  return PayByStripeFooter(
                                    disabled: !isApplicationFormValid,
                                    isFree: isFree,
                                    selectedCurrency: selectedCurrency,
                                    pricingInfo: pricingInfo,
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
                              ),
                            ),
                          ],
                        ),
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

class _TicketsAndTotalPricingSummary extends StatelessWidget {
  const _TicketsAndTotalPricingSummary({
    required this.ticketTypes,
    required this.selectedTickets,
    required this.selectedCurrency,
    required this.selectedNetwork,
    required this.pricingInfo,
  });

  final List<PurchasableTicketType> ticketTypes;
  final List<PurchasableItem> selectedTickets;
  final String selectedCurrency;
  final String? selectedNetwork;
  final EventTicketsPricingInfo pricingInfo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringUtils.capitalize(t.event.tickets(n: 2)),
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          Container(
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              border: Border.all(
                color: colorScheme.outlineVariant,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(Spacing.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EventTicketsSummary(
                        ticketTypes: ticketTypes,
                        selectedTickets: selectedTickets,
                        selectedCurrency: selectedCurrency,
                        selectedNetwork: selectedNetwork,
                        pricingInfo: pricingInfo,
                      ),
                      SizedBox(height: Spacing.xSmall),
                      PromoCodeSummary(
                        pricingInfo: pricingInfo,
                        onPressApply: ({promoCode}) {
                          context.read<CalculateEventTicketPricingBloc>().add(
                                CalculateEventTicketPricingEvent.calculate(
                                  input: CalculateTicketsPricingInput(
                                    discount: promoCode,
                                    eventId: event.id ?? '',
                                    items: selectedTickets,
                                    currency: selectedCurrency,
                                    network: selectedNetwork,
                                  ),
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.w,
                  color: colorScheme.outlineVariant,
                ),
                Padding(
                  padding: EdgeInsets.all(Spacing.small),
                  child: EventTotalPriceSummary(
                    selectedCurrency: selectedCurrency,
                    selectedNetwork: selectedNetwork,
                    pricingInfo: pricingInfo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
