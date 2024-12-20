import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_ticket_bloc.freezed.dart';

class GetTicketBloc extends Bloc<GetTicketEvent, GetTicketState> {
  final _eventTicketRepository = getIt<EventTicketRepository>();

  GetTicketBloc() : super(GetTicketStateLoading()) {
    on<GetTicketEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    GetTicketEventFetch event,
    Emitter emit,
  ) async {
    if (event.showLoading) {
      emit(GetTicketState.loading());
    }

    final result = await _eventTicketRepository.getTicket(
      shortId: event.shortId,
    );

    result.fold(
      (failure) => emit(GetTicketState.failure()),
      (data) => emit(
        GetTicketState.success(
          eventTicket: data,
        ),
      ),
    );
  }
}

@freezed
class GetTicketEvent with _$GetTicketEvent {
  factory GetTicketEvent.fetch({
    required String shortId,
    required bool showLoading,
  }) = GetTicketEventFetch;
}

@freezed
class GetTicketState with _$GetTicketState {
  factory GetTicketState.loading() = GetTicketStateLoading;
  factory GetTicketState.success({
    required EventTicket eventTicket,
  }) = GetTicketStateSuccess;
  factory GetTicketState.failure() = GetTicketStateFailure;
}
