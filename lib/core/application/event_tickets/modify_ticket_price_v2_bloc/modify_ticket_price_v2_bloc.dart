import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_ticket_price_v2_bloc.freezed.dart';

class ModifyTicketPriceV2Bloc
    extends Bloc<ModifyTicketPriceV2Event, ModifyTicketPriceV2State> {
  final TicketPriceInput? initialTicketPrice;
  ModifyTicketPriceV2Bloc({
    this.initialTicketPrice,
  }) : super(
          ModifyTicketPriceV2State(
            isValid: false,
          ),
        ) {
    on<_ModifyTicketPriceV2EventOnCostChanged>(_onCostChanged);
    on<_ModifyTicketPriceV2EventOnCurrencyChanged>(_onCurrencyChanged);
    on<_ModifyTicketPriceV2EventOnPaymentAccountSelected>(
      _onPaymentAccountSelected,
    );
    on<_ModifyTicketPriceV2EventPopulateTicketPrice>(_onPopulateTicketPrice);
    on<_ModifyTicketPriceV2EventReset>(_onReset);
  }

  void _onCostChanged(
    _ModifyTicketPriceV2EventOnCostChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(cost: event.cost);
    emit(_validate(newState));
  }

  void _onCurrencyChanged(
    _ModifyTicketPriceV2EventOnCurrencyChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      currency: event.currency,
      cost: null,
    );
    emit(_validate(newState));
  }

  void _onPaymentAccountSelected(
    _ModifyTicketPriceV2EventOnPaymentAccountSelected event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      selectedPaymentAccounts: event.paymentAccounts,
    );
    emit(_validate(newState));
  }

  void _onReset(
    _ModifyTicketPriceV2EventReset event,
    Emitter emit,
  ) {
    emit(
      ModifyTicketPriceV2State(
        isValid: false,
      ),
    );
  }

  void _onPopulateTicketPrice(
    _ModifyTicketPriceV2EventPopulateTicketPrice event,
    Emitter emit,
  ) {
    if (initialTicketPrice == null) {
      return;
    }

    emit(
      _validate(
        ModifyTicketPriceV2State(
          selectedPaymentAccounts: initialTicketPrice?.paymentAccounts,
          currency: initialTicketPrice?.currency,
          cost: initialTicketPrice?.cost,
          isValid: false,
        ),
      ),
    );
  }

  ModifyTicketPriceV2State _validate(ModifyTicketPriceV2State state) {
    return state.copyWith(
      isValid:
          state.cost?.isNotEmpty == true && state.currency?.isNotEmpty == true,
    );
  }
}

@freezed
class ModifyTicketPriceV2Event with _$ModifyTicketPriceV2Event {
  factory ModifyTicketPriceV2Event.onCostChanged({
    required String cost,
  }) = _ModifyTicketPriceV2EventOnCostChanged;
  factory ModifyTicketPriceV2Event.onCurrencyChanged({
    required String currency,
  }) = _ModifyTicketPriceV2EventOnCurrencyChanged;
  factory ModifyTicketPriceV2Event.onPaymentAccountSelected({
    required List<String> paymentAccounts,
  }) = _ModifyTicketPriceV2EventOnPaymentAccountSelected;
  factory ModifyTicketPriceV2Event.populateTicketPrice() =
      _ModifyTicketPriceV2EventPopulateTicketPrice;
  factory ModifyTicketPriceV2Event.reset() = _ModifyTicketPriceV2EventReset;
}

@freezed
class ModifyTicketPriceV2State with _$ModifyTicketPriceV2State {
  factory ModifyTicketPriceV2State({
    String? cost,
    String? currency,
    List<String>? selectedPaymentAccounts,
    required bool isValid,
  }) = _ModifyTicketPriceV2State;
}
