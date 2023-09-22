import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/input/get_event_list_ticket_types_input/get_event_list_ticket_types_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_list_ticket_types_bloc.freezed.dart';

class GetEventListTicketTypesResponseBloc extends Bloc<
    GetEventListTicketTypesResponseEvent,
    GetEventListTicketTypesResponseState> {
  final Event event;
  final _eventTicketRepository = getIt<EventTicketRepository>();

  GetEventListTicketTypesResponseBloc({
    required this.event,
  }) : super(GetEventListTicketTypesResponseStateLoading()) {
    on<GetEventListTicketTypesResponseEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    GetEventListTicketTypesResponseEventFetch blocEvent,
    Emitter emit,
  ) async {
    final result = await _eventTicketRepository.getEventListTicketTypesResponse(
      input: GetEventListTicketTypesResponseInput(event: event.id ?? ''),
    );
    result.fold(
      (l) => emit(GetEventListTicketTypesResponseState.failure()),
      (data) => emit(
        GetEventListTicketTypesResponseState.success(
          listTicketTypesResponse: data,
        ),
      ),
    );
  }
}

@freezed
class GetEventListTicketTypesResponseEvent
    with _$GetEventListTicketTypesResponseEvent {
  factory GetEventListTicketTypesResponseEvent.fetch() =
      GetEventListTicketTypesResponseEventFetch;
}

@freezed
class GetEventListTicketTypesResponseState
    with _$GetEventListTicketTypesResponseState {
  factory GetEventListTicketTypesResponseState.loading() =
      GetEventListTicketTypesResponseStateLoading;
  factory GetEventListTicketTypesResponseState.success({
    required EventListTicketTypesResponse listTicketTypesResponse,
  }) = GetEventListTicketTypesResponseStateSuccess;
  factory GetEventListTicketTypesResponseState.failure() =
      GetEventListTicketTypesResponseStateFailure;
}
