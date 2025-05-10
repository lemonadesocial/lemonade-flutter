import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app/graphql/lens/post/mutation/lens_add_reaction.graphql.dart';
import 'package:app/graphql/lens/post/mutation/lens_undo_reaction.graphql.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LensPostItemActionsWidget extends StatefulWidget {
  final LensPost post;
  final Space space;
  const LensPostItemActionsWidget({
    super.key,
    required this.post,
    required this.space,
  });

  @override
  State<LensPostItemActionsWidget> createState() =>
      LensPostItemActionsWidgetState();
}

class LensPostItemActionsWidgetState extends State<LensPostItemActionsWidget> {
  bool localLiked = false;
  bool localRecasted = false;

  @override
  void initState() {
    super.initState();
    checkHasLiked();
    checkHasRecasted();
  }

  void checkHasLiked() {
    setState(() {
      localLiked = widget.post.operations?.hasReacted ?? false;
    });
  }

  void checkHasRecasted() {}

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.compact();
    final repliesCount = widget.post.stats?.comments ?? 0;
    final hasReplies = repliesCount > 0;
    final reactionsCount = widget.post.stats?.reactions ?? 0;
    final hasLikes = reactionsCount > 0;

    return Column(
      children: [
        Row(
          children: [
            BlocBuilder<LensAuthBloc, LensAuthState>(
              builder: (context, state) => InkWell(
                onTap: () async {
                  if (!state.loggedIn ||
                      !state.connected ||
                      state.accountStatus != LensAccountStatus.accountOwner) {
                    final isAuthorized = await showCupertinoModalBottomSheet(
                      backgroundColor: LemonColor.atomicBlack,
                      context: context,
                      useRootNavigator: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      builder: (newContext) {
                        return const LensOnboardingBottomSheet();
                      },
                    );
                    if (!isAuthorized) return;
                  }
                  AutoRouter.of(context).push(
                    CreateLensPostReplyRoute(
                      post: widget.post,
                      space: widget.space,
                    ),
                  );
                },
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icFarcasterReply.svg(
                    colorFilter: filter,
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.small),
            // TODO: Lens - requote
            // InkWell(
            //   onTap: () async {},
            //   child: ThemeSvgIcon(
            //     color: localRecasted
            //         ? LemonColor.malachiteGreen
            //         : colorScheme.onSecondary,
            //     builder: (filter) => Assets.icons.icFarcasterRecast.svg(
            //       colorFilter: filter,
            //       width: 14.w,
            //       height: 14.w,
            //     ),
            //   ),
            // ),
            // SizedBox(width: Spacing.small),
            InkWell(
              onTap: () async {
                // TODO: Lens - handle add reaction
                if (localLiked) {
                  setState(() {
                    localLiked = false;
                  });
                  getIt<LensGQL>().client.mutate$LensUndoReaction(
                        Options$Mutation$LensUndoReaction(
                          variables: Variables$Mutation$LensUndoReaction(
                            request: Input$UndoReactionRequest(
                              post: widget.post.id ?? '',
                              reaction: Enum$PostReactionType.UPVOTE,
                            ),
                          ),
                        ),
                      );
                } else {
                  setState(() {
                    localLiked = true;
                  });
                  getIt<LensGQL>().client.mutate$LensAddReaction(
                        Options$Mutation$LensAddReaction(
                          variables: Variables$Mutation$LensAddReaction(
                            request: Input$AddReactionRequest(
                              post: widget.post.id ?? '',
                              reaction: Enum$PostReactionType.UPVOTE,
                            ),
                          ),
                        ),
                      );
                }
              },
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => localLiked
                    ? ThemeSvgIcon(
                        color: LemonColor.coralReef,
                        builder: (filter) => Assets.icons.icHeartFillled.svg(
                          colorFilter: filter,
                          width: 18.w,
                          height: 18.w,
                        ),
                      )
                    : Assets.icons.icHeart.svg(
                        colorFilter: filter,
                        width: 18.w,
                        height: 18.w,
                      ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                SnackBarUtils.showComingSoon();
              },
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icBookmark.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
            SizedBox(width: Spacing.small),
            // InkWell(
            //   onTap: () {
            // Share.shareUri(Uri.parse(widget.post.contentUri ?? ''));
            //   },
            //   child: ThemeSvgIcon(
            //     color: colorScheme.onSecondary,
            //     builder: (filter) => Assets.icons.icShare.svg(
            //       colorFilter: filter,
            //       width: 18.w,
            //       height: 18.w,
            //     ),
            //   ),
            // ),
          ],
        ),
        if (hasLikes || hasReplies) ...[
          SizedBox(height: Spacing.xSmall),
          Row(
            children: [
              if (hasReplies) ...[
                Text(
                  '${numberFormat.format(repliesCount)} ${t.farcaster.reply(n: repliesCount)}',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
              ],
              if (hasLikes) ...[
                InkWell(
                  onTap: () {
                    // Go to likes list
                    // showCupertinoModalBottomSheet(
                    //   context: context,
                    //   useRootNavigator: true,
                    //   expand: true,
                    //   backgroundColor: LemonColor.atomicBlack,
                    //   builder: (context) => FarcasterCastLikesList(
                    //     cast: widget.cast,
                    //   ),
                    // );
                  },
                  child: Text(
                    '${numberFormat.format(reactionsCount)} ${t.farcaster.like(n: reactionsCount)}',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
