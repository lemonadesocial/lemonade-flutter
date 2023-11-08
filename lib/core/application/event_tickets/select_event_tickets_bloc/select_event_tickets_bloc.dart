import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_event_tickets_bloc.freezed.dart';

class SelectEventTicketTypesBloc
    extends Bloc<SelectEventTicketTypesEvent, SelectEventTicketTypesState> {
  EventTicketTypesResponse? eventTicketTypesResponse;
  Currency? selectedCurrency;

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
    SelectEventTicketTypesEventOnSelectTicketType event,
    Emitter emit,
  ) async {
    final newSelectedTicketTypes = [
      event.ticketType,
      ...state.selectedTicketTypes,
    ].unique((item) => item.id);

    final totalSelectedCount =
        _calculateTotalSelectedCount(newSelectedTicketTypes);

    Either<double, BigInt> totalAmount =
        PaymentUtils.isBlockchainCurrency(selectedCurrency!)
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
              ?.blockchainCost ??
          '0';
      final ticketTypePriceInBigInt =
          BigInt.tryParse(ticketTypePrice) ?? BigInt.from(0);

      final amountPerTicketType =
          ticketTypePriceInBigInt * BigInt.from(currentItem.count);

      return total + amountPerTicketType;
    });
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
