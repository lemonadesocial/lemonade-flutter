import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/buy_tickets_bloc/buy_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/application/event_tickets/calculate_event_tickets_pricing_bloc/calculate_event_tickets_pricing_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/payment_listener/payment_listener.dart';
import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_buy_tickets_processing_page/handler/buy_tickets_listener.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_buy_tickets_processing_page/handler/buy_tickets_with_crypto_listener.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_buy_tickets_processing_page/handler/wait_for_payment_notification_handler.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_buy_tickets_processing_page/views/loaders/payment_processing_view.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_buy_tickets_processing_page/views/loaders/transaction_confirming_view.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_buy_tickets_processing_page/views/loaders/wallet_signature_pending_view.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart' as web3modal;

@RoutePage()
class EventBuyTicketsProcessingPage extends StatelessWidget {
  const EventBuyTicketsProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNetwork =
        context.read<SelectEventTicketsBloc>().state.selectedNetwork;
    final event = context.read<EventProviderBloc>().event;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BuyTicketsBloc(),
        ),
        BlocProvider(
          create: (context) => BuyTicketsWithCryptoBloc(
            selectedNetwork: selectedNetwork,
          ),
        ),
        BlocProvider(
          create: (context) => RedeemTicketsBloc(event: event),
        ),
      ],
      child: const EventBuyTicketsProcessingPageView(),
    );
  }
}

class EventBuyTicketsProcessingPageView extends StatefulWidget {
  const EventBuyTicketsProcessingPageView({
    super.key,
  });

  @override
  State<EventBuyTicketsProcessingPageView> createState() =>
      _EventBuyTicketsProcessingPageViewState();
}

