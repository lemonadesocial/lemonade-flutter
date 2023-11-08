import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_event_tickets_bloc.freezed.dart';

class SelectEventTicketTypesBloc
    extends Bloc<SelectEventTicketTypesEvent, SelectEventTicketTypesState> {
  EventTicketTypesResponse? eventTicketTypesResponse;
  double totalSelectedCount = 0;
  double totalAmount = 0;
  // TODO: selected currency
  // In the future, user will select currency to pay
  // have to do the filter out ticket types which support the currency in GetEventTicketTypesBloc
  // Temporary set USD for currency
  Currency? currency;

  SelectEventTicketTypesBloc()
      : super(
          SelectEventTicketTypesState(
            selectedTicketTypes: [],
            isSelectionValid: false,
            isPaymentRequired: false,
          ),
        ) {
    on<SelectEventTicketTypesEventOnListTicketTypesLoaded>((event, emit) {
      eventTicketTypesResponse = event.eventTicketTypesResponse;
    });
    on<SelectEventTicketTypesEventOnSelectTicketType>(_onSelectTicketType);
    // TODO:
    on<SelectEventTicketTypesEventOnSelectCurrency>(_onSelectCurrency);
  }

  void _onSelectCurrency(
    SelectEventTicketTypesEventOnSelectCurrency event,
    Emitter emit,
  ) {
    currency = event.currency;
    emit(state.copyWith(selectedCurrency: currency));
  }

  Future<void> _onSelectTicketType(
    SelectEventTicketTypesEventOnSelectTicketType event,
    Emitter emit,
  ) async {
    final newSelectedTicketTypes = [
      event.ticketType,
      ...state.selectedTicketTypes,
    ].unique((item) => item.id);

    totalSelectedCount = _calculateTotalSelectedCount(newSelectedTicketTypes);
    totalAmount = _calculateTotalAmount(newSelectedTicketTypes);

    emit(
      state.copyWith(
        selectedTicketTypes: newSelectedTicketTypes,
        isSelectionValid: _validateTotalSelectedCount(),
        isPaymentRequired: totalAmount > 0,
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

  double _calculateTotalAmount(
    List<PurchasableItem> selectedTicketTypes,
  ) {
    return selectedTicketTypes.fold(0.0, (total, currentItem) {
      final ticketTypePrice = (eventTicketTypesResponse?.ticketTypes ?? [])
              .firstWhere((element) => element.id == currentItem.id)
              .defaultPrice
              ?.fiatCost ??
          0;
      final amountPerTicketType = ticketTypePrice * currentItem.count;

      return total + amountPerTicketType;
    });
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
  factory SelectEventTicketTypesEvent.selectCurrency({
    required Currency currency,
  }) = SelectEventTicketTypesEventOnSelectCurrency;
}

@freezed
class SelectEventTicketTypesState with _$SelectEventTicketTypesState {
  factory SelectEventTicketTypesState({
    required List<PurchasableItem> selectedTicketTypes,
    Currency? selectedCurrency,
    required bool isSelectionValid,
    required bool isPaymentRequired,
  }) = _SelectEventTicketTypesState;
}
