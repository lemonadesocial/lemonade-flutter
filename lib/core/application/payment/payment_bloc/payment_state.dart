part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(PaymentStatus.initial) PaymentStatus status,
    @Default('') String publishableKey,
    EventTicketsPricingInfo? pricingInfo,
    PaymentCard? selectedCard,
    @Default([]) List<PaymentCard> listCard,
  }) = _PaymentState;

  factory PaymentState.initial() => const PaymentState();
}

enum PaymentStatus {
  initial,
  loading,
  loaded,
  checkout,
  confirm,
  buyTicketInProgress,
  success,
  error,
}
