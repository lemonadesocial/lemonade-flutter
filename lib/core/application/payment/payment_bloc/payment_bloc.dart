import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/entities/payment_card_entity/payment_card_entity.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_bloc.freezed.dart';

part 'payment_state.dart';

class PaymentBloc extends Cubit<PaymentState> {
  PaymentBloc(
    this._repository,
    this._eventTicketRepository,
  ) : super(PaymentState.initial());

  final PaymentRepository _repository;
  final EventTicketRepository _eventTicketRepository;

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
    emit(state.copyWith(status: PaymentStatus.loading));
    final result = await _repository.getListCard();
    result.fold((l) {}, (listCard) {
      emit(
        state.copyWith(
          status: PaymentStatus.loaded,
          selectedCard: listCard.isEmpty ? null : listCard[0],
          listCard: listCard,
        ),
      );
    });
  }

  Future<void> calculatePricing({
    required CalculateTicketsPricingInput input,
  }) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    final result = await _eventTicketRepository.calculateTicketsPricing(
      input: input,
    );
    result.fold(
      (l) {},
      (pricingInfo) => emit(
        state.copyWith(pricingInfo: pricingInfo),
      ),
    );
  }

  void onCardSelected(PaymentCardEntity card) {
    emit(
      state.copyWith(
        status: PaymentStatus.initial,
        selectedCard: card,
      ),
    );
  }

  void newCardAdded(PaymentCardEntity card) {
    emit(
      state.copyWith(
        status: PaymentStatus.initial,
        selectedCard: card,
        listCard: List.from(state.listCard)..add(card),
      ),
    );
  }
}
