import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/domain/payment/input/get_stripe_cards_input/get_stripe_cards_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_payment_cards_bloc.freezed.dart';

class GetPaymentCardsBloc
    extends Bloc<GetPaymentCardsEvent, GetPaymentCardsState> {
  final paymentRepository = getIt<PaymentRepository>();
  GetPaymentCardsBloc() : super(GetPaymentCardsState.idle()) {
    on<GetPaymentCardsEventFetch>(_onFetch);
  }

  Future<void> _onFetch(GetPaymentCardsEventFetch event, Emitter emit) async {
    final result = await paymentRepository.getStripeCards(input: event.input);
    result.fold(
      (l) => emit(
        GetPaymentCardsState.failure(),
      ),
      (paymentCards) => emit(
        GetPaymentCardsState.success(paymentCards: paymentCards),
      ),
    );
  }
}

@freezed
class GetPaymentCardsEvent with _$GetPaymentCardsEvent {
  factory GetPaymentCardsEvent.fetch({
    required GetStripeCardsInput input,
  }) = GetPaymentCardsEventFetch;
}

@freezed
class GetPaymentCardsState with _$GetPaymentCardsState {
  factory GetPaymentCardsState.idle() = GetPaymentCardsStateIdle;
  factory GetPaymentCardsState.loading() = GetPaymentCardsStateLoading;
  factory GetPaymentCardsState.success({
    required List<PaymentCard> paymentCards,
  }) = GetPaymentCardsStateSuccess;
  factory GetPaymentCardsState.failure() = GetPaymentCardsStateFailure;
}
