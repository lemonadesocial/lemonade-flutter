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
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:app/graphql/lens/post/mutation/lens_add_reaction.graphql.dart';
import 'package:app/graphql/lens/post/mutation/lens_undo_reaction.graphql.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    final numberFormat = NumberFormat.compact();
    final repliesCount = widget.post.stats?.comments ?? 0;
    final hasReplies = repliesCount > 0;
    final reactionsCount = widget.post.stats?.reactions ?? 0;
    final hasLikes = reactionsCount > 0;

    return Column(
      children: [
        Row(
          children: [
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ThemeSvgIcon(
                    color: localLiked
                        ? appColors.textError
                        : appColors.textTertiary,
                    builder: (filter) => localLiked
                        ? Assets.icons.icHeartFillled.svg(
                            colorFilter: filter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          )
                        : Assets.icons.icHeart.svg(
                            colorFilter: filter,
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                  ),
                  SizedBox(width: Spacing.s1_5),
                  if (hasLikes)
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
                        numberFormat.format(reactionsCount),
                        style: appText.sm.copyWith(
                          color: appColors.textTertiary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: Spacing.s4),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icFarcasterReply.svg(
                        colorFilter: filter,
                        width: Sizing.s6,
                        height: Sizing.s6,
                      ),
                    ),
                    SizedBox(width: Spacing.s1_5),
                    if (hasReplies)
                      InkWell(
                        onTap: () {
                          // Go to replies list
                          // showCupertinoModalBottomSheet(
                          //   context: context,
                          //   useRootNavigator: true,
                          //   expand: true,
                          //   backgroundColor: LemonColor.atomicBlack,
                          //   builder: (context) => FarcasterCastRepliesList(
                          //     cast: widget.cast,
                          //   ),
                          // );
                        },
                        child: Text(
                          numberFormat.format(repliesCount),
                          style: appText.sm.copyWith(
                            color: appColors.textTertiary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(width: Spacing.s4),
            InkWell(
              onTap: () async {},
              child: ThemeSvgIcon(
                color: localRecasted
                    ? appColors.textSuccess
                    : appColors.textTertiary,
                builder: (filter) => Assets.icons.icRepost.svg(
                  colorFilter: filter,
                  width: Sizing.s6,
                  height: Sizing.s6,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                SnackBarUtils.showComingSoon();
              },
              child: ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icUpvote.svg(
                  colorFilter: filter,
                  width: Sizing.s6,
                  height: Sizing.s6,
                ),
              ),
            ),
            SizedBox(width: Spacing.small),
            InkWell(
              onTap: () {
                // Share.shareUri(Uri.parse(widget.post.contentUri ?? ''));
              },
              child: ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icShare.svg(
                  colorFilter: filter,
                  width: Sizing.s6,
                  height: Sizing.s6,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
