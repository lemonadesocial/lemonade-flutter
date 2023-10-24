part of 'payment_bloc.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(PaymentStatus.initial) PaymentStatus status,
    @Default('') String publishableKey,
    double? totalAmount,
    dynamic selectedCard,
    @Default([]) List<dynamic> listCard,
  }) = _PaymentState;

  factory PaymentState.initial() => const PaymentState();
}

enum PaymentStatus {
  initial,
  loading,
  success,
  error,
}
