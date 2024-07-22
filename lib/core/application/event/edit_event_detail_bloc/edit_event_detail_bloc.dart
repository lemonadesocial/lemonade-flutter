import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_event_detail_bloc.freezed.dart';

class EditEventDetailBloc
    extends Bloc<EditEventDetailEvent, EditEventDetailState> {
  final String? parentEventId;
  EditEventDetailBloc({
    this.parentEventId,
  }) : super(
          EditEventDetailState(
            parentEventId: parentEventId,
          ),
        ) {
    on<EditEventDetailEventUpdateEvent>(_onUpdate);
    on<EditEventDetailEventUpdateParentEvent>(_onUpdateParentEventId);
  }

  final EventRepository eventRepository = getIt<EventRepository>();

  void _onUpdateParentEventId(
    EditEventDetailEventUpdateParentEvent event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(parentEventId: event.parentEventId),
    );
  }

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
        approval_required: event.approvalRequired,
        guest_limit: event.guestLimit != null
            ? double.parse(event.guestLimit ?? '')
            : null,
        guest_limit_per: event.guestLimitPer != null
            ? double.parse(event.guestLimitPer ?? '')
            : null,
        private: event.private ?? false,
        address: event.address != null
            ? Input$AddressInput(
                title: event.address!.title,
                street_1: event.address!.street1,
                street_2: event.address!.street2,
                region: event.address!.region,
                city: event.address!.city,
                country: event.address!.country,
                postal: event.address!.postal,
                recipient_name: event.address!.recipientName,
                latitude: event.address!.latitude,
                longitude: event.address!.longitude,
              )
            : null,
        speaker_users: event.speakerUsers ?? [],
        timezone: event.timezone,
        subevent_enabled: event.subEventEnabled,
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
  const factory EditEventDetailEvent.updateParentEvent({
    String? parentEventId,
  }) = EditEventDetailEventUpdateParentEvent;

  const factory EditEventDetailEvent.update({
    required String eventId,
    bool? virtual,
    DateTime? start,
    DateTime? end,
    Address? address,
    String? guestLimit,
    String? guestLimitPer,
    bool? private,
    List<String>? speakerUsers,
    bool? approvalRequired,
    String? timezone,
    bool? subEventEnabled,
  }) = EditEventDetailEventUpdateEvent;
}

@freezed
class EditEventDetailState with _$EditEventDetailState {
  factory EditEventDetailState({
    @Default(EditEventDetailBlocStatus.initial)
    EditEventDetailBlocStatus status,
    Event? event,
    String? parentEventId,
  }) = _EditEventDetailState;

  factory EditEventDetailState.initial() => EditEventDetailState();
}

enum EditEventDetailBlocStatus {
  initial,
  loading,
  success,
  failure,
}
