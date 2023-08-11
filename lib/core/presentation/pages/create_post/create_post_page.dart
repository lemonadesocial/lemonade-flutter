import 'package:app/core/application/post/create_post_bloc/create_post_bloc.dart';
import 'package:app/core/presentation/pages/create_post/widgets/create_post_event_card_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slang/builder/utils/string_extensions.dart';

import '../../../../i18n/i18n.g.dart';
import '../../../../injection/register_module.dart';
import '../../../domain/post/post_repository.dart';
import '../../../service/post/post_service.dart';
import '../../widgets/theme_svg_icon_widget.dart';
import 'widgets/create_post_image_widget.dart';

@RoutePage()
class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final createPostBloc = CreatePostBloc(PostService(getIt<PostRepository>()));

    return BlocProvider<CreatePostBloc>(
      create: (context) => createPostBloc,
      child: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state.status == CreatePostStatus.loading){
            // showDialog(context: context, builder: Loading.defaultLoading);
          }
          if (state.status == CreatePostStatus.postCreated){
            context.router.pop();
          }
          if (state.status == CreatePostStatus.error){

          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colorScheme.primary,
            appBar: AppBar(
              leading: const LemonBackButton(),
              actions: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: createPostBloc.state.postDescription?.isEmpty ?? true
                          ? null
                          : createPostBloc.createNewPost,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.smMedium,
                          vertical: Spacing.superExtraSmall,
                        ),
                        backgroundColor: colorScheme.onTertiary,
                      ),
                      child: Text(
                        t.post.post,
                        style: Typo.medium.copyWith(fontWeight: FontWeight.w700),
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
                  Divider(color: colorScheme.onSurface),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
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
                                onDismiss: () => createPostBloc.onEventSelect(null),
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(color: colorScheme.onSurface),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => context.router.push(
                                  EventSelectingRoute(
                                    onEventTap: (event) {
                                      context.router.pop();
                                      createPostBloc.onEventSelect(event);
                                    },
                                  ),
                                ),
                                child: ThemeSvgIcon(
                                  color: colorScheme.onSurface,
                                  builder: (filter) =>
                                      Assets.icons.icHouseParty.svg(colorFilter: filter),
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
                                  builder: (filter) =>
                                      Assets.icons.icCamera.svg(colorFilter: filter),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () => createPostBloc.onPostPrivacyChange(state.postPrivacy),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: Spacing.superExtraSmall,
                                horizontal: Spacing.small,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Assets.icons.icPublic.svg(),
                                  SizedBox(width: Spacing.superExtraSmall),
                                  Text(state.postPrivacy.name.capitalize()),
                                ],
                              ),
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
}
