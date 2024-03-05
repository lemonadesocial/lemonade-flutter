import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_events_listing_bloc.freezed.dart';

class MyEventsListingBloc
    extends Bloc<MyEventsListingEvent, MyEventsListingState> {
  final _eventRepository = getIt<EventRepository>();
  final GetHostingEventsInput defaultInput;
  MyEventsListingBloc({required this.defaultInput})
      : super(MyEventsListingState.loading()) {
    on<MyEventsListingEvent>(_onFetch);
  }

  Future<void> _onFetch(MyEventsListingEvent event, Emitter emit) async {
    final result = await _eventRepository.getHostingEvents(
      input: defaultInput,
    );
    result.fold(
      (l) => emit(MyEventsListingState.failure()),
      (events) => emit(
        MyEventsListingState.fetched(
          events: events,
        ),
      ),
    );
  }
}

@freezed
class MyEventsListingEvent with _$MyEventsListingEvent {
  factory MyEventsListingEvent.fetch() = MyEventsListingEventFetch;
}

@freezed
class MyEventsListingState with _$MyEventsListingState {
  factory MyEventsListingState.loading() = MyEventsListingStateLoading;
  factory MyEventsListingState.fetched({
    required List<Event> events,
  }) = MyEventsListingStateFetched;
  factory MyEventsListingState.failure() = MyEventsListingStateFailure;
}
