import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_bloc.freezed.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc() : super(const CreateEventState()) {
    on<EventTitleChanged>(_onTitleChanged);
    on<EventDescriptionChanged>(_onDescriptionChanged);
    on<VerifyChanged>(_onVerifyChanged);
    on<GuestLimitChanged>(_onGuestLimitChanged);
    on<GuestLimitPerChanged>(_onGuestLimitPerChanged);
    on<PrivateChanged>(_onPrivateChanged);
    on<VirtualChanged>(_onVirtualChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onTitleChanged(
    EventTitleChanged event,
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

  Future<void> _onDescriptionChanged(
    EventDescriptionChanged event,
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

  Future<void> _onVerifyChanged(
    VerifyChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        verify: event.verify,
      ),
    );
  }

  Future<void> _onGuestLimitChanged(
    GuestLimitChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        guestLimit: event.guestLimit,
      ),
    );
  }

  Future<void> _onGuestLimitPerChanged(
    GuestLimitPerChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        guestLimitPer: event.guestLimitPer,
      ),
    );
  }

  Future<void> _onPrivateChanged(
    PrivateChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        private: event.private,
      ),
    );
  }

  Future<void> _onVirtualChanged(
    VirtualChanged event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(
      state.copyWith(
        virtual: event.virtual,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<CreateEventState> emit,
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
      final timezone = await FlutterTimezone.getLocalTimezone();
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      var input = Input$EventInput(
        title: title.value,
        description: title.value,
        private: false,
        verify: false,
        start: DateTime.parse(event.start.toUtc().toIso8601String()),
        end: DateTime.parse(event.end.toUtc().toIso8601String()),
        timezone: timezone,
        guest_limit: double.parse(
          state.guestLimit ?? EventConstants.defaultEventGuestLimit,
        ),
        guest_limit_per: double.parse(
          state.guestLimitPer ?? EventConstants.defaultEventGuestLimitPer,
        ),
        virtual: state.virtual,
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
      );
      final result = await _eventRepository.createEvent(input: input);
      result.fold(
        (failure) =>
            emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        (createEvent) =>
            emit(state.copyWith(status: FormzSubmissionStatus.success)),
      );
    }
  }
}

@freezed
class CreateEventEvent with _$CreateEventEvent {
  const factory CreateEventEvent.eventTitleChanged({required String title}) =
      EventTitleChanged;

  const factory CreateEventEvent.eventDescriptionChanged({
    required String description,
  }) = EventDescriptionChanged;

  const factory CreateEventEvent.guestLimitChanged({
    required String? guestLimit,
  }) = GuestLimitChanged;

  const factory CreateEventEvent.guestLimitPerChanged({
    required String? guestLimitPer,
  }) = GuestLimitPerChanged;

  const factory CreateEventEvent.privateChanged({required bool private}) =
      PrivateChanged;

  const factory CreateEventEvent.verifyChanged({required bool verify}) =
      VerifyChanged;

  const factory CreateEventEvent.virtualChanged({required bool virtual}) =
      VirtualChanged;

  const factory CreateEventEvent.formSubmitted({
    required DateTime start,
    required DateTime end,
    Address? address,
  }) = FormSubmitted;
}

@freezed
class CreateEventState with _$CreateEventState {
  const factory CreateEventState({
    @Default(StringFormz.pure()) StringFormz title,
    @Default(StringFormz.pure()) StringFormz description,
    @Default("100") String? guestLimit,
    @Default("2") String? guestLimitPer,
    @Default(false) bool private,
    @Default(true) bool verify,
    @Default(true) bool virtual,
    @Default(false) bool isValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _CreateEventState;
}
