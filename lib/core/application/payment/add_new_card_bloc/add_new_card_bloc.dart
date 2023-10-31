import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_new_card_state.dart';

part 'add_new_card_bloc.freezed.dart';

class AddNewCardBloc extends Cubit<AddNewCardState> {
  AddNewCardBloc(this._paymentRepository) : super(AddNewCardState.initial());

  final PaymentRepository _paymentRepository;

  void onCardHolderNameChange(String? value) {
    emit(state.copyWith(cardHolderName: value));
  }

  void onCardNumberChange(String? value) {
    emit(state.copyWith(cardNumber: value));
  }

  void onValidDateChange(String? value) {
    emit(state.copyWith(validThrough: value));
  }

  void onCvvChange(String? value) {
    emit(state.copyWith(cvv: value));
  }

  Future<void> addNewCard() async {
    emit(state.copyWith(status: AddNewCardBlocStatus.loading));
    // For debugging purpose
    Stripe.publishableKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx';
    final cardDetail = CardDetails(
      number: state.cardNumber,
      expirationMonth: int.parse(state.validThrough!.substring(0, 2)),
      expirationYear: int.parse(
        state.validThrough!.substring(
          state.validThrough!.length - 2,
        ),
      ),
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

    final result = await _paymentRepository.createNewCard(tokenId: token.id);
    result.fold(
      (l) => emit(state.copyWith(status: AddNewCardBlocStatus.error)),
      (newCardInfo) {
        emit(state.copyWith(status: AddNewCardBlocStatus.success));
      },
    );
  }
}
