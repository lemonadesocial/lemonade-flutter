import 'package:app/core/domain/form/string_formz.dart';
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
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
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
