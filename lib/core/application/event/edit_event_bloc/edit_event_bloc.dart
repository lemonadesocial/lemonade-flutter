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

part 'edit_event_bloc.freezed.dart';

class EditEventBloc extends Bloc<EditEventEvent, EditEventState> {
  final String? parentEventId;
  EditEventBloc({
    this.parentEventId,
  }) : super(
          EditEventState(
            parentEventId: parentEventId,
          ),
        ) {
    on<EventTitleChanged>(_onTitleChanged);
    on<EventDescriptionChanged>(_onDescriptionChanged);
    on<VirtualLinkChanged>(_onVirtualLinkChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<TagsChanged>(_onTagsChanged);
  }
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onTitleChanged(
    EventTitleChanged event,
    Emitter<EditEventState> emit,
  ) async {
    final title = StringFormz.dirty(event.title);
    emit(
      state.copyWith(
        title: title.isValid ? title : StringFormz.pure(event.title),
        isValid: Formz.validate([title, state.description]),
      ),
    );
  }

  Future<void> _onDescriptionChanged(
    EventDescriptionChanged event,
    Emitter<EditEventState> emit,
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

  Future<void> _onVirtualLinkChanged(
    VirtualLinkChanged event,
    Emitter<EditEventState> emit,
  ) async {
    emit(
      state.copyWith(
        virtualUrl: event.virtualUrl,
        virtual: event.virtualUrl?.isNotEmpty == true,
      ),
    );
  }

  Future<void> _onTagsChanged(
    TagsChanged event,
    Emitter<EditEventState> emit,
  ) async {
    emit(
      state.copyWith(
        tags: event.tags,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<EditEventState> emit,
  ) async {
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
        private: event.private,
        approval_required: event.approvalRequired,
        start: DateTime.parse(event.start.toIso8601String()),
        end: DateTime.parse(event.end.toIso8601String()),
        timezone: event.timezone,
        guest_limit: double.parse(
          event.guestLimit ?? EventConstants.defaultEventGuestLimit,
        ),
        guest_limit_per: double.parse(
          event.guestLimitPer ?? EventConstants.defaultEventGuestLimitPer,
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
class EditEventEvent with _$EditEventEvent {
  const factory EditEventEvent.eventTitleChanged({required String title}) =
      EventTitleChanged;

  const factory EditEventEvent.eventDescriptionChanged({
    required String description,
  }) = EventDescriptionChanged;

  const factory EditEventEvent.virtualLinkChanged({String? virtualUrl}) =
      VirtualLinkChanged;

  const factory EditEventEvent.tagsChanged({required List<String> tags}) =
      TagsChanged;

  const factory EditEventEvent.formSubmitted({
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
  }) = FormSubmitted;
}

@freezed
class EditEventState with _$EditEventState {
  const factory EditEventState({
    @Default(StringFormz.pure()) StringFormz title,
    @Default(StringFormz.pure()) StringFormz description,
    @Default(false) bool virtual,
    String? virtualUrl,
    @Default(false) bool isValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default([]) List<String> tags,
    String? eventId,
    // Subevent related
    String? parentEventId,
  }) = _EditEventState;
}
