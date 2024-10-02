import 'package:app/core/data/event/repository/event_ticket_repository_impl.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/redeem_tickets_response.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'redeem_tickets_bloc.freezed.dart';

class RedeemTicketsBloc extends Bloc<RedeemTicketsEvent, RedeemTicketsState> {
  final Event event;
  final _eventTicketRepository = EventTicketRepositoryImpl();

  RedeemTicketsBloc({
    required this.event,
  }) : super(RedeemTicketsStateInitial()) {
    on<RedeemTicketsEventRedeem>(_onRedeem);
  }

  Future<void> _onRedeem(
    RedeemTicketsEventRedeem blocEvent,
    Emitter emit,
  ) async {
    emit(RedeemTicketsState.loading());

    final result = await _eventTicketRepository.redeemTickets(
      input: Input$RedeemTicketsInput(
        event: event.id ?? '',
        items: blocEvent.ticketItems
            .map(
              (item) => Input$PurchasableItem(
                count: item.count,
                id: item.id,
              ),
            )
            .toList(),
      ),
    );

    result.fold(
      (failure) => emit(RedeemTicketsState.failure(message: failure.message)),
      (data) => emit(
        RedeemTicketsState.success(redeemTicketsResponse: data),
      ),
    );
  }
}

@freezed
class RedeemTicketsEvent with _$RedeemTicketsEvent {
  factory RedeemTicketsEvent.redeem({
    required List<PurchasableItem> ticketItems,
  }) = RedeemTicketsEventRedeem;
}

@freezed
class RedeemTicketsState with _$RedeemTicketsState {
  factory RedeemTicketsState.initial() = RedeemTicketsStateInitial;
  factory RedeemTicketsState.loading() = RedeemTicketsStateLoading;
  factory RedeemTicketsState.success({
    required RedeemTicketsResponse redeemTicketsResponse,
  }) = RedeemTicketsStateSuccess;
  factory RedeemTicketsState.failure({
    String? message,
  }) = RedeemTicketsStateFailure;
}
