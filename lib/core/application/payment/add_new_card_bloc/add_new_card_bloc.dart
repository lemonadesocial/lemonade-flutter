import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_new_card_state.dart';

part 'add_new_card_bloc.freezed.dart';

class AddNewCardBloc extends Cubit<AddNewCardState> {
  AddNewCardBloc(
    this._paymentRepository,
  ) : super(AddNewCardState.initial());

  final PaymentRepository _paymentRepository;

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

  Future<void> addNewCard(
    String publishableKey, {
    required String userId,
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
      CardTokenParams cardParams = CardTokenParams(
        type: TokenType.Card,
        name: state.cardHolderName,
      );
      await Stripe.instance.dangerouslyUpdateCardDetails(cardDetail);
      final token = await Stripe.instance.createToken(
        CreateTokenParams.card(params: cardParams),
      );

      final result = await _paymentRepository.createNewCard(
        userId: userId,
        tokenId: token.id,
      );
      result.fold(
        (l) => emit(state.copyWith(status: AddNewCardBlocStatus.error)),
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
