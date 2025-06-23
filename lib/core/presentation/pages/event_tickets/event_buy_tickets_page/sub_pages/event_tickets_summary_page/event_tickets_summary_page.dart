import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/calculate_event_tickets_pricing_bloc/calculate_event_tickets_pricing_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/get_payment_cards_bloc/get_payment_cards_bloc.dart';
import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/application/wallet/sign_wallet_bloc/sign_wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/reward_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_info_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_total_price_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_tickets_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/payment_footer/pay_by_crypto_footer.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/payment_footer/pay_by_stripe_footer.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/promo_code/promo_code_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_application_form/rsvp_application_form.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/select_payment_accounts_dropdown/select_payment_accounts_dropdown.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_item/ticket_token_rewards_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/core/utils/user_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class EventTicketsSummaryPage extends StatelessWidget {
  const EventTicketsSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignWalletBloc(),
        ),
        BlocProvider.value(
          value: context.read<CalculateEventTicketPricingBloc>(),
        ),
      ],
      child: const EventTicketsSummaryPageView(),
    );
  }
}

class EventTicketsSummaryPageView extends StatefulWidget {
  const EventTicketsSummaryPageView({
    super.key,
  });

  @override
  State<EventTicketsSummaryPageView> createState() =>
      _EventTicketsSummaryPageViewState();
}

