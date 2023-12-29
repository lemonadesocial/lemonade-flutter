import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_event_detail_bloc.freezed.dart';

class EditEventDetailBloc
    extends Bloc<EditEventDetailEvent, EditEventDetailState> {
  EditEventDetailBloc() : super(const EditEventDetailStateInitial()) {
    on<EditEventDetailEventUpdateEvent>(_onUpdate);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onUpdate(
    EditEventDetailEventUpdateEvent event,
    Emitter emit,
  ) async {
    emit(const EditEventDetailState.loading());
    final result = await eventRepository.updateEvent(
      input: Input$EventInput(
        virtual: event.virtual,
      ),
      id: event.eventId,
    );
    result.fold(
      (failure) => emit(const EditEventDetailState.failure()),
      (eventDetail) => emit(
        EditEventDetailState.success(eventDetail: eventDetail),
      ),
    );
  }
}

@freezed
class EditEventDetailEvent with _$EditEventDetailEvent {
  const factory EditEventDetailEvent.update({
    required String eventId,
    bool? virtual,
  }) = EditEventDetailEventUpdateEvent;
}

@freezed
class EditEventDetailState with _$EditEventDetailState {
  const factory EditEventDetailState.initial() = EditEventDetailStateInitial;
  const factory EditEventDetailState.loading() = EditEventDetailStateLoading;
  const factory EditEventDetailState.success({
    required Event eventDetail,
  }) = EditEventDetailStateSuccess;
  const factory EditEventDetailState.failure() = EditEventDetailStateFailure;
}
