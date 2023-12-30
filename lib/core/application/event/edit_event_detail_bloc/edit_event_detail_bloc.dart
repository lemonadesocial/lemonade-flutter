import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_event_detail_bloc.freezed.dart';

class EditEventDetailBloc
    extends Bloc<EditEventDetailEvent, EditEventDetailState> {
  EditEventDetailBloc() : super(EditEventDetailState()) {
    on<EditEventDetailEventUpdateEvent>(_onUpdate);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onUpdate(
    EditEventDetailEventUpdateEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: EditEventDetailBlocStatus.loading));
    final result = await eventRepository.updateEvent(
      input: Input$EventInput(
        virtual: event.virtual,
        start: event.start != null
            ? DateTime.parse(event.start!.toUtc().toIso8601String())
            : null,
        end: event.end != null
            ? DateTime.parse(event.end!.toUtc().toIso8601String())
            : null,
      ),
      id: event.eventId,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: EditEventDetailBlocStatus.failure)),
      (eventDetail) => emit(
        state.copyWith(
          status: EditEventDetailBlocStatus.success,
          event: eventDetail,
        ),
      ),
    );
  }
}

@freezed
class EditEventDetailEvent with _$EditEventDetailEvent {
  const factory EditEventDetailEvent.update({
    required String eventId,
    bool? virtual,
    DateTime? start,
    DateTime? end,
  }) = EditEventDetailEventUpdateEvent;
}

@freezed
class EditEventDetailState with _$EditEventDetailState {
  factory EditEventDetailState({
    @Default(EditEventDetailBlocStatus.initial)
    EditEventDetailBlocStatus status,
    Event? event,
  }) = _EditEventDetailState;

  factory EditEventDetailState.initial() => EditEventDetailState();
}

enum EditEventDetailBlocStatus {
  initial,
  loading,
  success,
  failure,
}
