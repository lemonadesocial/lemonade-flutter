import 'package:app/__generated__/schema.schema.gql.dart';
import 'package:app/cache_handlers/update_cache_handlers.dart';
import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/application/post/create_post_bloc/create_post_bloc.dart';
import 'package:app/core/presentation/pages/create_post/widgets/create_post_event_card_widget.dart';
import 'package:app/core/presentation/pages/event/event_selecting_page.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/ferry_client.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/__generated__/create_post.req.gql.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
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
class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  CreatePostPageViewState createState() => CreatePostPageViewState();
}

class CreatePostPageViewState extends State<CreatePostPage> {
  bool _loading = false;
  final client = getIt<FerryClient>().client;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final createPostBloc = CreatePostBloc(PostService(getIt<PostRepository>()));

    onCreatePost() {
      if (kDebugMode) {
        print("onCreatePost");
      }
      setState(() {
        _loading = true;
      });
      final authSession = AuthUtils.getUser(context)!;
      final createPostReq = GCreatePostReq(
        (b) => b
          ..vars.text = createPostBloc.state.postDescription
          ..vars.visibility = GPostVisibility.PUBLIC
          ..vars.ref_type = GPostRefType.EVENT
          ..updateCacheHandlerKey = UpdateCacheHandlerKeys.createPost
          ..updateCacheHandlerContext = {"authUserId": authSession.userId},
      );
      client.request(createPostReq).listen((event) {
        setState(() {
          _loading = false;
        });
        context.router.pop();
      });
    }

    return BlocProvider<CreatePostBloc>(
      create: (context) => createPostBloc,
      child: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state.status == CreatePostStatus.postCreated) {
            context.read<NewsfeedListingBloc>().add(
                  NewsfeedListingEvent.newPostAdded(
                    post: state.newPost!,
                  ),
                );
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
                        SizedBox(
                          width: 72.w,
                          height: 36.h,
                          child: LinearGradientButton(
                            label: t.post.post,
                            onTap: sendDisabled ? null : onCreatePost,
                            trailing: ThemeSvgIcon(
                              color: sendDisabled
                                  ? colorScheme.onSurfaceVariant
                                  : colorScheme.onPrimary,
                              builder: (filter) => Assets.icons.icSendMessage
                                  .svg(colorFilter: filter),
                            ),
                            mode: state.postDescription.isNullOrEmpty
                                ? GradientButtonMode.lavenderDisableMode
                                : GradientButtonMode.lavenderMode,
                            loadingWhen: _loading == true,
                            radius: BorderRadius.circular(LemonRadius.small),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 9.w,
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
