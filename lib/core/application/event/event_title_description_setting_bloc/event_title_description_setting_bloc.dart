import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/form/string_formz.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_title_description_setting_bloc.freezed.dart';

class EventTitleDescriptionSettingBloc extends Bloc<
    EventTitleDescriptionSettingEvent, EventTitleDescriptionSettingState> {
  final Event? eventDetail;
  EventTitleDescriptionSettingBloc(this.eventDetail)
      : super(const EventTitleDescriptionSettingState()) {
    on<EventTitleDescriptionSettingEventInit>(_onInit);
    on<EventTitleDescriptionSettingEventTitleChanged>(_onTitleChanged);
    on<EventTitleDescriptionSettingEventSaveChanges>(_onSaveChanges);

    if (eventDetail != null) {
      add(
        EventTitleDescriptionSettingEvent.init(
          title: eventDetail?.title ?? '',
          description: eventDetail?.description ?? '',
        ),
      );
    }
  }
  final _eventRepository = getIt<EventRepository>();

  Future<void> _onInit(
    EventTitleDescriptionSettingEventInit event,
    Emitter<EventTitleDescriptionSettingState> emit,
  ) async {
    final title = StringFormz.dirty(event.title);
    final document = markdownToDocument(event.description);
    emit(
      state.copyWith(
        title: title,
        descriptionEditorState: EditorState(document: document),
        isValid: Formz.validate([title]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onTitleChanged(
    EventTitleDescriptionSettingEventTitleChanged event,
    Emitter<EventTitleDescriptionSettingState> emit,
  ) async {
    final title = StringFormz.dirty(event.title);
    emit(
      state.copyWith(
        title: title.isValid ? title : StringFormz.pure(event.title),
        isValid: Formz.validate([title]),
      ),
    );
  }

  Future<void> _onSaveChanges(
    EventTitleDescriptionSettingEventSaveChanges event,
    Emitter<EventTitleDescriptionSettingState> emit,
  ) async {
    final title = StringFormz.dirty(state.title.value);
    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([title]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await _eventRepository.updateEvent(
        input: Input$EventInput(
          title: state.title.value,
          description:
              documentToMarkdown(state.descriptionEditorState!.document),
        ),
        id: event.eventId,
      );
      result.fold(
        (failure) =>
            emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        (eventDetail) => emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
          ),
        ),
      );
    }
  }
}

@freezed
class EventTitleDescriptionSettingEvent
    with _$EventTitleDescriptionSettingEvent {
  const factory EventTitleDescriptionSettingEvent.init({
    required String title,
    required String description,
  }) = EventTitleDescriptionSettingEventInit;

  const factory EventTitleDescriptionSettingEvent.eventTitleChanged({
    required String title,
  }) = EventTitleDescriptionSettingEventTitleChanged;

  const factory EventTitleDescriptionSettingEvent.saveChanges({
    required String eventId,
  }) = EventTitleDescriptionSettingEventSaveChanges;
}

@freezed
class EventTitleDescriptionSettingState
    with _$EventTitleDescriptionSettingState {
  const factory EventTitleDescriptionSettingState({
    @Default(StringFormz.pure()) StringFormz title,
    EditorState? descriptionEditorState,
    @Default(false) bool isValid,
    FormzSubmissionStatus? status,
  }) = _EventTitleDescriptionSettingState;
}
