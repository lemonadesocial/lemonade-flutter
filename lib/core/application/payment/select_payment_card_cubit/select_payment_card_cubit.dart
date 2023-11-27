import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_payment_card_cubit.freezed.dart';

class SelectPaymentCardCubit extends Cubit<SelectPaymentCardState> {
  SelectPaymentCardCubit() : super(SelectPaymentCardState.empty());

  void selectPaymentCard({
    required PaymentCard paymentCard,
  }) {
    emit(
      SelectPaymentCardState.cardSelected(
        selectedPaymentCard: paymentCard,
      ),
    );
  }
}

@freezed
class SelectPaymentCardState with _$SelectPaymentCardState {
  factory SelectPaymentCardState.empty() = SelectPaymentCardStateEmpty;
  factory SelectPaymentCardState.cardSelected({
    required PaymentCard selectedPaymentCard,
  }) = SelectPaymentCardStateCardSelected;
}
