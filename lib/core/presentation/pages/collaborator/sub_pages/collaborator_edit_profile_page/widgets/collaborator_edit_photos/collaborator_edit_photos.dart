import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/remove_icon_wrapper.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/file/file_upload_service.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorEditPhotos extends StatefulWidget {
  const CollaboratorEditPhotos({super.key});

  @override
  State<CollaboratorEditPhotos> createState() => _CollaboratorEditPhotosState();
}

class _CollaboratorEditPhotosState extends State<CollaboratorEditPhotos> {
  Future<void> removeImage({
    required List<String> currentPhotoIds,
    required String imageId,
  }) async {
    await showFutureLoadingDialog(
      context: context,
      future: () {
        return getIt<UserRepository>().updateUser(
          input: Input$UserInput(
            new_photos:
                currentPhotoIds.where((element) => element != imageId).toList(),
          ),
        );
      },
    );
    context.read<UserProfileBloc>().add(
          UserProfileEvent.fetch(
            userId: AuthUtils.getUserId(context),
          ),
        );
  }

  Future<void> addImage({
    required List<String> currentPhotoIds,
  }) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (imageFile == null) {
      return;
    }
    final uploadService = FileUploadService(getIt<AppGQL>().client);
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        final imageId =
            await uploadService.uploadSingleFile(imageFile, FileDirectory.user);
        if (imageId == null) {
          return;
        }
        getIt<UserRepository>().updateUser(
          input: Input$UserInput(
            new_photos: [...currentPhotoIds, imageId],
          ),
        );
      },
    );
    context.read<UserProfileBloc>().add(
          UserProfileEvent.fetch(
            userId: AuthUtils.getUserId(context),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            StringUtils.capitalize(t.common.photo(n: 2)),
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xSmall),
        ),
        BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            final loggedInUserProfile = state.maybeWhen(
              orElse: () => null,
              fetched: (user) => user,
            );
            final currentPhotoIds =
                (loggedInUserProfile?.newPhotosExpanded ?? [])
                    .map((item) => item.id)
                    .where((item) => item != null)
                    .toList()
                    .cast<String>();
            return SliverPadding(
              padding: EdgeInsets.only(right: Spacing.superExtraSmall),
              sliver: SliverGrid.builder(
                itemCount:
                    (loggedInUserProfile?.newPhotosExpanded ?? []).length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Spacing.xSmall,
                  crossAxisSpacing: Spacing.xSmall,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        addImage(currentPhotoIds: currentPhotoIds);
                      },
                      child: DottedBorder(
                        color: colorScheme.outline,
                        borderType: BorderType.RRect,
                        dashPattern: [6.w, 6.w],
                        strokeWidth: 2.w,
                        radius: Radius.circular(LemonRadius.medium),
                        child: Center(
                          child: ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) => Assets.icons.icAdd.svg(
                              colorFilter: filter,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  final photoFile =
                      (loggedInUserProfile?.newPhotosExpanded ?? [])[index - 1];
                  final photoUrl = ImageUtils.generateUrl(file: photoFile);
                  return RemoveIconWrapper(
                    onTap: () => removeImage(
                      currentPhotoIds: currentPhotoIds,
                      imageId: photoFile.id ?? '',
                    ),
                    child: LemonNetworkImage(
                      width: 110.w,
                      height: 110.w,
                      imageUrl: photoUrl,
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(LemonRadius.medium),
                      placeholder: ImagePlaceholder.defaultPlaceholder(),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
