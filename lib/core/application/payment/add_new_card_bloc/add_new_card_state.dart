part of 'add_new_card_bloc.dart';

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
