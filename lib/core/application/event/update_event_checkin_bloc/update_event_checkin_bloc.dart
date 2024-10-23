import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_event_checkin_bloc.freezed.dart';

class UpdateEventCheckinBloc
    extends Bloc<UpdateEventCheckinEvent, UpdateEventCheckinState> {
  UpdateEventCheckinBloc() : super(UpdateEventCheckinStateInitial()) {
    on<UpdateEventCheckinSubmit>(_onCheckinUser);
  }
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onCheckinUser(
    UpdateEventCheckinSubmit event,
    Emitter emit,
  ) async {
    emit(UpdateEventCheckinState.loading());
    final result = await _eventRepository.updateEventCheckin(
      input: Input$UpdateEventCheckinInput(
        active: event.active,
        event: event.eventId,
        user: event.userId,
      ),
    );
    result.fold(
      (failure) => emit(UpdateEventCheckinState.failure()),
      (eventCheckin) {
        emit(UpdateEventCheckinState.success());
      },
    );
  }
}

@freezed
class UpdateEventCheckinEvent with _$UpdateEventCheckinEvent {
  factory UpdateEventCheckinEvent.checkinUser({
    required bool active,
    required String eventId,
    required String userId,
  }) = UpdateEventCheckinSubmit;
}

@freezed
class UpdateEventCheckinState with _$UpdateEventCheckinState {
  factory UpdateEventCheckinState.initial() = UpdateEventCheckinStateInitial;
  factory UpdateEventCheckinState.loading() = UpdateEventCheckinStateLoading;
  factory UpdateEventCheckinState.success() = UpdateEventCheckinStateSuccess;
  factory UpdateEventCheckinState.failure() = UpdateEventCheckinStateFailure;
}
