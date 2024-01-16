import 'dart:math';

import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_ticket_price_bloc.freezed.dart';

class ModifyTicketPriceBloc
    extends Bloc<ModifyTicketPriceEvent, ModifyTicketPriceState> {
  ModifyTicketPriceBloc() : super(ModifyTicketPriceState.initial()) {
    on<_ModifyTicketPriceEventOnCostChanged>(_onCostChanged);
    on<_ModifyTicketPriceEventOnCurrencyChanged>(_onCurrencyChanged);
    on<_ModifyTicketPriceEventOnNetworkChanged>(_onNetworkChanged);
  }

  void _onCostChanged(
    _ModifyTicketPriceEventOnCostChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(cost: event.cost);
    emit(_validate(newState));
  }

  void _onCurrencyChanged(
    _ModifyTicketPriceEventOnCurrencyChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(currency: event.currency);
    emit(_validate(newState));
  }

  void _onNetworkChanged(
    _ModifyTicketPriceEventOnNetworkChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(network: event.network);
    emit(_validate(newState));
  }

  ModifyTicketPriceState _validate(ModifyTicketPriceState state) {
    return state.copyWith(
      isValid:
          state.cost?.isNotEmpty == true && state.currency?.isNotEmpty == true,
    );
  }

  TicketPriceInput? getResult(
    ModifyTicketPriceState state, {
    required int decimals,
  }) {
    if (!state.isValid) return null;
    String transformedCost = '0';
    // if erc20 pricing
    if (state.network != null) {
      transformedCost =
          BigInt.from(double.parse(state.cost!) * pow(10, decimals)).toString();
    } else {
      transformedCost =
          (double.parse(state.cost!) * pow(10, decimals)).toInt().toString();
    }
    return TicketPriceInput(
      currency: state.currency ?? '',
      cost: transformedCost,
      network: state.network?.chainId ?? '',
    );
  }
}

@freezed
class ModifyTicketPriceEvent with _$ModifyTicketPriceEvent {
  factory ModifyTicketPriceEvent.onCostChanged({
    required String cost,
  }) = _ModifyTicketPriceEventOnCostChanged;
  factory ModifyTicketPriceEvent.onCurrencyChanged({
    required String currency,
  }) = _ModifyTicketPriceEventOnCurrencyChanged;
  factory ModifyTicketPriceEvent.onNetworkChanged({
    required Chain network,
  }) = _ModifyTicketPriceEventOnNetworkChanged;
}

@freezed
class ModifyTicketPriceState with _$ModifyTicketPriceState {
  factory ModifyTicketPriceState({
    String? cost,
    String? currency,
    Chain? network,
    required bool isValid,
  }) = _ModifyTicketPriceState;

  factory ModifyTicketPriceState.initial() => ModifyTicketPriceState(
        isValid: false,
      );
}
