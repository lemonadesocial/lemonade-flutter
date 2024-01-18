import 'dart:math';

import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_reward_bloc.freezed.dart';

class ModifyRewardBloc extends Bloc<ModifyRewardEvent, ModifyRewardState> {
  ModifyRewardBloc() : super(ModifyRewardState.initial()) {
    on<_ModifyRewardEventOnIconChanged>(_onIconChanged);
  }

  void _onIconChanged(
    _ModifyRewardEventOnIconChanged event,
    Emitter emit,
  ) {
    // final newState = state.copyWith(cost: event.cost);
    // emit(_validate(newState));
  }
}

@freezed
class ModifyRewardEvent with _$ModifyRewardEvent {
  factory ModifyRewardEvent.onCostChanged({
    required String cost,
  }) = _ModifyRewardEventOnIconChanged;
}

@freezed
class ModifyRewardState with _$ModifyRewardState {
  factory ModifyRewardState({
    String? iconUrl,
    required bool isValid,
  }) = _ModifyRewardState;

  factory ModifyRewardState.initial() => ModifyRewardState(
        isValid: false,
      );
}
