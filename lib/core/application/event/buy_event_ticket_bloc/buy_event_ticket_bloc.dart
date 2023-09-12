import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_event_ticket_bloc.freezed.dart';

class BuyEventTicketBloc
    extends Bloc<BuyEventTicketEvent, BuyEventTicketState> {
  BuyEventTicketBloc({
    required this.event,
  }) : super(BuyEventTicketStateInitial()) {
    on<BuyEventTicketEventBuy>(_onBuyTicket);
  }
  final Event event;
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onBuyTicket(
    BuyEventTicketEventBuy blocEvent,
    Emitter emit,
  ) async {
    emit(BuyEventTicketState.loading());

    if (event.cost != null && event.cost != 0) {
      return emit(BuyEventTicketState.needWebview());
    }

    final result = await _eventRepository.acceptEvent(
      input: AcceptEventInput(id: event.id!),
    );

    result.fold(
      (failure) => emit(BuyEventTicketState.failure()),
      (eventRsvp) {
        if (eventRsvp.state == EventRsvpState.accepted) {
          emit(BuyEventTicketState.success());
        } else {
          emit(BuyEventTicketState.failure());
        }
      },
    );
  }
}

@freezed
class BuyEventTicketEvent with _$BuyEventTicketEvent {
  factory BuyEventTicketEvent.buy() = BuyEventTicketEventBuy;
}

@freezed
class BuyEventTicketState with _$BuyEventTicketState {
  factory BuyEventTicketState.initial() = BuyEventTicketStateInitial;
  factory BuyEventTicketState.loading() = BuyEventTicketStateLoading;
  factory BuyEventTicketState.success() = BuyEventTicketStateSuccess;
  factory BuyEventTicketState.needWebview() = BuyEventTicketStateNeedWebview;
  factory BuyEventTicketState.failure() = BuyEventTicketStateFailure;
}
