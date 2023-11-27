import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/input/create_stripe_card_input/create_stripe_card_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_new_card_bloc.freezed.dart';

class AddNewCardBloc extends Cubit<AddNewCardState> {
  final _paymentRepository = getIt<PaymentRepository>();

  AddNewCardBloc() : super(AddNewCardState.initial());

  void onCardHolderNameChange(String? value) {
    emit(
      state.copyWith(
        cardHolderName: value,
        status: AddNewCardBlocStatus.initial,
        error: null,
      ),
    );
  }

  void onCardNumberChange(String? value) {
    emit(
      state.copyWith(
        cardNumber: value,
        status: AddNewCardBlocStatus.initial,
        error: null,
      ),
    );
  }

  void onValidDateChange(String? value) {
    emit(
      state.copyWith(
        validThrough: value,
        status: AddNewCardBlocStatus.initial,
        error: null,
      ),
    );
  }

  void onCvvChange(String? value) {
    emit(
      state.copyWith(
        cvv: value,
        status: AddNewCardBlocStatus.initial,
        error: null,
      ),
    );
  }

  Future<void> addNewCard({
    required String publishableKey,
    required String paymentAccountId,
  }) async {
    try {
      emit(state.copyWith(status: AddNewCardBlocStatus.loading));
      // For debugging purpose
      Stripe.publishableKey = publishableKey;

      final expirationMonth = int.parse(state.validThrough!.substring(0, 2));
      final expirationYear = int.parse(
        state.validThrough!.substring(
          state.validThrough!.length - 2,
        ),
      );
      final cardDetail = CardDetails(
        number: state.cardNumber,
        expirationMonth: expirationMonth,
        expirationYear: expirationYear,
        cvc: state.cvv,
      );

      await Stripe.instance.dangerouslyUpdateCardDetails(cardDetail);

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      final result = await _paymentRepository.createStripeCard(
        input: CreateStripeCardInput(
          paymentAccount: paymentAccountId,
          paymentMethod: paymentMethod.id,
        ),
      );

      result.fold(
        (l) => emit(
          state.copyWith(
            status: AddNewCardBlocStatus.error,
          ),
        ),
        (newCardInfo) {
          emit(
            state.copyWith(
              status: AddNewCardBlocStatus.success,
              paymentCard: newCardInfo,
            ),
          );
        },
      );
    } on StripeException catch (e) {
      emit(
        state.copyWith(
          status: AddNewCardBlocStatus.error,
          error: e.error.message,
        ),
      );
    }
  }
}

@freezed
class AddNewCardState with _$AddNewCardState {
  AddNewCardState._();

  factory AddNewCardState({
    @Default(AddNewCardBlocStatus.initial) AddNewCardBlocStatus status,
    PaymentCard? paymentCard,
    String? cardHolderName,
    String? cardNumber,
    String? validThrough,
    String? cvv,
    String? error,
  }) = _AddNewCardState;

  factory AddNewCardState.initial() => AddNewCardState();

  bool get fieldValidated =>
      cardHolderName != null &&
      cardNumber?.length == 19 &&
      validThrough?.length == 5 &&
      cvv?.length == 3;
}

enum AddNewCardBlocStatus {
  initial,
  loading,
  success,
  error,
}
