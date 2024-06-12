import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/domain/farcaster/input/cast_has_reaction_input.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_cast_likes_list/farcaster_cast_likes_list.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast_reaction.graphql.dart';
import 'package:app/graphql/backend/farcaster/mutation/delete_cast_reaction.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

class CastItemActionsWidget extends StatefulWidget {
  final AirstackFarcasterCast cast;
  const CastItemActionsWidget({
    super.key,
    required this.cast,
  });

  @override
  State<CastItemActionsWidget> createState() => CastItemActionsWidgetState();
}

class CastItemActionsWidgetState extends State<CastItemActionsWidget> {
  bool localLiked = false;
  bool localRecasted = false;

  @override
  void initState() {
    super.initState();
    checkHasLiked();
    checkHasRecasted();
  }

  void checkHasLiked() {
    final loggedInUser = AuthUtils.getUser(context);
    getIt<FarcasterRepository>()
        .hasReaction(
          input: CastHasReactionInput(
            fid: loggedInUser?.farcasterUserInfo?.fid?.toInt() ?? 0,
            targetFid: int.parse(widget.cast.fid ?? '0'),
            hash: widget.cast.hash ?? '',
            reactionType: CheckHasReactionType.like,
          ),
        )
        .then(
          (value) => value.fold((l) => null, (r) {
            if (!mounted) {
              return;
            }
            setState(() {
              localLiked = r;
            });
          }),
        );
  }

  void checkHasRecasted() {
    final loggedInUser = AuthUtils.getUser(context);
    getIt<FarcasterRepository>()
        .hasReaction(
          input: CastHasReactionInput(
            fid: loggedInUser?.farcasterUserInfo?.fid?.toInt() ?? 0,
            targetFid: int.parse(widget.cast.fid ?? '0'),
            hash: widget.cast.hash ?? '',
            reactionType: CheckHasReactionType.recast,
          ),
        )
        .then(
          (value) => value.fold((l) => null, (r) {
            if (!mounted) {
              return;
            }
            setState(() {
              localRecasted = r;
            });
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.compact();
    final hasReplies = (widget.cast.numberOfReplies ?? 0) > 0;
    final hasLikes = (widget.cast.numberOfLikes ?? 0) > 0;
    final parentCastInput = Input$ParentCastInput(
      fid: double.parse(widget.cast.fid ?? '0'),
      hash: widget.cast.hash?.replaceFirst('0x', "") ?? '',
    );
    return Flexible(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    CreateFarcasterCastReplyRoute(cast: widget.cast),
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
              SizedBox(width: Spacing.small),
              InkWell(
                onTap: () async {
                  if (localRecasted) {
                    setState(() {
                      localRecasted = false;
                    });
                    await getIt<FarcasterRepository>().deleteCastReaction(
                      input: Variables$Mutation$DeleteCastReaction(
                        type: Enum$ReactionType.RECAST,
                        targetCastId: parentCastInput,
                      ),
                    );
                  } else {
                    setState(() {
                      localRecasted = true;
                    });
                    await getIt<FarcasterRepository>().createCastReaction(
                      input: Variables$Mutation$CreateCastReaction(
                        type: Enum$ReactionType.RECAST,
                        targetCastId: parentCastInput,
                      ),
                    );
                  }
                },
                child: ThemeSvgIcon(
                  color: localRecasted
                      ? LemonColor.malachiteGreen
                      : colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icFarcasterRecast.svg(
                    colorFilter: filter,
                    width: 14.w,
                    height: 14.w,
                  ),
                ),
              ),
              SizedBox(width: Spacing.small),
              InkWell(
                onTap: () async {
                  if (localLiked) {
                    setState(() {
                      localLiked = false;
                    });
                    await getIt<FarcasterRepository>().deleteCastReaction(
                      input: Variables$Mutation$DeleteCastReaction(
                        type: Enum$ReactionType.LIKE,
                        targetCastId: parentCastInput,
                      ),
                    );
                  } else {
                    setState(() {
                      localLiked = true;
                    });
                    await getIt<FarcasterRepository>().createCastReaction(
                      input: Variables$Mutation$CreateCastReaction(
                        type: Enum$ReactionType.LIKE,
                        targetCastId: parentCastInput,
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
              InkWell(
                onTap: () {
                  Share.shareUri(Uri.parse(widget.cast.url ?? ''));
                },
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icShare.svg(
                    colorFilter: filter,
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
              ),
            ],
          ),
          if (widget.cast.channel != null || hasLikes || hasReplies) ...[
            SizedBox(height: Spacing.xSmall),
            Row(
              children: [
                if (hasReplies) ...[
                  Text(
                    '${numberFormat.format(widget.cast.numberOfReplies)} ${t.farcaster.reply(n: widget.cast.numberOfReplies ?? 0)}',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                ],
                if (hasLikes) ...[
                  InkWell(
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        expand: true,
                        backgroundColor: LemonColor.atomicBlack,
                        builder: (context) => FarcasterCastLikesList(
                          cast: widget.cast,
                        ),
                      );
                    },
                    child: Text(
                      '${numberFormat.format(widget.cast.numberOfLikes)} ${t.farcaster.like(n: widget.cast.numberOfLikes ?? 0)}',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.xSmall),
                ],
                if (widget.cast.channel != null) ...[
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '/${widget.cast.channel?.channelId}',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
