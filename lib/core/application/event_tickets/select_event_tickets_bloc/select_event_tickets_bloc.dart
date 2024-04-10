import 'package:app/core/domain/event/entities/event_ticket_category.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'select_event_tickets_bloc.freezed.dart';

enum SelectTicketsPaymentMethod {
  card,
  wallet,
}

class SelectEventTicketsBloc
    extends Bloc<SelectEventTicketsEvent, SelectEventTicketsState> {
  EventTicketTypesResponse? eventTicketTypesResponse;
  String? selectedCurrency;
  // only for SelectTicketsPaymentMethod.wallet
  String? selectedNetwork;
  EventTicketCategory? selectedTicketCategory;

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
    on<SelectEventTicketsEventOnSelectTicketCategory>(_onSelectTicketCategory);
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

  void _onSelectTicketCategory(
    SelectEventTicketsEventOnSelectTicketCategory event,
    Emitter emit,
  ) {
    selectedTicketCategory = event.category;
    emit(
      state.copyWith(
        selectedTickets: [],
        isSelectionValid: false,
        selectedTicketCategory: selectedTicketCategory,
        isPaymentRequired: false,
        selectedCurrency: null,
        selectedNetwork: null,
        totalAmount: null,
      ),
    );
  }

  Future<void> _onSelectTicketType(
    SelectEventTicketsEventOnSelectTicket event,
    Emitter emit,
  ) async {
    selectedCurrency = event.currency;
    selectedNetwork = event.network;
    bool isCryptoCurrency = selectedNetwork?.isNotEmpty == true;

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

    Either<double, BigInt> totalAmount = isCryptoCurrency
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
    return totalSelectedCount > 0 && selectedCurrency != null;
  }

  double _calculateFiatTotalAmount(
    List<PurchasableItem> selectedTickets,
  ) {
    return selectedTickets.fold(0.0, (total, currentItem) {
      final ticketType = (eventTicketTypesResponse?.ticketTypes ?? [])
          .firstWhereOrNull((element) => element.id == currentItem.id);
      final ticketTypePrice =
          EventTicketUtils.getTicketPriceByCurrencyAndNetwork(
                ticketType: ticketType,
                currency: selectedCurrency,
              )?.fiatCost ??
              0;

      final amountPerTicketType = ticketTypePrice * currentItem.count;

      return total + amountPerTicketType;
    });
  }

  BigInt _calculateBlockchainTotalAmount(
    List<PurchasableItem> selectedTickets,
  ) {
    return selectedTickets.fold(BigInt.from(0), (total, currentItem) {
      final ticketType = (eventTicketTypesResponse?.ticketTypes ?? [])
          .firstWhereOrNull((element) => element.id == currentItem.id);
      final ticketTypePrice =
          EventTicketUtils.getTicketPriceByCurrencyAndNetwork(
                ticketType: ticketType,
                currency: selectedCurrency,
                network: selectedNetwork,
              )?.cryptoCost ??
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
    required String currency,
    String? network,
  }) = SelectEventTicketsEventOnSelectTicket;
  factory SelectEventTicketsEvent.selectCurrency({
    required String currency,
  }) = SelectEventTicketsEventOnSelectCurrency;
  factory SelectEventTicketsEvent.selectPaymentMethod({
    required SelectTicketsPaymentMethod paymentMethod,
  }) = SelectEventTicketsEventOnSelectPaymentMethod;
  factory SelectEventTicketsEvent.selectTicketCategory({
    EventTicketCategory? category,
  }) = SelectEventTicketsEventOnSelectTicketCategory;
  factory SelectEventTicketsEvent.clear() = SelectEventTicketsEventOnClear;
}

@freezed
class SelectEventTicketsState with _$SelectEventTicketsState {
  factory SelectEventTicketsState({
    required List<PurchasableItem> selectedTickets,
    required bool isSelectionValid,
    required bool isPaymentRequired,
    required SelectTicketsPaymentMethod paymentMethod,
    String? selectedCurrency,
    Either<double, BigInt>? totalAmount,
    String? selectedNetwork,
    EventTicketCategory? selectedTicketCategory,
  }) = _SelectEventTicketsState;
}
