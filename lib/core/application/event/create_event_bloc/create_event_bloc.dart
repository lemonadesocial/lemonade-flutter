import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/sub_event_settings.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timezone/timezone.dart';

part 'create_event_bloc.freezed.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final String? parentEventId;
  CreateEventBloc({
    this.parentEventId,
  }) : super(
          CreateEventState(
            parentEventId: parentEventId,
          ),
        ) {
    on<CreateEventTitleChanged>(_onEventTitleChanged);
    on<CreateEventDescriptionChanged>(_onCreateEventDescriptionChanged);
    on<CreateEventVirtualLinkChanged>(_onCreateEventVirtualLinkChanged);
    on<CreateEventFormSubmitted>(_onCreateEventFormSubmitted);
    on<CreateEventTagsChanged>(_onCreateEventTagsChanged);
    on<CreateEventPrivateChanged>(_onCreateEventPrivateChanged);
    on<CreateEventApprovalRequiredChanged>(
        _onCreateEventApprovalRequiredChanged);
    on<CreateEventGuestLimitChanged>(_onCreateEventGuestLimitChanged);
    on<CreateEventGuestLimitPerChanged>(_onCreateEventGuestLimitPerChanged);
  }
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onEventTitleChanged(
    CreateEventTitleChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    final title = StringFormz.dirty(event.title);
    emit(
      state.copyWith(
        title: title.isValid ? title : StringFormz.pure(event.title),
        isValid: Formz.validate([title, state.description]),
      ),
    );
  }

  Future<void> _onCreateEventDescriptionChanged(
    CreateEventDescriptionChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    final description = StringFormz.dirty(event.description);
    emit(
      state.copyWith(
        description: description.isValid
            ? description
            : StringFormz.pure(event.description),
        isValid: Formz.validate([
          state.title,
          description,
        ]),
      ),
    );
  }

  Future<void> _onCreateEventVirtualLinkChanged(
    CreateEventVirtualLinkChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        virtualUrl: event.virtualUrl,
        virtual: event.virtualUrl?.isNotEmpty == true,
      ),
    );
  }

  Future<void> _onCreateEventTagsChanged(
    CreateEventTagsChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        tags: event.tags,
      ),
    );
  }

  Future<void> _onCreateEventPrivateChanged(
    CreateEventPrivateChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        private: event.private,
      ),
    );
  }

  Future<void> _onCreateEventApprovalRequiredChanged(
    CreateEventApprovalRequiredChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        approvalRequired: event.approvalRequired,
      ),
    );
  }

  Future<void> _onCreateEventGuestLimitChanged(
    CreateEventGuestLimitChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        guestLimit: event.guestLimit,
      ),
    );
  }

  Future<void> _onCreateEventGuestLimitPerChanged(
    CreateEventGuestLimitPerChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        guestLimitPer: event.guestLimitPer,
      ),
    );
  }

  Future<void> _onCreateEventFormSubmitted(
    CreateEventFormSubmitted event,
    Emitter<CreateEventState> emit,
  ) async {
    // Convert the target selected datetime into utc
    final location = getLocation(event.timezone);
    final startUtcDateTime = event.start
        .add(Duration(milliseconds: location.currentTimeZone.offset * -1));
    final endUtcDateTime = event.end
        .add(Duration(milliseconds: location.currentTimeZone.offset * -1));
    final title = StringFormz.dirty(state.title.value);
    final description = StringFormz.dirty(state.description.value);
    emit(
      state.copyWith(
        title: title,
        description: description,
        isValid: Formz.validate([title, description]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      Input$EventInput input = Input$EventInput(
        title: title.value,
        description: description.value,
        private: state.private,
        approval_required: state.approvalRequired,
        start: DateTime.parse(startUtcDateTime.toIso8601String()),
        end: DateTime.parse(endUtcDateTime.toIso8601String()),
        timezone: event.timezone,
        guest_limit: double.parse(
          state.guestLimit ?? EventConstants.defaultEventGuestLimit,
        ),
        guest_limit_per: double.parse(
          state.guestLimitPer ?? EventConstants.defaultEventGuestLimitPer,
        ),
        virtual: state.virtual,
        virtual_url: state.virtualUrl,
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
        published: false,
        subevent_parent: parentEventId,
        subevent_enabled: event.subEventEnabled,
        subevent_settings: Input$SubeventSettingsInput(
          ticket_required_for_creation:
              event.subEventSettings?.ticketRequiredForCreation,
          ticket_required_for_purchase:
              event.subEventSettings?.ticketRequiredForPurchase,
        ),
        tags: state.tags,
      );
      final result = await _eventRepository.createEvent(input: input);
      result.fold(
        (failure) =>
            emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        (createEventResponse) {
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
              eventId: createEventResponse.createEvent.$_id,
            ),
          );
        },
      );
    }
  }
}

@freezed
class CreateEventEvent with _$CreateEventEvent {
  const factory CreateEventEvent.createEventTitleChanged(
      {required String title}) = CreateEventTitleChanged;

  const factory CreateEventEvent.createEventDescriptionChanged({
    required String description,
  }) = CreateEventDescriptionChanged;

  const factory CreateEventEvent.createEventVirtualLinkChanged({
    String? virtualUrl,
  }) = CreateEventVirtualLinkChanged;

  const factory CreateEventEvent.createEventTagsChanged({
    required List<String> tags,
  }) = CreateEventTagsChanged;

  const factory CreateEventEvent.createEventFormSubmitted({
    required DateTime start,
    required DateTime end,
    required String timezone,
    bool? private,
    bool? approvalRequired,
    Address? address,
    String? guestLimit,
    String? guestLimitPer,
    bool? subEventEnabled,
    SubEventSettings? subEventSettings,
  }) = CreateEventFormSubmitted;

  const factory CreateEventEvent.createEventPrivateChanged({
    required bool private,
  }) = CreateEventPrivateChanged;

  const factory CreateEventEvent.createEventApprovalRequiredChanged({
    required bool approvalRequired,
  }) = CreateEventApprovalRequiredChanged;

  const factory CreateEventEvent.createEventGuestLimitChanged({
    required String guestLimit,
  }) = CreateEventGuestLimitChanged;

  const factory CreateEventEvent.createEventGuestLimitPerChanged({
    required String guestLimitPer,
  }) = CreateEventGuestLimitPerChanged;
}

@freezed
class CreateEventState with _$CreateEventState {
  const factory CreateEventState({
    @Default(StringFormz.pure()) StringFormz title,
    @Default(StringFormz.pure()) StringFormz description,
    @Default(false) bool virtual,
    String? virtualUrl,
    @Default(false) bool isValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default([]) List<String> tags,
    bool? private,
    bool? approvalRequired,
    String? guestLimit,
    String? guestLimitPer,
    String? eventId,
    // Subevent related
    String? parentEventId,
  }) = _CreateEventState;
}
