import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_detail_bloc.freezed.dart';

class GetEventDetailBloc
    extends Bloc<GetEventDetailEvent, GetEventDetailState> {
  GetEventDetailBloc() : super(const GetEventDetailStateLoading()) {
    on<GetEventDetailEventFetch>(_onFetch);
    on<GetEventDetailEventReplace>(_onReplace);
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

  Future<void> _onReplace(
    GetEventDetailEventReplace event,
    Emitter emit,
  ) async {
    emit(GetEventDetailState.fetched(eventDetail: event.event));
  }
}

@freezed
class GetEventDetailEvent with _$GetEventDetailEvent {
  const factory GetEventDetailEvent.fetch({
    required String eventId,
  }) = GetEventDetailEventFetch;

  const factory GetEventDetailEvent.replace({
    required Event event,
  }) = GetEventDetailEventReplace;
}

@freezed
class GetEventDetailState with _$GetEventDetailState {
  const factory GetEventDetailState.fetched({
    required Event eventDetail,
  }) = GetEventDetailStateFetched;
  const factory GetEventDetailState.loading() = GetEventDetailStateLoading;
  const factory GetEventDetailState.failure() = GetEventDetailStateFailure;
}
