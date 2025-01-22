import 'package:app/core/domain/event/entities/event_ticket_category.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/payment_utils.dart';
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
  EventTicketCategory? selectedTicketCategory;

  SelectEventTicketsBloc()
      : super(
          SelectEventTicketsState(
            selectedTickets: [],
            isSelectionValid: false,
            isPaymentRequired: false,
            commonPaymentAccounts: [],
          ),
        ) {
    on<SelectEventTicketsEventOnListTicketTypesLoaded>((event, emit) {
      eventTicketTypesResponse = event.eventTicketTypesResponse;
    });
    on<SelectEventTicketsEventOnSelectTicket>(_onSelectTicketType);
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

    List<PaymentAccount> newCommonPaymentAccounts = [];

    if (newSelectedTickets.length == 1) {
      // When only one ticket type remains, use all its payment accounts
      final ticketType =
          eventTicketTypesResponse?.ticketTypes?.firstWhereOrNull(
        (element) => element.id == newSelectedTickets.first.id,
      );
      newCommonPaymentAccounts = (ticketType?.prices ?? [])
          .expand(
            (price) => price.paymentAccountsExpanded ?? <PaymentAccount>[],
          )
          .toList();
    } else {
      // For multiple tickets, find common payment accounts across all selected tickets
      newCommonPaymentAccounts = newSelectedTickets
              .fold<List<PaymentAccount>?>(null, (previousAccounts, ticket) {
            final ticketType = eventTicketTypesResponse?.ticketTypes
                ?.firstWhereOrNull((element) => element.id == ticket.id);
            final ticketTypePaymentAccounts = (ticketType?.prices ?? [])
                .expand(
                  (price) =>
                      price.paymentAccountsExpanded ?? <PaymentAccount>[],
                )
                .toList();
            if (previousAccounts == null) return ticketTypePaymentAccounts;
            return PaymentUtils.getCommonPaymentAccounts(
              accounts1: previousAccounts,
              accounts2: ticketTypePaymentAccounts,
            );
          }) ??
          [];
    }

    emit(
      state.copyWith(
        selectedTickets: newSelectedTickets,
        isSelectionValid: _validateTotalSelectedCount(totalSelectedCount),
        // Because we dont know selected currency at this stage, so we need to show payment method selection
        // in next step => then we will know if payment is required or user can directly redeem
        isPaymentRequired: newCommonPaymentAccounts.isNotEmpty,
        commonPaymentAccounts: newCommonPaymentAccounts,
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
    return totalSelectedCount > 0;
  }
}

@freezed
class SelectEventTicketsEvent with _$SelectEventTicketsEvent {
  factory SelectEventTicketsEvent.onEventTicketTypesResponseLoaded({
    required EventTicketTypesResponse eventTicketTypesResponse,
  }) = SelectEventTicketsEventOnListTicketTypesLoaded;
  factory SelectEventTicketsEvent.select({
    required PurchasableItem ticket,
  }) = SelectEventTicketsEventOnSelectTicket;
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
    required List<PaymentAccount> commonPaymentAccounts,
    EventTicketCategory? selectedTicketCategory,
  }) = _SelectEventTicketsState;
}
