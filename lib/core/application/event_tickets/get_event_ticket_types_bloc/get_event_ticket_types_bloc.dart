import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/get_event_ticket_types_input/get_event_ticket_types_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_ticket_types_bloc.freezed.dart';

class GetEventTicketTypesBloc
    extends Bloc<GetEventTicketTypesEvent, GetEventTicketTypesState> {
  final Event event;
  final _eventTicketRepository = getIt<EventTicketRepository>();

  GetEventTicketTypesBloc({
    required this.event,
  }) : super(GetEventTicketTypesStateLoading()) {
    on<GetEventTicketTypesEventFetch>(_onFetch);
  }

  Future<void> _onFetch(
    GetEventTicketTypesEventFetch blocEvent,
    Emitter emit,
  ) async {
    final result = await _eventTicketRepository.getEventTicketTypes(
      input: GetEventTicketTypesInput(event: event.id ?? ''),
    );
    result.fold(
      (l) => emit(GetEventTicketTypesState.failure()),
      (data) => emit(
        GetEventTicketTypesState.success(
          eventTicketTypesResponse: data,
          supportedCurrencies: EventTicketUtils.getSupportedCurrencies(
            ticketTypes: data.ticketTypes ?? [],
          ),
        ),
      ),
    );
  }
}

@freezed
class GetEventTicketTypesEvent with _$GetEventTicketTypesEvent {
  factory GetEventTicketTypesEvent.fetch() = GetEventTicketTypesEventFetch;
}

@freezed
class GetEventTicketTypesState with _$GetEventTicketTypesState {
  factory GetEventTicketTypesState.loading() = GetEventTicketTypesStateLoading;
  factory GetEventTicketTypesState.success({
    required EventTicketTypesResponse eventTicketTypesResponse,
    required List<Currency> supportedCurrencies,
  }) = GetEventTicketTypesStateSuccess;
  factory GetEventTicketTypesState.failure() = GetEventTicketTypesStateFailure;
}
