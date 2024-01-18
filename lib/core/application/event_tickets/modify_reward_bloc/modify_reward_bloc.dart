import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_reward_bloc.freezed.dart';

class ModifyRewardBloc extends Bloc<ModifyRewardEvent, ModifyRewardState> {
  ModifyRewardBloc() : super(ModifyRewardState.initial()) {
    on<_ModifyRewardEventOnTitleChanged>(_onTitleChanged);
    on<_ModifyRewardEventOnIconChanged>(_onIconChanged);
    on<_ModifyRewardEventOnLimitPerChanged>(_onLimitPerChanged);
    on<_ModifyRewardEventOnToggleSelectAll>(
      _onToggleSelectAll,
    );
    on<_ModifyRewardEventOnSelectTicketTier>(
      _onSelectEventTicketType,
    );
    on<_ModifyRewardEventOnValidate>(_onValidate);
  }

  void _onTitleChanged(
    _ModifyRewardEventOnTitleChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      title: StringFormz.dirty(event.title),
    );
    emit(_validate(newState));
  }

  void _onIconChanged(
    _ModifyRewardEventOnIconChanged event,
    Emitter emit,
  ) {}

  void _onLimitPerChanged(
    _ModifyRewardEventOnLimitPerChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      limitPer: event.limitPer,
    );
    emit(_validate(newState));
  }

  void _onToggleSelectAll(
    _ModifyRewardEventOnToggleSelectAll event,
    Emitter emit,
  ) {
    List<String> eventTicketTypesIds =
        event.eventTicketTypes.map((obj) => obj.id ?? '').toList();
    if (event.value == true) {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: eventTicketTypesIds,
      );
      emit(_validate(newState));
    } else {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: [],
      );
      emit(_validate(newState));
    }
  }

  void _onSelectEventTicketType(
    _ModifyRewardEventOnSelectTicketTier event,
    Emitter emit,
  ) {
    if (state.selectedEventTicketTypeIds.contains(event.eventTicketTypeId)) {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: state.selectedEventTicketTypeIds
            .where((id) => id != event.eventTicketTypeId)
            .toList(),
      );
      emit(_validate(newState));
    } else {
      final newState = state.copyWith(
        selectedEventTicketTypeIds: [
          ...state.selectedEventTicketTypeIds,
          event.eventTicketTypeId ?? '',
        ],
      );
      emit(_validate(newState));
    }
  }

  void _onValidate(
    _ModifyRewardEventOnValidate event,
    Emitter emit,
  ) {
    emit(_validate(state));
  }

  ModifyRewardState _validate(ModifyRewardState state) {
    final isValid = Formz.validate([
          state.title,
        ]) &&
        state.selectedEventTicketTypeIds.isNotEmpty;
    return state.copyWith(isValid: isValid);
  }
}

@freezed
class ModifyRewardEvent with _$ModifyRewardEvent {
  factory ModifyRewardEvent.onTitleChanged({
    required String title,
  }) = _ModifyRewardEventOnTitleChanged;
  factory ModifyRewardEvent.onIconChanged({
    required String cost,
  }) = _ModifyRewardEventOnIconChanged;
  factory ModifyRewardEvent.onLimitPerChanged({
    required double? limitPer,
  }) = _ModifyRewardEventOnLimitPerChanged;
  factory ModifyRewardEvent.onToggleSelectAll({
    required bool value,
    required List<EventTicketType> eventTicketTypes,
  }) = _ModifyRewardEventOnToggleSelectAll;
  factory ModifyRewardEvent.onSelectEventTicketType({
    required String? eventTicketTypeId,
  }) = _ModifyRewardEventOnSelectTicketTier;
  factory ModifyRewardEvent.onValidate() = _ModifyRewardEventOnValidate;
}

@freezed
class ModifyRewardState with _$ModifyRewardState {
  factory ModifyRewardState({
    required StringFormz title,
    String? iconUrl,
    double? limitPer,
    required List<String> selectedEventTicketTypeIds,
    required bool isValid,
  }) = _ModifyRewardState;

  factory ModifyRewardState.initial() => ModifyRewardState(
        title: const StringFormz.pure(),
        limitPer: 1,
        iconUrl: null,
        selectedEventTicketTypeIds: [],
        isValid: false,
      );
}
