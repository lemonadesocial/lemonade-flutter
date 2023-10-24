import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_bloc.freezed.dart';

part 'payment_state.dart';

class PaymentBloc extends Cubit<PaymentState> {
  PaymentBloc(this._repository) : super(PaymentState.initial());

  final PaymentRepository _repository;

  Future<void> initializeStripePayment() async {
    final result = await _repository.getPublishableKey();
    result.fold((l) {}, (publishableKey) {
      emit(
        state.copyWith(
          status: PaymentStatus.initial,
          publishableKey: publishableKey,
        ),
      );
    });
  }

  Future<void> getListCard() async {
    final result = await _repository.getListCard();
    result.fold((l) {}, (listCard) {
      emit(
        state.copyWith(
          status: PaymentStatus.initial,
          selectedCard: listCard[0],
          listCard: listCard,
        ),
      );
    });
  }

  void initTotalPaymentAmount(double amount) {
    emit(
      state.copyWith(
        status: PaymentStatus.initial,
        totalAmount: amount,
      ),
    );
  }

  void onCardSelected(dynamic card) {
    emit(
      state.copyWith(
        status: PaymentStatus.initial,
        selectedCard: card,
      ),
    );
  }
}
