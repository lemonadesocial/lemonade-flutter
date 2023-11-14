import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/input/update_payment_input/update_payment_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_tickets_bloc.freezed.dart';

const maxUpdatePaymentAttempt = 5;

class BuyTicketsBloc extends Bloc<BuyTicketsEvent, BuyTicketsState> {
  final eventTicketRepository = getIt<EventTicketRepository>();
  final paymentRepository = getIt<PaymentRepository>();
  int _updatePaymentAttemptCount = 0;
  Payment? currentPayment;

  BuyTicketsBloc() : super(BuyTicketsState.idle()) {
    on<StartBuyTickets>(_onBuy);
    on<ProcessPaymentIntent>(_onProcessPaymentIntent);
    on<ProcessUpdatePayment>(_onProcessUpdatePayment);
  }

  Future<void> _onBuy(StartBuyTickets event, Emitter emit) async {
    emit(BuyTicketsState.loading());
    final result = await eventTicketRepository.buyTickets(input: event.input);
    result.fold(
      (l) => emit(
        BuyTicketsState.failure(
          failureReason: InitPaymentFailure(),
        ),
      ),
      (payment) async {
        if (payment == null) {
          return emit(
            BuyTicketsState.failure(
              failureReason: InitPaymentFailure(),
            ),
          );
        }
        add(
          BuyTicketsEvent.processPaymentIntent(payment: payment),
        );
      },
    );
  }

  Future<void> _onProcessPaymentIntent(
    ProcessPaymentIntent event,
    Emitter emit,
  ) async {
    final payment = event.payment;
    currentPayment = payment;
    try {
      final stripePublicKey = payment.transferMetadata?['public_key'];
      final stripeClientSecret = payment.transferMetadata?['client_secret'];
      final paymentMethodId = payment.transferParams?['payment_method'] ?? '';

      Stripe.publishableKey = stripePublicKey;

      // if payment method not defined then have to use stripe payment sheet
      if (paymentMethodId == null || (paymentMethodId as String).isEmpty) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: stripeClientSecret,
            style: ThemeMode.dark,
          ),
        );

        await Stripe.instance.presentPaymentSheet();
      }

      add(
        BuyTicketsEvent.processUpdatePayment(payment: payment),
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
      input: UpdatePaymentInput(id: event.payment.id ?? ''),
    );
    result.fold(
      (l) {
        add(
          BuyTicketsEvent.processUpdatePayment(payment: event.payment),
        );
      },
      (payment) {
        if (payment != null) {
          _updatePaymentAttemptCount = 0;
          emit(BuyTicketsState.done(payment: payment));
        }
      },
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
  }) = ProcessPaymentIntent;
  factory BuyTicketsEvent.processUpdatePayment({
    required Payment payment,
  }) = ProcessUpdatePayment;
}

@freezed
class BuyTicketsState with _$BuyTicketsState {
  factory BuyTicketsState.idle() = BuyTicketsStateIdle;
  factory BuyTicketsState.loading() = BuyTicketsStateLoading;
  factory BuyTicketsState.done({
    required Payment payment,
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
