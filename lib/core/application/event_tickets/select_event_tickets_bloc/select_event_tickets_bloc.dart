import 'package:app/core/domain/event/entities/event_ticket_category.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/payment_utils.dart';
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
            commonPaymentAccounts: [],
            paymentMethod: SelectTicketsPaymentMethod.card,
            selectedCurrency: null,
            totalAmount: null,
          ),
        ) {
    on<SelectEventTicketsEventOnListTicketTypesLoaded>((event, emit) {
      eventTicketTypesResponse = event.eventTicketTypesResponse;
    });
    on<SelectEventTicketsEventOnSelectTicket>(_onSelectTicketType);
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
        commonPaymentAccounts: [],
        selectedCurrency: null,
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
        commonPaymentAccounts: [],
        selectedCurrency: null,
        totalAmount: null,
      ),
    );
  }

  void _onSelectTicketCategory(
    SelectEventTicketsEventOnSelectTicketCategory event,
    Emitter emit,
  ) {
    selectedTicketCategory = event.category;
    final newState = state.copyWith(
      selectedTicketCategory: selectedTicketCategory,
    );
    emit(newState);
  }

  Future<void> _onSelectTicketType(
    SelectEventTicketsEventOnSelectTicket event,
    Emitter emit,
  ) async {
    final ticketPrice = event.price;
    selectedCurrency = event.currency;
    // TODO: will remove
    // selectedNetwork = event.network;
    bool isCryptoCurrency = ticketPrice?.isCrypto == true;

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

    List<PaymentAccount> newCommonPaymentAccounts = [];

    if (isCryptoCurrency) {
      newCommonPaymentAccounts =
          ticketPrice?.paymentAccountsExpanded?.isEmpty == true
              ? state.commonPaymentAccounts
              : ticketPrice?.paymentAccountsExpanded ??
                  state.commonPaymentAccounts;
    }

    if (!isCryptoCurrency) {
      if (newSelectedTickets.isEmpty) {
        // Reset when no tickets are selected
        newCommonPaymentAccounts = [];
      } else if (newSelectedTickets.length == 1) {
        // When only one ticket type remains, use all its payment accounts
        final ticketType =
            eventTicketTypesResponse?.ticketTypes?.firstWhereOrNull(
          (element) => element.id == newSelectedTickets.first.id,
        );
        newCommonPaymentAccounts =
            EventTicketUtils.getTicketPriceByCurrencyAndNetwork(
                  ticketType: ticketType,
                  currency: selectedCurrency,
                )?.paymentAccountsExpanded ??
                [];
      } else {
        // For multiple tickets, find common payment accounts across all selected tickets
        newCommonPaymentAccounts = newSelectedTickets
                .fold<List<PaymentAccount>?>(null, (previousAccounts, ticket) {
              final ticketType = eventTicketTypesResponse?.ticketTypes
                  ?.firstWhereOrNull((element) => element.id == ticket.id);
              final ticketAccounts =
                  EventTicketUtils.getTicketPriceByCurrencyAndNetwork(
                        ticketType: ticketType,
                        currency: selectedCurrency,
                      )?.paymentAccountsExpanded ??
                      [];

              if (previousAccounts == null) return ticketAccounts;
              return PaymentUtils.getCommonPaymentAccounts(
                accounts1: previousAccounts,
                accounts2: ticketAccounts,
              );
            }) ??
            [];
      }
    }

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
        commonPaymentAccounts: newCommonPaymentAccounts,
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
    EventTicketPrice? price,
  }) = SelectEventTicketsEventOnSelectTicket;
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
    required List<PaymentAccount> commonPaymentAccounts,
    String? selectedCurrency,
    Either<double, BigInt>? totalAmount,
    EventTicketCategory? selectedTicketCategory,
  }) = _SelectEventTicketsState;
}