class _EventTicketsSummaryPageViewState
    extends State<EventTicketsSummaryPageView> {
  PaymentAccount? _selectedPaymentAccount;
  String? _selectedCurrency;

  @override
  void initState() {
    super.initState();
    _autoSelectPaymentAccount();
  }

  List<PaymentAccount> get commonPaymentAccounts {
    final selectTicketsBloc = context.read<SelectEventTicketsBloc>();
    final paymentAccounts = selectTicketsBloc.state.commonPaymentAccounts;
    final result = paymentAccounts
        .where(
          (account) => _findCurrency(account) != null,
        )
        .toList();

    return result;
  }

  String? _findCurrency(PaymentAccount? paymentAccount) {
    if (paymentAccount == null) return null;

    final selectTicketsBloc = context.read<SelectEventTicketsBloc>();
    final ticketTypes =
        selectTicketsBloc.eventTicketTypesResponse?.ticketTypes ?? [];
    final selectedTickets = selectTicketsBloc.state.selectedTickets;

    if (selectedTickets.isEmpty) return null;

    // Get currencies for first ticket to start intersection
    final firstTicket = selectedTickets.first;
    final firstTicketType =
        ticketTypes.firstWhereOrNull((type) => type.id == firstTicket.id);
    var commonCurrencies = firstTicketType?.prices
            ?.where(
              (price) =>
                  (price.paymentAccounts ?? []).contains(paymentAccount.id),
            )
            .map((price) => price.currency)
            .toSet() ??
        {};

    // Early return if first ticket has no valid currencies
    if (commonCurrencies.isEmpty) return null;

    /*
        ticketCurrencies = [
          ["USD", "ETH"],       // ticket A currencies
          ["USD", "ETH"],       // ticket B currencies
          ["USD", "ETH", "USDC"] // ticket C currencies
        ];
        commonCurrencies = ["USD", "ETH"];
    */
    // Intersect with remaining tickets
    for (final ticket in selectedTickets.skip(1)) {
      final ticketType =
          ticketTypes.firstWhereOrNull((type) => type.id == ticket.id);
      final ticketCurrencies = ticketType?.prices
              ?.where(
                (price) =>
                    (price.paymentAccounts ?? []).contains(paymentAccount.id),
              )
              .map((price) => price.currency)
              .toSet() ??
          {};

      commonCurrencies = commonCurrencies.intersection(ticketCurrencies);

      // Early return if no common currencies found
      if (commonCurrencies.isEmpty) return null;
    }

    return commonCurrencies.firstOrNull;
  }

  void _selectPaymentAccount(PaymentAccount? paymentAccount) {
    setState(() {
      _selectedPaymentAccount = paymentAccount;
      _selectedCurrency = _findCurrency(paymentAccount) ?? 'USD';
    });
    final eventId = context.read<EventProviderBloc>().event.id;
    final selectTicketBlocState = context.read<SelectEventTicketsBloc>().state;
    final selectedTickets = selectTicketBlocState.selectedTickets;
    context.read<CalculateEventTicketPricingBloc>().add(
          CalculateEventTicketPricingEvent.calculate(
            input: CalculateTicketsPricingInput(
              eventId: eventId ?? '',
              items: selectedTickets,
              currency: _selectedCurrency ?? '',
            ),
          ),
        );
  }

  void _autoSelectPaymentAccount() {
    final defaultPaymentAccount = commonPaymentAccounts.firstOrNull;
    _selectPaymentAccount(defaultPaymentAccount);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;
    final user = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final selectTicketsBlocState = context.read<SelectEventTicketsBloc>().state;
    final selectedTickets = selectTicketsBlocState.selectedTickets;
    final isApplicationFormRequired =
        event.applicationProfileFields?.isNotEmpty == true ||
            event.applicationQuestions?.isNotEmpty == true;
    final isApplicationFormValid = !isApplicationFormRequired
        ? true
        : event.applicationFormSubmission != null
            ? true
            : context.watch<EventApplicationFormBloc>().state.isValid;
    final signEthereumWalletBlocState = context.watch<SignWalletBloc>().state;
    final isEthereumWalletVerifiedRequired =
        EventUtils.isWalletVerifiedRequired(
      event,
      platform: Enum$BlockchainPlatform.ethereum,
    );
    final isUserEthereumWalletVerified = UserUtils.isWalletVerified(
          user,
          platform: Enum$BlockchainPlatform.ethereum,
        ) ||
        signEthereumWalletBlocState is SignWalletStateSuccess;
    final isWalletVerificationValid =
        isEthereumWalletVerifiedRequired ? isUserEthereumWalletVerified : true;
    final isSubmitDisabled =
        !isApplicationFormValid || !isWalletVerificationValid;

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
                if (pricingInfo.paymentAccounts?.isEmpty == true) return;
                // payment account returned from pricinng info contain fee for transaction
                // so we need to update the selected one
                _selectedPaymentAccount =
                    pricingInfo.paymentAccounts?.firstWhereOrNull(
                  (element) => element.id == _selectedPaymentAccount?.id,
                );

                if (PaymentUtils.isCryptoPayment(pricingInfo)) return;
                context.read<GetPaymentCardsBloc>().add(
                      GetPaymentCardsEvent.fetch(
                        input: GetStripeCardsInput(
                          limit: 25,
                          skip: 0,
                          paymentAccount: _selectedPaymentAccount?.id ?? '',
                        ),
                      ),
                    );
              },
              orElse: () => null,
            );
          },
        ),
        BlocListener<SignWalletBloc, SignWalletState>(
          listener: (context, state) async {
            if (state is SignWalletStateSuccess) {
              await Future.delayed(const Duration(seconds: 3));
              context.read<AuthBloc>().add(const AuthEvent.refreshData());
            }
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
                                                  _selectedCurrency ?? '',
                                              pricingInfo: pricingInfo,
                                              selectedPaymentAccount:
                                                  _selectedPaymentAccount,
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
                                          selectedCurrency:
                                              _selectedCurrency ?? '',
                                          selectedPaymentAccount:
                                              _selectedPaymentAccount,
                                          pricingInfo: pricingInfo,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: Spacing.medium),
                                  Builder(
                                    builder: (context) {
                                      final allPaymentAccountsOfSelectedTickets =
                                          ticketTypes
                                              .where(
                                                (type) => selectedTickets.any(
                                                  (ticket) =>
                                                      ticket.id == type.id,
                                                ),
                                              )
                                              .expand<PaymentAccount>(
                                                (type) =>
                                                    type.prices?.expand<
                                                        PaymentAccount>(
                                                      (price) =>
                                                          price
                                                              .paymentAccountsExpanded ??
                                                          [],
                                                    ) ??
                                                    [],
                                              )
                                              .toSet()
                                              .toList();
                                      final disabledPaymentAccounts =
                                          allPaymentAccountsOfSelectedTickets
                                              .where(
                                                (account) =>
                                                    !commonPaymentAccounts
                                                        .contains(account),
                                              )
                                              .toList();

                                      if (allPaymentAccountsOfSelectedTickets
                                          .isEmpty) {
                                        return const SizedBox.shrink();
                                      }

                                      return Column(
                                        children: [
                                          SelectPaymentAccountsDropdown(
                                            paymentAccounts:
                                                commonPaymentAccounts,
                                            disabledPaymentAccounts:
                                                disabledPaymentAccounts,
                                            selectedPaymentAccount:
                                                _selectedPaymentAccount,
                                            onChanged: _selectPaymentAccount,
                                          ),
                                          SizedBox(height: Spacing.medium),
                                        ],
                                      );
                                    },
                                  ),
                                  FutureBuilder<
                                      dartz.Either<Failure,
                                          List<TokenRewardSetting>>>(
                                    future: getIt<RewardRepository>()
                                        .listTicketTokenRewardSettings(
                                      event: event.id ?? '',
                                      ticketTypes: selectedTickets
                                          .map((ticket) => ticket.id)
                                          .toList(),
                                    ),
                                    builder: (context, snapshot) {
                                      final tokenRewardSettings =
                                          snapshot.data?.getOrElse(() => []);
                                      if (tokenRewardSettings == null ||
                                          tokenRewardSettings.isEmpty == true) {
                                        return const SizedBox.shrink();
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Spacing.small,
                                            ),
                                            child: TicketTokenRewardsList(
                                              titleColor: appColors.textPrimary,
                                              containerDecoration:
                                                  BoxDecoration(
                                                color: appColors.cardBg,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  LemonRadius.medium,
                                                ),
                                                border: Border.all(
                                                  color: appColors.pageDivider,
                                                  width: 1.w,
                                                ),
                                              ),
                                              itemSeparator: Divider(
                                                height: 1.w,
                                                color: appColors.pageDivider,
                                              ),
                                              itemPadding: EdgeInsets.all(
                                                Spacing.small,
                                              ),
                                              tokenRewardSettings:
                                                  tokenRewardSettings,
                                            ),
                                          ),
                                          SizedBox(height: Spacing.medium),
                                        ],
                                      );
                                    },
                                  ),
                                  if (event.applicationFormSubmission ==
                                      null) ...[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Spacing.xSmall,
                                      ),
                                      child: const RSVPApplicationForm(),
                                    ),
                                  ],
                                  SizedBox(height: 150.w),
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

                                  if (PaymentUtils.isCryptoPayment(
                                    pricingInfo,
                                  )) {
                                    return PayByCryptoFooter(
                                      selectedTickets: selectedTickets,
                                      selectedCurrency: _selectedCurrency ?? '',
                                      pricingInfo: pricingInfo,
                                      isFree: isFree,
                                      disabled: isSubmitDisabled,
                                      selectedPaymentAccount:
                                          _selectedPaymentAccount,
                                    );
                                  }

                                  return PayByStripeFooter(
                                    disabled: isSubmitDisabled,
                                    isFree: isFree,
                                    selectedCurrency: _selectedCurrency ?? '',
                                    pricingInfo: pricingInfo,
                                    selectedPaymentAccount:
                                        _selectedPaymentAccount,
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
    required this.pricingInfo,
    required this.selectedPaymentAccount,
  });

  final List<PurchasableTicketType> ticketTypes;
  final List<PurchasableItem> selectedTickets;
  final String selectedCurrency;
  final EventTicketsPricingInfo pricingInfo;
  final PaymentAccount? selectedPaymentAccount;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;
    final isPaymentRequired =
        context.read<SelectEventTicketsBloc>().state.isPaymentRequired;
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringUtils.capitalize(t.event.tickets(n: 2)),
            style: appText.md,
          ),
          SizedBox(height: Spacing.xSmall),
          Container(
            decoration: BoxDecoration(
              color: appColors.cardBg,
              border: Border.all(
                color: appColors.pageDivider,
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
                        selectedPaymentAccount: selectedPaymentAccount,
                        pricingInfo: pricingInfo,
                      ),
                      if (isPaymentRequired) ...[
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
                                    ),
                                  ),
                                );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.w,
                  color: appColors.pageDivider,
                ),
                Padding(
                  padding: EdgeInsets.all(Spacing.small),
                  child: EventTotalPriceSummary(
                    selectedCurrency: selectedCurrency,
                    pricingInfo: pricingInfo,
                    selectedPaymentAccount: selectedPaymentAccount,
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
