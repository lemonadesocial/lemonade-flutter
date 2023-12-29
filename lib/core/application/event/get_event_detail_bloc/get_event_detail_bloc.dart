import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_detail_bloc.freezed.dart';

class GetEventDetailBloc
    extends Bloc<GetEventDetailEvent, GetEventDetailState> {
  GetEventDetailBloc() : super(const GetEventDetailStateLoading()) {
    on<GetEventDetailEventFetch>(_onFetch);
    on<GetEventDetailEventUpdateEvent>(_onUpdate);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onFetch(GetEventDetailEventFetch event, Emitter emit) async {
    final result = await eventRepository.getEventDetail(
      input: GetEventDetailInput(
        id: event.eventId,
      ),
    );
    result.fold(
      (failure) => emit(const GetEventDetailState.failure()),
      (eventDetail) => emit(
        GetEventDetailState.fetched(eventDetail: eventDetail),
      ),
    );
  }

  Future<void> _onUpdate(
    GetEventDetailEventUpdateEvent event,
    Emitter emit,
  ) async {
    final result = await eventRepository.updateEvent(
      input: Input$EventInput(
        virtual: event.virtual,
      ),
      id: event.eventId,
    );
    result.fold(
      (failure) => {},
      (eventDetail) => emit(
        GetEventDetailState.fetched(eventDetail: eventDetail),
      ),
    );
  }
}

@freezed
class GetEventDetailEvent with _$GetEventDetailEvent {
  const factory GetEventDetailEvent.fetch({
    required String eventId,
  }) = GetEventDetailEventFetch;

  const factory GetEventDetailEvent.update({
    required String eventId,
    bool? virtual,
  }) = GetEventDetailEventUpdateEvent;
}

@freezed
class GetEventDetailState with _$GetEventDetailState {
  const factory GetEventDetailState.fetched({
    required Event eventDetail,
  }) = GetEventDetailStateFetched;
  const factory GetEventDetailState.loading() = GetEventDetailStateLoading;
  const factory GetEventDetailState.failure() = GetEventDetailStateFailure;
}
