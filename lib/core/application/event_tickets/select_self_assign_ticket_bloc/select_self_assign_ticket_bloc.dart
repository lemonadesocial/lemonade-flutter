import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_self_assign_ticket_bloc.freezed.dart';

class SelectSelfAssignTicketBloc
    extends Bloc<SelectSelfAssignTicketEvent, SelectSelfAssignTicketState> {
  SelectSelfAssignTicketBloc()
      : super(
          SelectSelfAssignTicketState(
            myTickets: [],
          ),
        ) {
    on<SelectSelfAssignTicketEventOnSelect>(_onSelect);
    on<SelectSelfAssignTicketEventOnMyTicketsLoaded>(_onMyTicketsLoaded);
  }

  void _onSelect(SelectSelfAssignTicketEventOnSelect event, emit) {
    emit(
      state.copyWith(
        selectedTicketType: event.ticketTypeId,
      ),
    );
  }

  void _onMyTicketsLoaded(
    SelectSelfAssignTicketEventOnMyTicketsLoaded event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(myTickets: event.myTickets),
    );
  }

  EventTicket? getTicketToAssign() {
    return state.myTickets
        .firstWhere((ticket) => ticket.type == state.selectedTicketType);
  }
}

@freezed
class SelectSelfAssignTicketEvent with _$SelectSelfAssignTicketEvent {
  factory SelectSelfAssignTicketEvent.select({
    required String ticketTypeId,
  }) = SelectSelfAssignTicketEventOnSelect;
  factory SelectSelfAssignTicketEvent.onMyTicketsLoaded({
    required List<EventTicket> myTickets,
  }) = SelectSelfAssignTicketEventOnMyTicketsLoaded;
}

@freezed
class SelectSelfAssignTicketState with _$SelectSelfAssignTicketState {
  factory SelectSelfAssignTicketState({
    String? selectedTicketType,
    required List<EventTicket> myTickets,
  }) = _SelectSelfAssignTicketState;
}
