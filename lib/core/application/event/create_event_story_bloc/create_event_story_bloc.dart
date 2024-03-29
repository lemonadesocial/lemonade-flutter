import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/event/mutation/update_event_story_image.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'create_event_story_bloc.freezed.dart';

class CreateEventStoryBloc
    extends Bloc<CreateEventStoryEvent, CreateEventStoryState> {
  CreateEventStoryBloc()
      : super(
          CreateEventStoryState.initial(
            data: CreateEventStoryData(isValid: false),
          ),
        ) {
    on<CreateEventStoryEventOnImageFileChanged>(_onImageFileChanged);
    on<CreateEventStoryEventOnDescriptionChanged>(_onDescriptionChanged);
    on<CreateEventStoryEventSubmit>(_onSubmit);
  }

  void _onImageFileChanged(
    CreateEventStoryEventOnImageFileChanged event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          data: state.data.copyWith(
            imageFile: event.imageFile,
          ),
        ),
      ),
    );
  }

  void _onDescriptionChanged(
    CreateEventStoryEventOnDescriptionChanged event,
    Emitter emit,
  ) {
    emit(
      _validate(
        state.copyWith(
          data: state.data.copyWith(
            description: event.description,
          ),
        ),
      ),
    );
  }

  void _onSubmit(CreateEventStoryEventSubmit event, Emitter emit) async {
    final data = state.data;
    final client = getIt<AppGQL>().client;
    final uploadService = FileUploadService(client);
    emit(
      CreateEventStoryState.loading(data: state.data),
    );
    String? imageId = await uploadService.uploadSingleFile(
      data.imageFile,
      FileDirectory.stories,
    );

    if (imageId == null) {
      return emit(
        CreateEventStoryState.failure(data: state.data),
      );
    }

    final updateImageResult =
        await getIt<EventRepository>().updateEventStoryImage(
      input: Variables$Mutation$UpdateEventStoryImage(
        id: imageId,
        description: data.description!,
      ),
    );

    if (updateImageResult.isLeft()) {
      return emit(
        CreateEventStoryState.failure(data: state.data),
      );
    }

    final result = await getIt<EventRepository>().createEventStory(
      input: Input$EventStoryInput(
        event: event.eventId,
        file: imageId,
      ),
    );

    if (result.isLeft()) {
      return emit(
        CreateEventStoryState.failure(data: state.data),
      );
    }

    emit(
      CreateEventStoryState.success(data: state.data),
    );
  }

  CreateEventStoryState _validate(CreateEventStoryState state) {
    final isValid = state.data.description?.trim().isNotEmpty == true &&
        state.data.imageFile != null;
    return state.copyWith(
      data: state.data.copyWith(
        isValid: isValid,
      ),
    );
  }
}

@freezed
class CreateEventStoryEvent with _$CreateEventStoryEvent {
  factory CreateEventStoryEvent.onImageFileChanged({
    required XFile? imageFile,
  }) = CreateEventStoryEventOnImageFileChanged;

  factory CreateEventStoryEvent.onDescriptionChanged({
    required String description,
  }) = CreateEventStoryEventOnDescriptionChanged;

  factory CreateEventStoryEvent.submit({
    required String eventId,
  }) = CreateEventStoryEventSubmit;
}

@freezed
class CreateEventStoryState with _$CreateEventStoryState {
  factory CreateEventStoryState.initial({
    required CreateEventStoryData data,
  }) = CreateEventStoryStateInital;
  factory CreateEventStoryState.loading({
    required CreateEventStoryData data,
  }) = CreateEventStoryStateLoading;
  factory CreateEventStoryState.success({
    required CreateEventStoryData data,
  }) = CreateEventStoryStateSucess;
  factory CreateEventStoryState.failure({
    required CreateEventStoryData data,
  }) = CreateEventStoryStateFailure;
}

@freezed
class CreateEventStoryData with _$CreateEventStoryData {
  factory CreateEventStoryData({
    required bool isValid,
    XFile? imageFile,
    String? description,
  }) = _CreateEventStoryData;
}
