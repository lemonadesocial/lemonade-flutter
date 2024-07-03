import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_tickets_bloc.freezed.dart';

const maxUpdatePaymentAttempt = 5;

class BuyTicketsBloc extends Bloc<BuyTicketsEvent, BuyTicketsState> {
  final eventTicketRepository = getIt<EventTicketRepository>();
  final paymentRepository = getIt<PaymentRepository>();
  int _updatePaymentAttemptCount = 0;
  Payment? _currentPayment;
  EventJoinRequest? _eventJoinRequest;

  BuyTicketsBloc() : super(BuyTicketsState.idle()) {
    on<StartBuyTickets>(_onBuy);
    on<ProcessPaymentIntent>(_onProcessPaymentIntent);
    on<ProcessUpdatePayment>(_onProcessUpdatePayment);
    on<ReceivedPaymentFailedFromNotification>(
      _onReceivedPaymentFailedFromNotification,
    );
  }

  Future<void> _onBuy(StartBuyTickets event, Emitter emit) async {
    emit(BuyTicketsState.loading());
    final paymentMethod = event.input.transferParams?.paymentMethod ?? '';

    if (_currentPayment != null) {
      add(
        BuyTicketsEvent.processPaymentIntent(
          paymentMethod: event.input.transferParams?.paymentMethod ?? '',
          payment: _currentPayment!,
        ),
      );
    }

    final result = await eventTicketRepository.buyTickets(input: event.input);

    result.fold(
      (l) => emit(
        BuyTicketsState.failure(
          failureReason: InitPaymentFailure(),
        ),
      ),
      (response) async {
        _eventJoinRequest = response.eventJoinRequest;
        if (response.payment == null) {
          return emit(
            BuyTicketsState.failure(
              failureReason: InitPaymentFailure(),
            ),
          );
        }

        final isFree = BigInt.parse(event.input.total) == BigInt.zero;
        // if isFree then consider as payment done and listen for notification
        if (isFree) {
          return emit(
            BuyTicketsState.done(
              payment: response.payment,
              eventJoinRequest: _eventJoinRequest,
            ),
          );
        }

        add(
          BuyTicketsEvent.processPaymentIntent(
            paymentMethod: paymentMethod,
            payment: response.payment!,
          ),
        );
      },
    );
  }

  Future<void> _onProcessPaymentIntent(
    ProcessPaymentIntent event,
    Emitter emit,
  ) async {
    final payment = event.payment;
    _currentPayment = payment;
    try {
      // TODO: will remove after confirmation with BE
      // @deprecated
      // final stripePublicKey = payment.transferMetadata?.tryGet('public_key') ?? '';
      // final stripeClientSecret = payment.transferMetadata?.tryGet('client_secret') ?? '';
      // final paymentMethodId = event.paymentMethod;

      // Stripe.publishableKey = stripePublicKey;

      // // if payment method not defined then have to use stripe payment sheet
      // if (paymentMethodId == null || paymentMethodId.isEmpty) {
      //   await Stripe.instance.initPaymentSheet(
      //     paymentSheetParameters: SetupPaymentSheetParameters(
      //       paymentIntentClientSecret: stripeClientSecret,
      //       style: ThemeMode.dark,
      //     ),
      //   );

      //   await Stripe.instance.presentPaymentSheet();
      // }

      add(
        BuyTicketsEvent.processUpdatePayment(
          payment: payment,
          paymentMethod: event.paymentMethod,
        ),
      );
    } catch (e) {
      if (e is StripeException) {
        return emit(
          BuyTicketsState.failure(
            failureReason: StripePaymentFailure(exception: e),
          ),
        );
      }
      emit(
        BuyTicketsState.failure(
          failureReason: InitPaymentFailure(),
        ),
      );
    }
  }

  Future<void> _onProcessUpdatePayment(
    ProcessUpdatePayment event,
    Emitter emit,
  ) async {
    if (_updatePaymentAttemptCount == maxUpdatePaymentAttempt) {
      return emit(
        BuyTicketsState.failure(
          failureReason: UpdatePaymentFailure(),
        ),
      );
    }
    _updatePaymentAttemptCount++;
    final result = await paymentRepository.updatePayment(
      input: UpdatePaymentInput(
        id: event.payment.id ?? '',
        transferParams: UpdatePaymentTransferParams(
          paymentMethod: event.paymentMethod,
          returnUrl: '${AppConfig.appScheme}://payment',
        ),
      ),
    );
    result.fold(
      (l) {
        add(
          BuyTicketsEvent.processUpdatePayment(
            payment: event.payment,
            paymentMethod: event.paymentMethod,
          ),
        );
      },
      (payment) {
        if (payment != null) {
          _updatePaymentAttemptCount = 0;
          emit(
            BuyTicketsState.done(
              payment: payment,
              eventJoinRequest: _eventJoinRequest,
            ),
          );
        }
      },
    );
  }

  void _onReceivedPaymentFailedFromNotification(
    ReceivedPaymentFailedFromNotification event,
    Emitter emit,
  ) {
    emit(
      BuyTicketsState.failure(
        failureReason: NotificationPaymentFailure(),
      ),
    );
  }
}

@freezed
class BuyTicketsEvent with _$BuyTicketsEvent {
  factory BuyTicketsEvent.buy({
    required BuyTicketsInput input,
  }) = StartBuyTickets;
  factory BuyTicketsEvent.processPaymentIntent({
    required Payment payment,
    String? paymentMethod,
  }) = ProcessPaymentIntent;
  factory BuyTicketsEvent.processUpdatePayment({
    required Payment payment,
    String? paymentMethod,
  }) = ProcessUpdatePayment;
  factory BuyTicketsEvent.receivedPaymentFailedFromNotification({
    Payment? payment,
  }) = ReceivedPaymentFailedFromNotification;
}

@freezed
class BuyTicketsState with _$BuyTicketsState {
  factory BuyTicketsState.idle() = BuyTicketsStateIdle;
  factory BuyTicketsState.loading() = BuyTicketsStateLoading;
  factory BuyTicketsState.done({
    Payment? payment,
    EventJoinRequest? eventJoinRequest,
  }) = BuyTicketsStateDone;
  factory BuyTicketsState.failure({
    required BuyTicketsFailure failureReason,
  }) = BuyTicketsStateFailure;
}

class BuyTicketsFailure {}

class InitPaymentFailure extends BuyTicketsFailure {}

class StripePaymentFailure extends BuyTicketsFailure {
  StripeException exception;
  StripePaymentFailure({
    required this.exception,
  });
}

class UpdatePaymentFailure extends BuyTicketsFailure {}

class NotificationPaymentFailure extends BuyTicketsFailure {}
