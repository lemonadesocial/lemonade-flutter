import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_rsvp.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accept_event_bloc.freezed.dart';

class AcceptEventBloc extends Bloc<AcceptEventBlocEvent, AcceptEventState> {
  AcceptEventBloc({
    required this.event,
  }) : super(AcceptEventStateInitial()) {
    on<AcceptEventBlocEventAccept>(_onAccept);
  }
  final Event event;
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onAccept(
    AcceptEventBlocEventAccept blocEvent,
    Emitter emit,
  ) async {
    emit(AcceptEventState.loading());

    final result = await _eventRepository.acceptEvent(
      input: AcceptEventInput(id: event.id!),
    );

    result.fold(
      (failure) => emit(AcceptEventState.failure(message: failure.message)),
      (eventRsvp) {
        if (eventRsvp.state == EventRsvpState.accepted) {
          emit(AcceptEventState.success(eventRsvp: eventRsvp));
        } else {
          emit(AcceptEventState.failure());
        }
      },
    );
  }
}

@freezed
class AcceptEventBlocEvent with _$AcceptEventBlocEvent {
  factory AcceptEventBlocEvent.accept() = AcceptEventBlocEventAccept;
}

@freezed
class AcceptEventState with _$AcceptEventState {
  factory AcceptEventState.initial() = AcceptEventStateInitial;
  factory AcceptEventState.loading() = AcceptEventStateLoading;
  factory AcceptEventState.success({
    required EventRsvp eventRsvp,
  }) = AcceptEventStateSuccess;
  factory AcceptEventState.failure({
    String? message,
  }) = AcceptEventStateFailure;
}
