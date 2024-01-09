import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_ticket_type_bloc.freezed.dart';

class ModifyTicketTypeBloc
    extends Bloc<ModifyTicketTypeEvent, ModifyTicketTypeState> {
  ModifyTicketTypeBloc()
      : super(
          ModifyTicketTypeState.initial(),
        ) {
    on<_ModifyTicketTypeEventOnTitleChanged>(_onTitleChanged);
    on<_ModifyTicketTypeEventOnDescriptionChanged>(_onDescriptionChanged);
    on<_ModifyTicketTypeEventOnGuestsLimitChanged>(_onGuestsLimitChanged);
    on<_ModifyTicketTypeEventOnActiveChanged>(_onActiveChanged);
    on<_ModifyTicketTypeEventOnPricesChanged>(_onPricesChanged);
  }

  void _onTitleChanged(
    _ModifyTicketTypeEventOnTitleChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      title: StringFormz.dirty(event.title),
    );
    emit(_validate(newState));
  }

  void _onDescriptionChanged(
    _ModifyTicketTypeEventOnDescriptionChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      description: OptionalStringFormz.dirty(event.description),
    );
    emit(_validate(newState));
  }

  void _onGuestsLimitChanged(
    _ModifyTicketTypeEventOnGuestsLimitChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      limit: event.limit,
    );
    emit(_validate(newState));
  }

  void _onActiveChanged(
    _ModifyTicketTypeEventOnActiveChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      active: event.active,
    );
    emit(_validate(newState));
  }

  void _onPricesChanged(
    _ModifyTicketTypeEventOnPricesChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      prices: event.prices,
    );
    emit(_validate(newState));
  }

  ModifyTicketTypeState _validate(ModifyTicketTypeState state) {
    final isValid = Formz.validate([
          state.title,
          state.description,
        ]) &&
        state.prices.isNotEmpty;

    return state.copyWith(isValid: isValid);
  }
}

@freezed
class ModifyTicketTypeEvent with _$ModifyTicketTypeEvent {
  factory ModifyTicketTypeEvent.onTitleChanged({
    required String title,
  }) = _ModifyTicketTypeEventOnTitleChanged;
  factory ModifyTicketTypeEvent.onDescriptionChanged({
    required String description,
  }) = _ModifyTicketTypeEventOnDescriptionChanged;
  factory ModifyTicketTypeEvent.onGuestsLimitChanged({
    double? limit,
  }) = _ModifyTicketTypeEventOnGuestsLimitChanged;
  factory ModifyTicketTypeEvent.onActiveChanged({
    bool? active,
  }) = _ModifyTicketTypeEventOnActiveChanged;
  factory ModifyTicketTypeEvent.onPricesChanged({
    required List<TicketPriceInput> prices,
  }) = _ModifyTicketTypeEventOnPricesChanged;
}

@freezed
class ModifyTicketTypeState with _$ModifyTicketTypeState {
  factory ModifyTicketTypeState({
    required StringFormz title,
    required OptionalStringFormz description,
    double? limit,
    bool? active,
    required List<TicketPriceInput> prices,
    required bool isValid,
  }) = _ModifyTicketTypeState;

  factory ModifyTicketTypeState.initial() => ModifyTicketTypeState(
        title: const StringFormz.pure(),
        description: const OptionalStringFormz.pure(),
        limit: null,
        active: null,
        prices: [],
        isValid: false,
      );
}
