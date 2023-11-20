import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_event_tickets_bloc.freezed.dart';

class SelectEventTicketsBloc
    extends Bloc<SelectEventTicketsEvent, SelectEventTicketsState> {
  EventTicketTypesResponse? eventTicketTypesResponse;
  Currency? selectedCurrency;

  SelectEventTicketsBloc()
      : super(
          SelectEventTicketsState(
            selectedTicketTypes: [],
            isSelectionValid: false,
            isPaymentRequired: false,
          ),
        ) {
    on<SelectEventTicketsEventOnListTicketTypesLoaded>((event, emit) {
      eventTicketTypesResponse = event.eventTicketTypesResponse;
    });
    on<SelectEventTicketsEventOnSelectTicket>(_onSelectTicketType);
    // TODO:
    on<SelectEventTicketsEventOnSelectCurrency>(_onSelectCurrency);
  }

  void _onSelectCurrency(
    SelectEventTicketsEventOnSelectCurrency event,
    Emitter emit,
  ) {
    selectedCurrency = event.currency;

    emit(
      state.copyWith(
        selectedCurrency: selectedCurrency,
        selectedTicketTypes: [],
        isSelectionValid: false,
      ),
    );
  }

  Future<void> _onSelectTicketType(
    SelectEventTicketsEventOnSelectTicket event,
    Emitter emit,
  ) async {
    final newSelectedTicketTypes = [
      event.ticketType,
      ...state.selectedTicketTypes,
    ].unique((item) => item.id).where((element) => element.count > 0).toList();

    final totalSelectedCount =
        _calculateTotalSelectedCount(newSelectedTicketTypes);

    Either<double, BigInt> totalAmount =
        PaymentUtils.isCryptoCurrency(selectedCurrency!)
            ? Right(_calculateBlockchainTotalAmount(newSelectedTicketTypes))
            : Left(_calculateFiatTotalAmount(newSelectedTicketTypes));

    emit(
      state.copyWith(
        selectedTicketTypes: newSelectedTicketTypes,
        isSelectionValid: _validateTotalSelectedCount(totalSelectedCount),
        isPaymentRequired: totalAmount.fold((totalFiat) {
          return totalFiat > 0;
        }, (totalBlockchain) {
          return totalBlockchain > BigInt.zero;
        }),
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

  bool _validateTotalSelectedCount(totalSelectedCount) {
    // TODO: handle notify if over the limit
    return totalSelectedCount <= (eventTicketTypesResponse?.limit ?? 1) &&
        totalSelectedCount > 0 &&
        selectedCurrency != null;
  }

  double _calculateFiatTotalAmount(
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

  BigInt _calculateBlockchainTotalAmount(
    List<PurchasableItem> selectedTicketTypes,
  ) {
    return selectedTicketTypes.fold(BigInt.from(0), (total, currentItem) {
      final ticketTypePrice = (eventTicketTypesResponse?.ticketTypes ?? [])
              .firstWhere((element) => element.id == currentItem.id)
              .prices?[selectedCurrency]
              ?.cryptoCost ??
          BigInt.zero;

      final amountPerTicketType =
          ticketTypePrice * BigInt.from(currentItem.count);

      return total + amountPerTicketType;
    });
  }
}

@freezed
class SelectEventTicketsEvent with _$SelectEventTicketsEvent {
  factory SelectEventTicketsEvent.onEventTicketTypesResponseLoaded({
    required EventTicketTypesResponse eventTicketTypesResponse,
  }) = SelectEventTicketsEventOnListTicketTypesLoaded;

  factory SelectEventTicketsEvent.select({
    required PurchasableItem ticketType,
  }) = SelectEventTicketsEventOnSelectTicket;
  factory SelectEventTicketsEvent.selectCurrency({
    required Currency currency,
  }) = SelectEventTicketsEventOnSelectCurrency;
}

@freezed
class SelectEventTicketsState with _$SelectEventTicketsState {
  factory SelectEventTicketsState({
    required List<PurchasableItem> selectedTicketTypes,
    Currency? selectedCurrency,
    required bool isSelectionValid,
    required bool isPaymentRequired,
  }) = _SelectEventTicketsState;
}
