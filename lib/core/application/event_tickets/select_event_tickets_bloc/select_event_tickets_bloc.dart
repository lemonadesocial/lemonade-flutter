import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_event_tickets_bloc.freezed.dart';

enum SelectTicketsPaymentMethod {
  card,
  wallet,
}

class SelectEventTicketsBloc
    extends Bloc<SelectEventTicketsEvent, SelectEventTicketsState> {
  EventTicketTypesResponse? eventTicketTypesResponse;
  Currency? selectedCurrency;
  // only for SelectTicketsPaymentMethod.wallet
  SupportedPaymentNetwork? selectedNetwork;

  SelectEventTicketsBloc()
      : super(
          SelectEventTicketsState(
            selectedTickets: [],
            isSelectionValid: false,
            isPaymentRequired: false,
            paymentMethod: SelectTicketsPaymentMethod.card,
            selectedCurrency: null,
            selectedNetwork: null,
            totalAmount: null,
          ),
        ) {
    on<SelectEventTicketsEventOnListTicketTypesLoaded>((event, emit) {
      eventTicketTypesResponse = event.eventTicketTypesResponse;
    });
    on<SelectEventTicketsEventOnSelectTicket>(_onSelectTicketType);
    // TODO:
    on<SelectEventTicketsEventOnSelectCurrency>(_onSelectCurrency);
    on<SelectEventTicketsEventOnSelectPaymentMethod>(_onSelectPaymentMethod);
    on<SelectEventTicketsEventOnClear>(_onClear);
  }

  void _onClear(SelectEventTicketsEventOnClear event, Emitter emit) {
    emit(
      state.copyWith(
        selectedTickets: [],
        isSelectionValid: false,
        isPaymentRequired: false,
        selectedCurrency: null,
        selectedNetwork: null,
        totalAmount: null,
      ),
    );
  }

  void _onSelectPaymentMethod(
    SelectEventTicketsEventOnSelectPaymentMethod event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(
        paymentMethod: event.paymentMethod,
        selectedTickets: [],
        isSelectionValid: false,
        isPaymentRequired: false,
        selectedCurrency: null,
        selectedNetwork: null,
        totalAmount: null,
      ),
    );
  }

  void _onSelectCurrency(
    SelectEventTicketsEventOnSelectCurrency event,
    Emitter emit,
  ) {
    selectedCurrency = event.currency;

    emit(
      state.copyWith(
        selectedCurrency: selectedCurrency,
        selectedTickets: [],
        isSelectionValid: false,
      ),
    );
  }

  Future<void> _onSelectTicketType(
    SelectEventTicketsEventOnSelectTicket event,
    Emitter emit,
  ) async {
    selectedCurrency = event.currency;
    selectedNetwork = event.network;

    final newSelectedTickets = [
      event.ticket,
      ...state.selectedTickets,
    ].unique((item) => item.id).where((element) => element.count > 0).toList();

    if (newSelectedTickets.isEmpty) {
      // when tickets empty meaning all tickets with same currency and network has been deselected
      // so just reset
      add(SelectEventTicketsEvent.clear());
      return;
    }

    final totalSelectedCount = _calculateTotalSelectedCount(newSelectedTickets);

    Either<double, BigInt> totalAmount =
        PaymentUtils.isCryptoCurrency(selectedCurrency!)
            ? Right(_calculateBlockchainTotalAmount(newSelectedTickets))
            : Left(_calculateFiatTotalAmount(newSelectedTickets));

    emit(
      state.copyWith(
        selectedTickets: newSelectedTickets,
        isSelectionValid: _validateTotalSelectedCount(totalSelectedCount),
        isPaymentRequired: totalAmount.fold((totalFiat) {
          return totalFiat > 0;
        }, (totalBlockchain) {
          return totalBlockchain > BigInt.zero;
        }),
        selectedCurrency: selectedCurrency,
        selectedNetwork: selectedNetwork,
        totalAmount: totalAmount,
      ),
    );
  }

  double _calculateTotalSelectedCount(
    List<PurchasableItem> selectedTickets,
  ) {
    return selectedTickets.fold(
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
    List<PurchasableItem> selectedTickets,
  ) {
    return selectedTickets.fold(0.0, (total, currentItem) {
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
    List<PurchasableItem> selectedTickets,
  ) {
    return selectedTickets.fold(BigInt.from(0), (total, currentItem) {
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
    required PurchasableItem ticket,
    required Currency currency,
    SupportedPaymentNetwork? network,
  }) = SelectEventTicketsEventOnSelectTicket;
  factory SelectEventTicketsEvent.selectCurrency({
    required Currency currency,
  }) = SelectEventTicketsEventOnSelectCurrency;
  factory SelectEventTicketsEvent.selectPaymentMethod({
    required SelectTicketsPaymentMethod paymentMethod,
  }) = SelectEventTicketsEventOnSelectPaymentMethod;
  factory SelectEventTicketsEvent.clear() = SelectEventTicketsEventOnClear;
}

@freezed
class SelectEventTicketsState with _$SelectEventTicketsState {
  factory SelectEventTicketsState({
    required List<PurchasableItem> selectedTickets,
    required bool isSelectionValid,
    required bool isPaymentRequired,
    required SelectTicketsPaymentMethod paymentMethod,
    Currency? selectedCurrency,
    Either<double, BigInt>? totalAmount,
    SupportedPaymentNetwork? selectedNetwork,
  }) = _SelectEventTicketsState;
}
