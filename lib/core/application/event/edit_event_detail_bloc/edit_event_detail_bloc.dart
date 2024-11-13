import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/sub_event_settings.dart';
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
    on<EditEventDetailEventUpdateTitle>(_onUpdateTitle);
    on<EditEventDetailEventUpdateDescription>(_onUpdateDescription);
    on<EditEventDetailEventUpdateVirtualUrl>(_onUpdateVirtualUrl);
    on<EditEventDetailEventUpdateTags>(_onUpdateTags);
    on<EditEventDetailEventUpdatePrivate>(_onUpdatePrivate);
    on<EditEventDetailEventUpdateApprovalRequired>(_onUpdateApprovalRequired);
    on<EditEventDetailEventUpdateGuestLimit>(_onUpdateGuestLimit);
    on<EditEventDetailEventUpdateGuestLimitPer>(_onUpdateGuestLimitPer);
    on<EditEventDetailEventUpdateAddress>(_onUpdateAddress);
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

  Future<void> _updateEventAndEmitStatus({
    required Input$EventInput input,
    required String eventId,
    required Emitter emit,
  }) async {
    emit(state.copyWith(status: EditEventDetailBlocStatus.loading));
    final result = await eventRepository.updateEvent(
      input: input,
      id: eventId,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: EditEventDetailBlocStatus.failure)),
      (eventDetail) =>
          emit(state.copyWith(status: EditEventDetailBlocStatus.success)),
    );
  }

  Future<void> _onUpdateTitle(
    EditEventDetailEventUpdateTitle event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(title: event.title),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdateDescription(
    EditEventDetailEventUpdateDescription event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(description: event.description),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdateVirtualUrl(
    EditEventDetailEventUpdateVirtualUrl event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(virtual_url: event.virtualUrl),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdateTags(
    EditEventDetailEventUpdateTags event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(tags: event.tags),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdatePrivate(
    EditEventDetailEventUpdatePrivate event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(private: event.private),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdateApprovalRequired(
    EditEventDetailEventUpdateApprovalRequired event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(approval_required: event.approvalRequired),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdateGuestLimit(
    EditEventDetailEventUpdateGuestLimit event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(guest_limit: double.parse(event.guestLimit)),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdateGuestLimitPer(
    EditEventDetailEventUpdateGuestLimitPer event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(
        guest_limit_per: double.parse(event.guestLimitPer),
      ),
      eventId: event.eventId,
      emit: emit,
    );
  }

  Future<void> _onUpdateAddress(
    EditEventDetailEventUpdateAddress event,
    Emitter emit,
  ) async {
    await _updateEventAndEmitStatus(
      input: Input$EventInput(
        address: Input$AddressInput(
          title: event.address.title,
          street_1: event.address.street1,
          street_2: event.address.street2,
          region: event.address.region,
          city: event.address.city,
          country: event.address.country,
          postal: event.address.postal,
          recipient_name: event.address.recipientName,
          latitude: event.address.latitude,
          longitude: event.address.longitude,
        ),
      ),
      eventId: event.eventId,
      emit: emit,
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
        virtual_url: event.virtualUrl,
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
        subevent_settings: Input$SubeventSettingsInput(
          ticket_required_for_creation:
              event.subEventSettings?.ticketRequiredForCreation,
          ticket_required_for_purchase:
              event.subEventSettings?.ticketRequiredForPurchase,
        ),
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

  const factory EditEventDetailEvent.updateTitle({
    required String eventId,
    required String title,
  }) = EditEventDetailEventUpdateTitle;

  const factory EditEventDetailEvent.updateDescription({
    required String eventId,
    required String description,
  }) = EditEventDetailEventUpdateDescription;

  const factory EditEventDetailEvent.updateVirtualUrl({
    required String eventId,
    required String virtualUrl,
  }) = EditEventDetailEventUpdateVirtualUrl;

  const factory EditEventDetailEvent.updateTags({
    required String eventId,
    required List<String> tags,
  }) = EditEventDetailEventUpdateTags;

  const factory EditEventDetailEvent.updatePrivate({
    required String eventId,
    required bool private,
  }) = EditEventDetailEventUpdatePrivate;

  const factory EditEventDetailEvent.updateApprovalRequired({
    required String eventId,
    required bool approvalRequired,
  }) = EditEventDetailEventUpdateApprovalRequired;

  const factory EditEventDetailEvent.updateGuestLimit({
    required String eventId,
    required String guestLimit,
  }) = EditEventDetailEventUpdateGuestLimit;

  const factory EditEventDetailEvent.updateGuestLimitPer({
    required String eventId,
    required String guestLimitPer,
  }) = EditEventDetailEventUpdateGuestLimitPer;

  const factory EditEventDetailEvent.updateAddress({
    required String eventId,
    required Address address,
  }) = EditEventDetailEventUpdateAddress;

  const factory EditEventDetailEvent.update({
    required String eventId,
    bool? virtual,
    String? virtualUrl,
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
    SubEventSettings? subEventSettings,
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
