import 'package:app/core/application/post/create_post_bloc/create_post_bloc.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/presentation/pages/create_post/widgets/create_post_event_card_widget.dart';
import 'package:app/core/presentation/pages/event/event_selecting_page.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slang/builder/utils/string_extensions.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';

import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/pages/create_post/widgets/create_post_image_widget.dart';

@RoutePage()
class CreatePostPage extends StatelessWidget {
  const CreatePostPage({
    Key? key,
    required this.onPostCreated,
  }) : super(key: key);

  final ValueChanged<Post> onPostCreated;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final createPostBloc = CreatePostBloc(PostService(getIt<PostRepository>()));

    return BlocProvider<CreatePostBloc>(
      create: (context) => createPostBloc,
      child: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state.status == CreatePostStatus.loading) {
            // showDialog(context: context, builder: Loading.defaultLoading);
          }
          if (state.status == CreatePostStatus.postCreated) {
            onPostCreated(state.newPost!);
            context.router.pop();
          }
          if (state.status == CreatePostStatus.error) {}
        },
        builder: (context, state) {
          final sendDisabled =
              createPostBloc.state.postDescription?.isEmpty ?? true;
          return Scaffold(
            backgroundColor: colorScheme.primary,
            appBar: AppBar(
              leading: const LemonBackButton(),
              actions: [
                Row(
                  children: [
                    FloatingFrostedGlassDropdown(
                      items: <DropdownItemDpo<PostPrivacy>>[
                        DropdownItemDpo(
                          label: PostPrivacy.public.name.capitalize(),
                          value: PostPrivacy.public,
                          leadingIcon: Assets.icons.icPublic.svg(),
                        ),
                        DropdownItemDpo(
                          label: PostPrivacy.followers.name.capitalize(),
                          value: PostPrivacy.followers,
                          leadingIcon: Assets.icons.icFollowers.svg(),
                        ),
                        DropdownItemDpo(
                          label: PostPrivacy.friends.name.capitalize(),
                          value: PostPrivacy.friends,
                          leadingIcon: Assets.icons.icHandshake.svg(),
                        ),
                      ],
                      onItemPressed: (item) =>
                          createPostBloc.onPostPrivacyChange(item!.value!),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: colorScheme.outline,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: Spacing.superExtraSmall,
                          horizontal: Spacing.small,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            postPrivacyIcon(state.postPrivacy),
                            SizedBox(width: Spacing.superExtraSmall),
                            Text(state.postPrivacy.name.capitalize()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Spacing.smMedium),
              ],
              elevation: 0,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Divider(color: colorScheme.outline),
                  SizedBox(height: Spacing.smMedium),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        child: Column(
                          children: [
                            TextFormField(
                              minLines: 5,
                              maxLines: 10,
                              onChanged: createPostBloc.onPostDescriptionChange,
                              cursorColor: colorScheme.onPrimary,
                              decoration: InputDecoration.collapsed(
                                hintText: t.home.whatOnYourMind,
                              ),
                              style: Typo.medium.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            if (state.uploadImage != null)
                              CreatePostImageWidget(
                                imageFile: state.uploadImage!,
                                onDismiss: createPostBloc.onDismissImage,
                              )
                            else
                              const SizedBox.shrink(),
                            SizedBox(height: Spacing.smMedium),
                            if (state.selectEvent != null)
                              CreatePostEventCardWidget(
                                event: state.selectEvent!,
                                onDismiss: () =>
                                    createPostBloc.onEventSelect(null),
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: colorScheme.outline),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.smMedium,
                      vertical: Spacing.extraSmall,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => EventSelectingPage(
                                  onEventTap: (event) {
                                    context.router.pop();
                                    createPostBloc.onEventSelect(event);
                                  },
                                ).show(context),
                                child: ThemeSvgIcon(
                                  color: colorScheme.onSurface,
                                  builder: (filter) => Assets.icons.icHouseParty
                                      .svg(colorFilter: filter),
                                ),
                              ),
                              SizedBox(width: Spacing.medium),

                              // TODO(Ron): Temporary remove since we don't have integration with it yet
                              // Assets.icons.icCrystal.svg(color: LemonColor.white.withOpacity(0.7)),
                              // SizedBox(width: Spacing.medium),
                              // Assets.icons.icTicket.svg(color: LemonColor.white.withOpacity(0.7)),
                              // SizedBox(width: Spacing.medium),
                              // Assets.icons.icPoll.svg(color: LemonColor.white.withOpacity(0.7)),
                              // SizedBox(width: Spacing.medium),
                              InkWell(
                                onTap: createPostBloc.onImagePick,
                                child: ThemeSvgIcon(
                                  color: colorScheme.onSurface,
                                  builder: (filter) => Assets.icons.icCamera
                                      .svg(colorFilter: filter),
                                ),
                              ),
                            ],
                          ),
                        ),
                        state.status == CreatePostStatus.loading
                            ? Container(
                                width: 80.w,
                                height: 36.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Spacing.medium,
                                  vertical: Spacing.superExtraSmall,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.onTertiary,
                                  borderRadius:
                                      BorderRadius.circular(LemonRadius.small),
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 80.w,
                                height: 36.h,
                                child: ElevatedButton(
                                  onPressed: sendDisabled
                                      ? null
                                      : createPostBloc.createNewPost,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        LemonRadius.small,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    backgroundColor: colorScheme.onTertiary,
                                    disabledBackgroundColor:
                                        colorScheme.onSecondaryContainer,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        t.post.post,
                                        style: Typo.medium.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: Spacing.extraSmall),
                                      ThemeSvgIcon(
                                        color: sendDisabled
                                            ? colorScheme.onSurfaceVariant
                                            : colorScheme.onPrimary,
                                        builder: (filter) => Assets
                                            .icons.icSendMessage
                                            .svg(colorFilter: filter),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: Spacing.small),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget postPrivacyIcon(PostPrivacy privacy) {
    switch (privacy) {
      case PostPrivacy.public:
        return Assets.icons.icPublic.svg();
      case PostPrivacy.followers:
        return Assets.icons.icFollowers.svg();
      case PostPrivacy.friends:
        return Assets.icons.icHandshake.svg();
    }
  }
}
