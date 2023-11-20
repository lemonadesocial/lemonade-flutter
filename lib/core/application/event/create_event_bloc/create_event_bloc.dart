import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/event_input/event_input.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_bloc.freezed.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc() : super(const CreateEventState()) {
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onTitleChanged(
    TitleChanged event,
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
    DescriptionChanged event,
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
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await _eventRepository.createEvent(
        input: EventInput(
          title: title.value,
          description: title.value,
          private: false,
          verify: false,
          start: "2023-11-22T03:00:00.881Z",
          end: "2023-11-26T11:00:00.881Z",
          timezone: "Asia/Bangkok",
          guestLimit: 100,
          guestLimitPer: 2,
          virtual: true,
        ),
      );
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
  const factory CreateEventEvent.titleChanged({required String title}) =
      TitleChanged;

  const factory CreateEventEvent.descriptionChanged({
    required String description,
  }) = DescriptionChanged;

  const factory CreateEventEvent.formSubmitted() = FormSubmitted;
}

@freezed
class CreateEventState with _$CreateEventState {
  const factory CreateEventState({
    @Default(StringFormz.pure()) StringFormz title,
    @Default(StringFormz.pure()) StringFormz description,
    @Default(false) bool isValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _CreateEventState;
}
