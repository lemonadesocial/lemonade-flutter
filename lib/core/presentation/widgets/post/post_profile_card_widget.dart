import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/post/toggle_post_reaction_bloc/toggle_post_reaction_bloc.dart';
import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/report/input/report_input.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/event/event_post_card_widget.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/post/post_card_actions_widget.dart';
import 'package:app/core/presentation/widgets/report/report_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/modal_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostProfileCard extends StatelessWidget {
  final Post post;
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
            defaultReactions: post.reactions ?? 0,
            defaultHasReaction: post.hasReaction ?? false,
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
  const PostProfileCardView({
    super.key,
    required this.post,
  });

  final Post post;

  String get postName => post.userExpanded?.name ?? t.common.anonymousLemon;

  String get postText => post.text ?? '';

  Event? get postEvent => post.refEvent;

  DateTime? get postCreatedAt => post.createdAt;

  DbFile? get postFile => post.refFile;

  int? get reactions => post.reactions;

  int? get comments => post.comments;

  bool? get hasReaction => post.hasReaction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);
    final authState = context.watch<AuthBloc>().state;
    final isOwnPost = userId == post.user;
    final togglePostReactionBloc = context.watch<TogglePostReactionBloc>();

    return InkWell(
      onTap: () {
        authState.maybeWhen(
          authenticated: (_) => AutoRouter.of(context).navigate(
            PostDetailRoute(
              post: post,
              togglePostReactionBloc: togglePostReactionBloc,
            ),
          ),
          orElse: () => AutoRouter.of(context).navigate(const LoginRoute()),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              final isMe = AuthUtils.isMe(context, user: post.userExpanded!);
              if (isMe) {
                AutoRouter.of(context).navigate(const MyProfileRoute());
              } else {
                AutoRouter.of(context)
                    .navigate(ProfileRoute(userId: post.user));
              }
            },
            child: LemonCircleAvatar(
              size: Sizing.medium,
              url: AvatarUtils.getAvatarUrl(user: post.userExpanded),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              ],
                              onItemPressed: (item) {
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
                                                        id: post.id,
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
                if (postEvent != null) ...[
                  SizedBox(height: Spacing.xSmall),
                  EventPostCard(event: postEvent!),
                ],
                if (postFile != null) ...[
                  SizedBox(height: Spacing.xSmall),
                  _buildFile(colorScheme, postFile),
                ],
                PostCardActions(post: post),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFile(ColorScheme colorScheme, DbFile? file) {
    return Container(
      width: double.infinity,
      height: 270,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(LemonRadius.xSmall),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.xSmall),
        child: CachedNetworkImage(
          imageUrl: ImageUtils.generateUrl(file: file),
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
          placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
        ),
      ),
    );
  }
}
