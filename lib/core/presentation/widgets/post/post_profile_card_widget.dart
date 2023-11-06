import 'package:app/cache_handlers/update_cache_handlers.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/post/toggle_post_reaction_bloc/toggle_post_reaction_bloc.dart';
import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/domain/report/input/report_input.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/report/report_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/ferry_client.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/__generated__/delete_post.req.gql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slang/builder/model/enums.dart';
import 'package:slang/builder/utils/string_extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:app/graphql/__generated__/post_fragment.data.gql.dart';

class PostProfileCard extends StatelessWidget {
  final GPostFragment post;

  const PostProfileCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReportBloc()),
        BlocProvider(
          create: (context) => TogglePostReactionBloc(
            // defaultReactions: post.reactions,
            defaultReactions: 0,
            defaultHasReaction: post.has_reaction ?? false,
          ),
        ),
      ],
      child: PostProfileCardView(
        post: post,
      ),
    );
  }
}

class PostProfileCardView extends StatelessWidget {
  PostProfileCardView({
    super.key,
    required this.post,
  });

  final client = getIt<FerryClient>().client;

  final GPostFragment post;

  String get postName => post.user_expanded?.name ?? '';

  String get postText => post.text ?? '';

  // Event? get postEvent => post.ref_event;

  DateTime? get postCreatedAt => post.created_at;

  // DbFile? get postFile => post.ref_file;

  // int? get reactions => post.reactions;

  // int? get comments => post.comments;

  // bool? get hasReaction => post.has_reaction;

  onDeletePost(BuildContext context) {
    final authSession = AuthUtils.getUser(context)!;
    final deletePostReq = GDeletePostReq(
      (b) => b
        ..vars.deletePostId = post.G_id.toBuilder()
        ..updateCacheHandlerKey = UpdateCacheHandlerKeys.deletePost
        ..updateCacheHandlerContext = {
          "postId": post.G_id.value,
          "authUserId": authSession.userId
        },
    );
    client.request(deletePostReq).listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);
    final authState = context.watch<AuthBloc>().state;
    final isOwnPost = userId == post.user.value;
    // final togglePostReactionBloc = context.watch<TogglePostReactionBloc>();

    return InkWell(
      onTap: () {
        authState.maybeWhen(
          // authenticated: (_) => AutoRouter.of(context).navigate(
          // PostDetailRoute(
          //   post: post,
          //   togglePostReactionBloc: togglePostReactionBloc,
          // ),
          // ),
          orElse: () => AutoRouter.of(context).navigate(const LoginRoute()),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   onTap: () {
          //     final isMe = AuthUtils.isMe(context, user: post.user_expanded!);
          //     if (isMe) {
          //       AutoRouter.of(context).navigate(const MyProfileRoute());
          //     } else {
          //       AutoRouter.of(context)
          //           .navigate(ProfileRoute(userId: post.user));
          //     }
          //   },
          //   child: LemonCircleAvatar(
          //     size: Sizing.medium,
          //     url: AvatarUtils.getAvatarUrl(user: post.user_expanded),
          //   ),
          // ),
          const SizedBox(width: 9),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text(
                      postName,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.87),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (postCreatedAt != null)
                      Text(
                        '  •  ${timeago.format(postCreatedAt!)}',
                        style: Typo.medium
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showComingSoonDialog(context);
                      },
                      child: isOwnPost
                          ? const SizedBox.shrink()
                          : FloatingFrostedGlassDropdown(
                              offset: Offset(0, -Sizing.xSmall),
                              items: [
                                DropdownItemDpo(
                                  leadingIcon: Assets.icons.icRoundReport.svg(
                                    width: Sizing.xSmall,
                                    height: Sizing.xSmall,
                                  ),
                                  label: t.common.actions.report,
                                  value: "report",
                                  customColor: LemonColor.report,
                                ),
                                DropdownItemDpo(
                                  leadingIcon: Assets.icons.icDelete.svg(
                                    width: Sizing.xSmall,
                                    height: Sizing.xSmall,
                                  ),
                                  label:
                                      t.common.delete.toCase(CaseStyle.pascal),
                                  value: "delete",
                                  customColor: LemonColor.report,
                                ),
                              ],
                              onItemPressed: (item) {
                                if (item?.value == 'delete') {
                                  onDeletePost(context);
                                }
                                if (item?.value == 'report') {
                                  authState.maybeWhen(
                                    authenticated: (_) =>
                                        BottomSheetUtils.showSnapBottomSheet(
                                      context,
                                      builder: (_) {
                                        return BlocProvider.value(
                                          value: context.read<ReportBloc>(),
                                          child: ReportBottomSheet(
                                            onPressReport: (reason) {
                                              context.read<ReportBloc>().add(
                                                    ReportEvent.reportPost(
                                                      input: ReportInput(
                                                        id: post.G_id.value,
                                                        reason: reason,
                                                      ),
                                                    ),
                                                  );
                                            },
                                            title: t.common.report.reportPost,
                                            description: t.common.report
                                                .reportDescription(
                                              reportName:
                                                  t.post.post.toLowerCase(),
                                            ),
                                            placeholder: t.common.report
                                                .reportPlaceholder(
                                              reportName:
                                                  t.post.post.toLowerCase(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    orElse: () => AutoRouter.of(context)
                                        .navigate(const LoginRoute()),
                                  );
                                }
                              },
                              child: ThemeSvgIcon(
                                color: colorScheme.onSurfaceVariant,
                                builder: (filter) =>
                                    Assets.icons.icMoreHoriz.svg(
                                  colorFilter: filter,
                                  width: 18.w,
                                  height: 18.w,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                if (postText.isNotEmpty) ...[
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    postText,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.87),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
                // if (postEvent != null) ...[
                //   SizedBox(height: Spacing.xSmall),
                //   EventPostCard(event: postEvent!),
                // ],
                // if (postFile != null) ...[
                //   SizedBox(height: Spacing.xSmall),
                //   _buildFile(colorScheme, postFile),
                // ],
                // PostCardActions(post: post),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildFile(ColorScheme colorScheme, DbFile? file) {
  //   return Container(
  //     width: double.infinity,
  //     height: 270,
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: colorScheme.outline,
  //       ),
  //       borderRadius: BorderRadius.circular(LemonRadius.xSmall),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(LemonRadius.xSmall),
  //       child: CachedNetworkImage(
  //         imageUrl: ImageUtils.generateUrl(file: file),
  //         fit: BoxFit.cover,
  //         errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
  //         placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
  //       ),
  //     ),
  //   );
  // }
}
