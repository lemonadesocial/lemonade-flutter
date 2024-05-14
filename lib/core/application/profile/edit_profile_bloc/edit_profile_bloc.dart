import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/setting/enums/notification_type.dart';
import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

part 'edit_profile_bloc.freezed.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState.initial()) {
    on<EditProfileEventSelectProfileImage>(selectProfileImage);
    on<EditProfileEventShortBioChange>(onShortBioChange);
    on<EditProfileEventDisplayNameChange>(onDisplayNameChange);
    on<EditProfileEventTaglineChange>(onTaglineChange);
    on<EditProfileEventJobTitleChange>(onJobTitleChange);
    on<EditProfileEventOrganizationChange>(onOrganizationChange);
    on<EditProfileEventEducationChange>(onEducationChange);
    on<EditProfileEventGenderSelect>(onGenderSelect);
    on<EditProfileEventIndustrySelect>(onIndustrySelect);
    on<EditProfileEventEthnicitySelect>(onEthnicitySelect);
    on<EditProfileEventUsernameChange>(onUsernameChange);
    on<EditProfileEventBirthdayChange>(onBirthDayChange);
    on<EditProfileEventTwitterChange>(onTwitterChange);
    on<EditProfileEventLinkedinChange>(onLinkedinChange);
    on<EditProfileEventInstagramChange>(onInstagramChange);
    on<EditProfileEventFarcasterChange>(onFarcasterChange);
    on<EditProfileEventGithubChange>(onGithubChange);
    on<EditProfileEventLensChange>(onLensChange);
    on<EditProfileEventMirrorChange>(onMirrorChange);

    on<EditProfileEventMapNotificationType>(mapNotificationType);
    on<EditProfileEventNotificationCheck>(onNotificationCheck);
    on<EditProfileEventSubmitEditProfile>(submitEditProfile);
  }

  final userRepository = getIt<UserRepository>();
  final notificationMap = <NotificationSettingType, bool>{};

  String? mImageId;
  List<String> _profilePhotos = [];

  Future<void> selectProfileImage(
    EditProfileEventSelectProfileImage event,
    Emitter<EditProfileState> emit,
  ) async {
    _profilePhotos = event.profilePhotos;
    final pickImage = await getImageFromGallery(cropRequired: true);
    if (pickImage != null) {
      emit(
        state.copyWith(
          status: EditProfileStatus.editing,
          profilePhoto: pickImage,
        ),
      );
    }
  }

  Future<void> onShortBioChange(
    EditProfileEventShortBioChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        shortBio: event.input.trim(),
      ),
    );
  }

  Future<void> onDisplayNameChange(
    EditProfileEventDisplayNameChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        displayName: event.input.trim(),
      ),
    );
  }

  Future<void> onTaglineChange(
    EditProfileEventTaglineChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        tagline: event.input.trim(),
      ),
    );
  }

  Future<void> onJobTitleChange(
    EditProfileEventJobTitleChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        jobTitle: event.input.trim(),
      ),
    );
  }

  Future<void> onOrganizationChange(
    EditProfileEventOrganizationChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        companyName: event.input.trim(),
      ),
    );
  }

  Future<void> onEducationChange(
    EditProfileEventEducationChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        education: event.input.trim(),
      ),
    );
  }

  Future<void> onGenderSelect(
    EditProfileEventGenderSelect event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        gender: event.gender?.trim(),
        status: EditProfileStatus.editing,
      ),
    );
  }

  Future<void> onIndustrySelect(
    EditProfileEventIndustrySelect event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        industry: event.industry?.trim(),
      ),
    );
  }

  Future<void> onEthnicitySelect(
    EditProfileEventEthnicitySelect event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        ethnicity: event.ethnicity?.trim(),
      ),
    );
  }

  Future<void> onUsernameChange(
    EditProfileEventUsernameChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        username: event.input.trim(),
      ),
    );
  }

  Future<void> onBirthDayChange(
    EditProfileEventBirthdayChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        dob: event.input,
      ),
    );
  }

  Future<void> onTwitterChange(
    EditProfileEventTwitterChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        handleTwitter: event.input,
      ),
    );
  }

  Future<void> onLinkedinChange(
    EditProfileEventLinkedinChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        handleLinkedin: event.input,
      ),
    );
  }

  Future<void> onInstagramChange(
    EditProfileEventInstagramChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        handleInstagram: event.input,
      ),
    );
  }

  Future<void> onFarcasterChange(
    EditProfileEventFarcasterChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        handleFarcaster: event.input,
      ),
    );
  }

  Future<void> onGithubChange(
    EditProfileEventGithubChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        handleGithub: event.input,
      ),
    );
  }

  Future<void> onLensChange(
    EditProfileEventLensChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        handleLens: event.input,
      ),
    );
  }

  Future<void> onMirrorChange(
    EditProfileEventMirrorChange event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        handleMirror: event.input,
      ),
    );
  }

  Future<void> mapNotificationType(
    EditProfileEventMapNotificationType event,
    Emitter<EditProfileState> emit,
  ) async {
    for (final type in NotificationSettingType.values) {
      notificationMap.putIfAbsent(
        type,
        () => event.notificationFilterString.any(
          (filter) => filter.startsWith('${type.name}_'),
        ),
      );
    }
    emit(state.copyWith(notificationMap: notificationMap));
  }

  Future<void> onNotificationCheck(
    EditProfileEventNotificationCheck event,
    Emitter<EditProfileState> emit,
  ) async {
    final newMap =
        Map<NotificationSettingType, bool>.from(state.notificationMap!);
    newMap[event.type] = !state.notificationMap![event.type]!;

    emit(
      state.copyWith(
        status: EditProfileStatus.editing,
        notificationMap: newMap,
      ),
    );
  }

  Future<void> clearState(
    EditProfileEventClearState event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.initial));
  }

  Future<void> uploadImage(
    Emitter<EditProfileState> emit,
  ) async {
    final client = getIt<AppGQL>().client;
    final fileUploadService = FileUploadService(client);
    try {
      String? imageId = await fileUploadService.uploadSingleFile(
        state.profilePhoto,
        FileDirectory.user,
      );
      if (imageId != null) {
        mImageId = imageId;
      }
    } catch (e) {
      debugPrint('Error uploading file: $e');
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
        ),
      );
    }
  }

  Future<void> submitEditProfile(
    EditProfileEventSubmitEditProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.loading,
      ),
    );
    if (state.profilePhoto != null) {
      await uploadImage(emit);
    }
    final notificationFilterInput = <NotificationFilterInput>[];
    state.notificationMap?.forEach((type, value) {
      if (value) {
        notificationFilterInput.addAll(
          type.notificationDetail
              .map((e) => NotificationFilterInput(type: e))
              .toList(),
        );
      }
    });
    final response = await userRepository.updateUser(
      input: Input$UserInput(
        username: state.username,
        pronoun: state.pronoun?.pronoun,
        display_name: state.displayName,
        tagline: state.tagline,
        description: state.shortBio,
        job_title: state.jobTitle,
        education_title: state.education,
        industry: state.industry,
        new_gender: state.gender,
        ethnicity: state.ethnicity,
        company_name: state.companyName,
        new_photos: mImageId != null ? [mImageId!, ..._profilePhotos] : null,
        // notification_filters:
        //     notificationFilterInput.isEmpty ? null : notificationFilterInput,
        date_of_birth: state.dob,
        handle_twitter: state.handleTwitter,
        handle_instagram: state.handleInstagram,
        handle_farcaster: state.handleFarcaster,
        handle_github: state.handleGithub,
        handle_lens: state.handleLens,
        handle_linkedin: state.handleLinkedin,
        handle_mirror: state.handleMirror,
      ),
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          status: EditProfileStatus.error,
        ),
      ),
      (success) {
        if (success) {
          emit(
            state.copyWith(
              status: EditProfileStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: EditProfileStatus.error,
            ),
          );
        }
      },
    );
  }
}
