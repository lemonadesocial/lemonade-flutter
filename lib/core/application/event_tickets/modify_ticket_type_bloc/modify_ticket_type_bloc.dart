import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_ticket_type_bloc.freezed.dart';

class ModifyTicketTypeBloc
    extends Bloc<ModifyTicketTypeEvent, ModifyTicketTypeState> {
  final EventTicketType? initialTicketType;
  ModifyTicketTypeBloc({
    this.initialTicketType,
  }) : super(
          ModifyTicketTypeState.initial(),
        ) {
    on<_ModifyTicketTypeEventOnTitleChanged>(_onTitleChanged);
    on<_ModifyTicketTypeEventOnDescriptionChanged>(_onDescriptionChanged);
    on<_ModifyTicketTypeEventOnGuestsLimitChanged>(_onGuestsLimitChanged);
    on<_ModifyTicketTypeEventOnTicketLimitPerChanged>(_onTicketLimitPerChanged);
    on<_ModifyTicketTypeEventOnActiveChanged>(_onActiveChanged);
    on<_ModifyTicketTypeEventOnPrivateChanged>(_onPrivateChanged);
    on<_ModifyTicketTypeEventOnLimitedChanged>(_onLimitedChanged);
    on<_ModifyTicketTypeEventOnPricesChanged>(_onPricesChanged);
    on<_ModifyTicketTypeEventOnDeletePrice>(_onDeletePrice);
    on<_ModifyTicketTypeEventOnMarkDefault>(_onMarkDefault);
    on<_ModifyTicketTypeEventOnWhitelistRemoved>(_onWhitelistRemoved);
    on<_ModifyTicketTypeEventOnWhitelistAdded>(_onWhitelistAdded);
    on<_ModifyTicketTypeEventOnWhitelistAddedModify>(_onWhitelistAddedModified);
    on<_ModifyTicketTypeEventOnCategoryChanged>(_onCategoryChanged);
    on<_ModifyTicketTypeEventOnValidate>(_onValidate);
    on<_ModifyTicketTypeEventPopulateTicketType>(_onPopulateTicketType);
    if (initialTicketType != null) {
      add(ModifyTicketTypeEvent.populateInitialTicketType());
    }
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

  void _onTicketLimitPerChanged(
    _ModifyTicketTypeEventOnTicketLimitPerChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      ticketLimitPer: event.ticketLimitPer,
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

  void _onPrivateChanged(
    _ModifyTicketTypeEventOnPrivateChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      private: event.private,
    );
    emit(_validate(newState));
  }

  void _onLimitedChanged(
    _ModifyTicketTypeEventOnLimitedChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      limited: event.limited,
    );
    emit(_validate(newState));
  }

  void _onPricesChanged(
    _ModifyTicketTypeEventOnPricesChanged event,
    Emitter emit,
  ) {
    final currentPrices = state.prices;
    List<TicketPriceInput> newPrices;
    if (event.index != null) {
      newPrices = currentPrices.asMap().entries.map((entry) {
        if (entry.key == event.index) {
          return event.ticketPrice;
        }
        return entry.value;
      }).toList();
    } else {
      newPrices = [...currentPrices, event.ticketPrice];
    }
    final newState = state.copyWith(
      prices: newPrices,
    );
    emit(_validate(newState));
  }

  void _onDeletePrice(
    _ModifyTicketTypeEventOnDeletePrice event,
    Emitter emit,
  ) {
    final newPrices = state.prices
        .asMap()
        .entries
        .where(
          (entry) => entry.key != event.index,
        )
        .map(
          (entry) => entry.value,
        )
        .toList();
    emit(
      _validate(
        state.copyWith(
          prices: newPrices,
        ),
      ),
    );
  }

  void _onMarkDefault(
    _ModifyTicketTypeEventOnMarkDefault event,
    Emitter emit,
  ) {
    final newPrices = state.prices.asMap().entries.map((entry) {
      if (entry.key == event.index) {
        return entry.value.copyWith(
          isDefault: true,
        );
      }
      return entry.value.copyWith(
        isDefault: false,
      );
    }).toList();

    emit(
      _validate(
        state.copyWith(
          prices: newPrices,
        ),
      ),
    );
  }

  void _onWhitelistAdded(
    _ModifyTicketTypeEventOnWhitelistAdded event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      addedWhitelistEmails: [...state.addedWhitelistEmails, ...event.emails],
    );
    emit(_validate(newState));
  }

  void _onWhitelistAddedModified(
    _ModifyTicketTypeEventOnWhitelistAddedModify event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      addedWhitelistEmails: event.emails,
    );
    emit(_validate(newState));
  }

  void _onWhitelistRemoved(
    _ModifyTicketTypeEventOnWhitelistRemoved event,
    Emitter emit,
  ) {
    final newRemovedWhitelist = [...state.removedWhitelistEmails, event.email];
    final newState = state.copyWith(
      removedWhitelistEmails: newRemovedWhitelist,
    );
    emit(_validate(newState));
  }

  void _onCategoryChanged(
    _ModifyTicketTypeEventOnCategoryChanged event,
    Emitter emit,
  ) {
    final newState = state.copyWith(
      category: event.category,
    );
    emit(_validate(newState));
  }

  void _onValidate(
    _ModifyTicketTypeEventOnValidate event,
    Emitter emit,
  ) {
    emit(_validate(state));
  }

  ModifyTicketTypeState _validate(ModifyTicketTypeState state) {
    final isValid = Formz.validate([
          state.title,
          state.description,
        ]) &&
        state.prices.isNotEmpty;

    return state.copyWith(isValid: isValid);
  }

  void _onPopulateTicketType(
    _ModifyTicketTypeEventPopulateTicketType event,
    Emitter emit,
  ) {
    if (initialTicketType == null) {
      return;
    }
    emit(
      _validate(
        ModifyTicketTypeState(
          title: StringFormz.pure(initialTicketType?.title ?? ''),
          description:
              OptionalStringFormz.pure(initialTicketType?.description ?? ''),
          limit: initialTicketType?.ticketLimit,
          ticketLimitPer: initialTicketType?.ticketLimitPer,
          active: initialTicketType?.active,
          private: initialTicketType?.private,
          limited: initialTicketType?.limited,
          prices: initialTicketType?.prices
                  ?.map(
                    (item) => TicketPriceInput(
                      currency: item.currency ?? '',
                      cost: item.cost ?? '0',
                      isDefault: item.isDefault,
                      // TODO: ticket setup
                      // paymentAccounts: []
                    ),
                  )
                  .toList() ??
              [],
          addedWhitelistEmails: [],
          removedWhitelistEmails: [],
          category: initialTicketType?.category,
          isValid: false,
        ),
      ),
    );
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
  factory ModifyTicketTypeEvent.onTicketLimitPerChanged({
    double? ticketLimitPer,
  }) = _ModifyTicketTypeEventOnTicketLimitPerChanged;
  factory ModifyTicketTypeEvent.onActiveChanged({
    bool? active,
  }) = _ModifyTicketTypeEventOnActiveChanged;
  factory ModifyTicketTypeEvent.onPrivateChanged({
    bool? private,
  }) = _ModifyTicketTypeEventOnPrivateChanged;
  factory ModifyTicketTypeEvent.onLimitedChanged({
    bool? limited,
  }) = _ModifyTicketTypeEventOnLimitedChanged;
  factory ModifyTicketTypeEvent.onWhitelistRemoved({
    required String email,
  }) = _ModifyTicketTypeEventOnWhitelistRemoved;
  factory ModifyTicketTypeEvent.onWhitelistAdded({
    required List<String> emails,
  }) = _ModifyTicketTypeEventOnWhitelistAdded;
  factory ModifyTicketTypeEvent.onWhitelistAddedModified({
    required List<String> emails,
  }) = _ModifyTicketTypeEventOnWhitelistAddedModify;
  factory ModifyTicketTypeEvent.onPricesChanged({
    required TicketPriceInput ticketPrice,
    int? index,
  }) = _ModifyTicketTypeEventOnPricesChanged;
  factory ModifyTicketTypeEvent.onDeletePrice({
    required int index,
  }) = _ModifyTicketTypeEventOnDeletePrice;
  factory ModifyTicketTypeEvent.onMarkDefault({
    required int index,
  }) = _ModifyTicketTypeEventOnMarkDefault;
  factory ModifyTicketTypeEvent.onCategoryChanged({
    String? category,
  }) = _ModifyTicketTypeEventOnCategoryChanged;
  factory ModifyTicketTypeEvent.onValidate() = _ModifyTicketTypeEventOnValidate;
  factory ModifyTicketTypeEvent.populateInitialTicketType() =
      _ModifyTicketTypeEventPopulateTicketType;
}

@freezed
class ModifyTicketTypeState with _$ModifyTicketTypeState {
  factory ModifyTicketTypeState({
    required StringFormz title,
    required OptionalStringFormz description,
    double? ticketLimitPer,
    double? limit,
    bool? active,
    bool? private,
    bool? limited,
    required List<String> removedWhitelistEmails,
    required List<String> addedWhitelistEmails,
    required List<TicketPriceInput> prices,
    required bool isValid,
    String? category,
  }) = _ModifyTicketTypeState;

  factory ModifyTicketTypeState.initial() => ModifyTicketTypeState(
        title: const StringFormz.pure(),
        description: const OptionalStringFormz.pure(),
        ticketLimitPer: 1,
        limit: null,
        active: true,
        private: false,
        limited: false,
        prices: [],
        isValid: false,
        removedWhitelistEmails: [],
        addedWhitelistEmails: [],
        category: null,
      );
}
