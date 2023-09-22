import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/input/get_event_list_ticket_types_input/get_event_list_ticket_types_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_list_ticket_types_bloc.freezed.dart';

class GetEventListTicketTypesBloc
    extends Bloc<GetEventListTicketTypesEvent, GetEventListTicketTypesState> {
  final Event event;
  final _eventTicketRepository = getIt<EventTicketRepository>();

  GetEventListTicketTypesBloc({
    required this.event,
  }) : super(GetEventListTicketTypesStateLoading()) {
    on<GetEventListTicketTypesEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
      GetEventListTicketTypesEventFetch blocEvent, Emitter emit) async {
    final result = await _eventTicketRepository.getEventListTicketTypes(
      input: GetEventListTicketTypesInput(event: event.id ?? ''),
    );
    result.fold(
      (l) => emit(GetEventListTicketTypesState.failure()),
      (data) => emit(
        GetEventListTicketTypesState.success(
          listTicketTypes: data,
        ),
      ),
    );
  }
}

@freezed
class GetEventListTicketTypesEvent with _$GetEventListTicketTypesEvent {
  factory GetEventListTicketTypesEvent.fetch() =
      GetEventListTicketTypesEventFetch;
}

@freezed
class GetEventListTicketTypesState with _$GetEventListTicketTypesState {
  factory GetEventListTicketTypesState.loading() =
      GetEventListTicketTypesStateLoading;
  factory GetEventListTicketTypesState.success({
    required EventListTicketTypes listTicketTypes,
  }) = GetEventListTicketTypesStateSuccess;
  factory GetEventListTicketTypesState.failure() =
      GetEventListTicketTypesStateFailure;
}
