import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_my_tickets_bloc.freezed.dart';

class GetMyTicketsBloc extends Bloc<GetMyTicketsEvent, GetMyTicketsState> {
  final GetTicketsInput input;
  final _eventTicketRepository = getIt<EventTicketRepository>();

  GetMyTicketsBloc({
    required this.input,
  }) : super(GetMyTicketsStateLoading()) {
    on<GetMyTicketsEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    GetMyTicketsEventFetch event,
    Emitter emit,
  ) async {
    if (state is! GetMyTicketsStateSuccess) {
      emit(GetMyTicketsState.loading());
    }

    final result = await _eventTicketRepository.getTickets(input: input);

    result.fold(
      (failure) => emit(GetMyTicketsState.failure()),
      (data) => emit(
        GetMyTicketsState.success(
          eventTickets: data,
        ),
      ),
    );
  }
}

@freezed
class GetMyTicketsEvent with _$GetMyTicketsEvent {
  factory GetMyTicketsEvent.fetch() = GetMyTicketsEventFetch;
}

@freezed
class GetMyTicketsState with _$GetMyTicketsState {
  factory GetMyTicketsState.loading() = GetMyTicketsStateLoading;
  factory GetMyTicketsState.success({
    required List<EventTicket> eventTickets,
  }) = GetMyTicketsStateSuccess;
  factory GetMyTicketsState.failure() = GetMyTicketsStateFailure;
}
