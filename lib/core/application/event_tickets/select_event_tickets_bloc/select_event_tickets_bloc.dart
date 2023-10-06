import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_event_tickets_bloc.freezed.dart';

class SelectEventTicketTypesBloc
    extends Bloc<SelectEventTicketTypesEvent, SelectEventTicketTypesState> {
  EventTicketTypesResponse? eventTicketTypesResponse;
  double totalSelectedCount = 0;

  SelectEventTicketTypesBloc()
      : super(
          SelectEventTicketTypesState(
            selectedTicketTypes: [],
            isSelectionValid: false,
          ),
        ) {
    on<SelectEventTicketTypesEventOnListTicketTypesLoaded>((event, emit) {
      eventTicketTypesResponse = event.eventTicketTypesResponse;
    });
    on<SelectEventTicketTypesEventOnSelectTicketType>(_onSelectTicketType);
  }

  Future<void> _onSelectTicketType(
    SelectEventTicketTypesEventOnSelectTicketType event,
    Emitter emit,
  ) async {
    final newSelectedTicketTypes = [
      event.ticketType,
      ...state.selectedTicketTypes
    ].unique((item) => item.id);
    totalSelectedCount = _calculateTotalSelectedCount(newSelectedTicketTypes);
    emit(
      state.copyWith(
        selectedTicketTypes: newSelectedTicketTypes,
        isSelectionValid: _validateTotalSelectedCount(),
      ),
    );
  }

  double _calculateTotalSelectedCount(
    List<PurchasableItem> selectedTicketTypes,
  ) {
    return selectedTicketTypes.fold(
      0.0,
      (total, currentItem) => total + currentItem.count,
    );
  }

  bool _validateTotalSelectedCount() {
    return totalSelectedCount <= (eventTicketTypesResponse?.limit ?? 1) &&
        totalSelectedCount > 0;
  }
}

@freezed
class SelectEventTicketTypesEvent with _$SelectEventTicketTypesEvent {
  factory SelectEventTicketTypesEvent.onEventTicketTypesResponseLoaded({
    required EventTicketTypesResponse eventTicketTypesResponse,
  }) = SelectEventTicketTypesEventOnListTicketTypesLoaded;

  factory SelectEventTicketTypesEvent.select({
    required PurchasableItem ticketType,
  }) = SelectEventTicketTypesEventOnSelectTicketType;
}

@freezed
class SelectEventTicketTypesState with _$SelectEventTicketTypesState {
  factory SelectEventTicketTypesState({
    required List<PurchasableItem> selectedTicketTypes,
    required bool isSelectionValid,
  }) = _SelectEventTicketTypesState;
}