class _EventBuyTicketsProcessingPageViewState
    extends State<EventBuyTicketsProcessingPageView> {
  final _waitForNotificationTimer = WaitForPaymentNotificationHandler();
  bool _submittingApplicationFormDone = false;

  EventTicketsPricingInfo? get pricingInfo =>
      context.read<CalculateEventTicketPricingBloc>().state.maybeWhen(
            orElse: () => null,
            success: (pricingInfo, isFree) => pricingInfo,
          );

  bool get isFree =>
      context.read<CalculateEventTicketPricingBloc>().state.maybeWhen(
            orElse: () => false,
            success: (pricingInfo, isFree) => isFree,
            failure: (pricingInfo, isFree) => isFree,
          );

  PaymentCard? get selectedCard =>
      context.read<SelectPaymentCardCubit>().state.when(
            empty: () => null,
            cardSelected: (selectedCard) => selectedCard,
          );

  List<PurchasableItem> get selectedTickets =>
      context.read<SelectEventTicketsBloc>().state.selectedTickets;

  String? get selectedCurrency =>
      context.read<SelectEventTicketsBloc>().state.selectedCurrency;

  String? get selectedNetwork =>
      context.read<SelectEventTicketsBloc>().state.selectedNetwork;

  bool get isCryptoCurrency => selectedNetwork?.isNotEmpty == true;

  Event get event => context.read<EventProviderBloc>().event;

  String get userWalletAddress =>
      getIt<WalletConnectService>().w3mService.session?.address ?? '';

  @override
  void initState() {
    super.initState();
    _processPayment(context);
  }

  @override
  void dispose() {
    _waitForNotificationTimer.cancel();
    super.dispose();
  }

  Future<void> _processPayment(BuildContext context) async {
    try {
      await _checkAndSubmitApplicationForm(context);

      if (isFree && (pricingInfo?.paymentAccounts ?? []).isEmpty == true) {
        _processRedeem(context);
        return;
      }

      if (isCryptoCurrency) {
        _processCryptoPayment(context);
      } else {
        _proceessStripePayment(context);
      }
    } catch (e) {
      SnackBarUtils.showError(
        message: e.toString(),
      );
      AutoRouter.of(context).pop();
    }
  }

  void _processRedeem(BuildContext context) {
    context.read<RedeemTicketsBloc>().add(
          RedeemTicketsEvent.redeem(
            ticketItems: selectedTickets,
          ),
        );
  }

  void _proceessStripePayment(BuildContext context) {
    context.read<BuyTicketsBloc>().add(
          BuyTicketsEvent.buy(
            input: BuyTicketsInput(
              discount: pricingInfo?.promoCode,
              eventId: event.id ?? '',
              accountId: pricingInfo?.paymentAccounts?.firstOrNull?.id ?? '',
              currency: selectedCurrency ?? '',
              items: selectedTickets,
              total: pricingInfo?.total ?? '0',
              fee: pricingInfo?.paymentAccounts?.firstOrNull?.fee ?? '0',
              transferParams: isFree
                  ? null
                  : BuyTicketsTransferParamsInput(
                      paymentMethod: selectedCard?.providerId ?? '',
                    ),
            ),
          ),
        );
  }

  void _processCryptoPayment(BuildContext context) {
    context.read<BuyTicketsWithCryptoBloc>().add(
          BuyTicketsWithCryptoEvent.initAndSignPayment(
            userWalletAddress: userWalletAddress,
            input: BuyTicketsInput(
              eventId: event.id ?? '',
              accountId: pricingInfo?.paymentAccounts?.firstOrNull?.id ?? '',
              currency: selectedCurrency ?? '',
              items: selectedTickets,
              total: pricingInfo?.total ?? '0',
              network: selectedNetwork ?? '',
              discount: pricingInfo?.promoCode,
              fee: pricingInfo?.paymentAccounts?.firstOrNull?.fee,
            ),
          ),
        );
  }

  Future<void> _checkAndSubmitApplicationForm(BuildContext context) async {
    if (event.applicationFormSubmission != null) {
      setState(() {
        _submittingApplicationFormDone = true;
      });
      return;
    }
    bool isApplicationFormRequired =
        (event.applicationQuestions ?? []).isNotEmpty ||
            (event.applicationProfileFields ?? []).isNotEmpty;

    if (!isApplicationFormRequired) {
      setState(() {
        _submittingApplicationFormDone = true;
      });
      return;
    }
    final profileFields =
        context.read<EventApplicationFormBloc>().state.fieldsState;
    final answers = context.read<EventApplicationFormBloc>().state.answers;

    final updateUserResult = await getIt<UserRepository>().updateUser(
      input: Input$UserInput.fromJson(profileFields),
    );
    if (updateUserResult.isLeft()) {
      throw Exception('Failed to update user');
    }
    final submitAnswersResult =
        await getIt<EventRepository>().submitEventApplicationAnswers(
      answers: answers,
      eventId: event.id ?? '',
    );
    if (submitAnswersResult.isLeft()) {
      throw Exception('Failed to submit answers');
    }
    setState(() {
      _submittingApplicationFormDone = true;
    });
  }

  void _handleEventRequireApproval(BuildContext context) async {
    final event = context.read<EventProviderBloc>().event;
    AutoRouter.of(context).root.popUntilRouteWithPath('/events');
    AutoRouter.of(context).root.push(
          RSVPEventSuccessPopupRoute(
            event: event,
            primaryMessage: t.event.eventApproval.waitingApproval,
            secondaryMessage: t.event.eventApproval.waitingApprovalDescription,
            onPressed: (outerContext) async {
              AutoRouter.of(outerContext).replace(
                EventDetailRoute(
                  eventId: event.id ?? '',
                ),
              );
            },
          ),
        );
  }

  Future<void> _onNavigateWhenPaymentConfirmed(
    BuildContext context,
    Event event,
    Payment? payment,
  ) {
    final selectedTicketTypes =
        context.read<SelectEventTicketsBloc>().state.selectedTickets;
    final totalTicketsCount = selectedTicketTypes.fold(
      0,
      (previousValue, element) => previousValue + element.count,
    );
    final userId = AuthUtils.getUserId(context);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);

    return AutoRouter.of(context).replaceAll(
      [
        RSVPEventSuccessPopupRoute(
          event: event,
          primaryMessage:
              isAttending ? t.event.eventBuyTickets.ticketsPurchased : null,
          secondaryMessage: isAttending
              ? t.event.eventBuyTickets.addictionalTicketsPurchasedSuccess(
                  count: totalTicketsCount,
                )
              : null,
          buttonBuilder: (newContext) => LinearGradientButton.primaryButton(
            onTap: () {
              if (payment?.state == Enum$NewPaymentState.await_capture) {
                AutoRouter.of(newContext).root.popUntil(
                      (route) => route.data?.name == EventDetailRoute.name,
                    );
                return;
              }
              AutoRouter.of(newContext).replaceAll([
                EventUtils.getAssignTicketsRouteForBuyFlow(
                  event: event,
                  userId: userId,
                ),
              ]);
            },
            label: t.common.next,
          ),
        ),
      ],
    );
  }

  void _onNavigateWhenRedeemSucess(
    BuildContext context, {
    int? ticketsCount,
  }) {
    final userId = AuthUtils.getUserId(context);
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    AutoRouter.of(context).pushAll(
      [
        RSVPEventSuccessPopupRoute(
          event: event,
          primaryMessage:
              isAttending ? t.event.eventBuyTickets.ticketsPurchased : null,
          secondaryMessage: isAttending
              ? t.event.eventBuyTickets
                  .addictionalTicketsPurchasedSuccess(count: ticketsCount ?? 0)
              : null,
          buttonBuilder: (newContext) => LinearGradientButton.primaryButton(
            onTap: () {
              AutoRouter.of(newContext).replaceAll([
                EventUtils.getAssignTicketsRouteForBuyFlow(
                  event: event,
                  userId: userId,
                ),
              ]);
            },
            label: t.common.next,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RedeemTicketsBloc, RedeemTicketsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              failure: (failure) {
                AutoRouter.of(context).pop();
              },
              success: (redeemTicketsResponse) async {
                final ticketsCount = redeemTicketsResponse.tickets?.length ?? 0;
                if (redeemTicketsResponse.joinRequest != null) {
                  AutoRouter.of(context).root.popUntil(
                        (route) => route.data?.name == EventDetailRoute.name,
                      );
                  return;
                }
                _onNavigateWhenRedeemSucess(
                  context,
                  ticketsCount: ticketsCount,
                );
              },
            );
          },
        ),
        BuyTicketsListener.create(
          onFailure: () {
            AutoRouter.of(context).pop();
          },
          onDone: ({
            payment,
            eventJoinRequest,
          }) {
            if (eventJoinRequest != null) {
              return _handleEventRequireApproval(context);
            }
            if (isFree) {
              _onNavigateWhenPaymentConfirmed(
                context,
                event,
                payment,
              );
              return;
            }
            _waitForNotificationTimer.start(
              context,
              paymentId: payment?.id ?? '',
              onPaymentFailed: () {
                context.read<BuyTicketsBloc>().add(
                      BuyTicketsEvent.receivedPaymentFailedFromNotification(
                        payment: payment,
                      ),
                    );
              },
              onPaymentDone: (payment) {
                _onNavigateWhenPaymentConfirmed(
                  context,
                  event,
                  payment,
                );
              },
            );
          },
        ),
        BuyTicketsWithCryptoListener.create(
          onFailure: () {
            AutoRouter.of(context).pop();
          },
          onSigned: (data) {
            // NOTE: Auto trigger transaction when user done signing signature
            final currencyInfo = PaymentUtils.getCurrencyInfo(
              pricingInfo,
              currency: selectedCurrency ?? '',
            );

            if (currencyInfo == null) return;
            final totalCryptoAmount =
                (pricingInfo?.cryptoTotal ?? BigInt.zero) +
                    // add fee if available for EthereumRelay
                    (pricingInfo?.paymentAccounts?.firstOrNull?.cryptoFee ??
                        BigInt.zero);
            context.read<BuyTicketsWithCryptoBloc>().add(
                  BuyTicketsWithCryptoEvent.makeTransaction(
                    from: userWalletAddress,
                    amount: totalCryptoAmount,
                    to: pricingInfo?.paymentAccounts?.firstOrNull?.accountInfo
                            ?.address ??
                        '',
                    currencyInfo: currencyInfo,
                    currency: selectedCurrency ?? '',
                    eventId: event.id ?? '',
                  ),
                );
          },
          onDone: (data) {
            if (data.eventJoinRequest != null) {
              return _handleEventRequireApproval(context);
            }
            if (isFree) {
              _onNavigateWhenPaymentConfirmed(
                context,
                event,
                data.payment,
              );
              return;
            }
            _waitForNotificationTimer.startWithCrypto(
              context,
              chainId: selectedNetwork ?? '',
              txHash: data.txHash ?? '',
              paymentId: data.payment?.id ?? '',
              onPaymentFailed: () {
                context.read<BuyTicketsWithCryptoBloc>().add(
                      BuyTicketsWithCryptoEvent
                          .receivedPaymentFailedFromNotification(
                        payment: data.payment,
                      ),
                    );
              },
              onPaymentDone: (payment) {
                _onNavigateWhenPaymentConfirmed(
                  context,
                  event,
                  payment,
                );
              },
            );
          },
        ),
      ],
      child: PaymentListener(
        onReceivedPaymentFailed: (eventId, payment) {
          final currentPayment = isCryptoCurrency
              ? context.read<BuyTicketsWithCryptoBloc>().state.data.payment
              : context.read<BuyTicketsBloc>().state.maybeWhen(
                    orElse: () => null,
                    done: (payment, _) => payment,
                  );
          if (currentPayment?.id == payment.id && eventId == event.id) {
            _waitForNotificationTimer.cancel();
            if (isCryptoCurrency) {
              context.read<BuyTicketsWithCryptoBloc>().add(
                    BuyTicketsWithCryptoEvent
                        .receivedPaymentFailedFromNotification(
                      payment: payment,
                    ),
                  );
            } else {
              context.read<BuyTicketsBloc>().add(
                    BuyTicketsEvent.receivedPaymentFailedFromNotification(
                      payment: payment,
                    ),
                  );
            }
          }
        },
        onReceivedPaymentSuccess: (eventId, payment) {
          final eventJoinRequest = isCryptoCurrency
              ? context
                  .read<BuyTicketsWithCryptoBloc>()
                  .state
                  .data
                  .eventJoinRequest
              : context.read<BuyTicketsBloc>().state.maybeWhen(
                    orElse: () => null,
                    done: (payment, eventJoinRequest) => eventJoinRequest,
                  );
          if (eventJoinRequest != null) {
            return;
          }
          if (eventId == event.id) {
            _waitForNotificationTimer.cancel();
            _onNavigateWhenPaymentConfirmed(
              context,
              event,
              payment,
            );
          }
        },
        child: Scaffold(
          body: Builder(
            builder: (context) {
              if (!_submittingApplicationFormDone) {
                return const PaymentProcessingView();
              }
              if (isCryptoCurrency) {
                return BlocBuilder<BuyTicketsWithCryptoBloc,
                    BuyTicketsWithCryptoState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      loading: (data) {
                        if (data.signature == null) {
                          return const WalletSignaturePendingView();
                        }
                        return const PaymentProcessingView();
                      },
                      signed: (data) => const PaymentProcessingView(),
                      done: (data) =>
                          FutureBuilder<dartz.Either<Failure, Chain?>>(
                        future: getIt<Web3Repository>()
                            .getChainById(chainId: selectedNetwork ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.hasError ||
                              snapshot.data == null ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const PaymentProcessingView();
                          }
                          final chain = snapshot.data?.getOrElse(() => null);
                          final duration = (chain?.blockTime ?? 0) *
                              (chain?.safeConfirmations ?? 0);
                          return TransactionConfirmingView(
                            duration:
                                duration != 0 ? duration.toInt() + 10 : 60,
                            chain: chain,
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return const PaymentProcessingView();
            },
          ),
        ),
      ),
    );
  }
}
