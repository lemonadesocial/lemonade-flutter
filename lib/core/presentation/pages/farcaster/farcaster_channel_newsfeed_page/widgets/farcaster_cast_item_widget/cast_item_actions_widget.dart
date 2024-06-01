import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/domain/farcaster/input/cast_has_reaction_input.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast_reaction.graphql.dart';
import 'package:app/graphql/backend/farcaster/mutation/delete_cast_reaction.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_casts.graphql.dart';
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

class CastItemActionsWidget extends StatefulWidget {
  final Query$GetFarCasterCasts$FarcasterCasts$Cast cast;
  const CastItemActionsWidget({
    super.key,
    required this.cast,
  });

  @override
  State<CastItemActionsWidget> createState() => CastItemActionsWidgetState();
}

class CastItemActionsWidgetState extends State<CastItemActionsWidget> {
  bool localLiked = false;

  @override
  void initState() {
    super.initState();
    checkHasLiked();
  }

  void checkHasLiked() {
    final loggedInUser = AuthUtils.getUser(context);
    getIt<FarcasterRepository>()
        .hasReaction(
          input: CastHasReactionInput(
            fid: loggedInUser?.farcasterUserInfo?.fid?.toInt() ?? 0,
            targetFid: int.parse(widget.cast.fid ?? '0'),
            hash: widget.cast.hash ?? '',
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final numberFormat = NumberFormat.compact();
    final t = Translations.of(context);
    return Flexible(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final parentCastInput = Input$ParentCastInput(
                    fid: double.parse(widget.cast.fid ?? '0'),
                    hash: widget.cast.hash?.replaceFirst('0x', "") ?? '',
                  );
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
              SizedBox(width: Spacing.small),
              InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    CreateFarcasterCastReplyRoute(cast: widget.cast),
                  );
                },
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icChatBubble.svg(
                    colorFilter: filter,
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.xSmall),
          Row(
            children: [
              Text(
                '${numberFormat.format(widget.cast.numberOfReplies)} ${t.farcaster.reply(n: widget.cast.numberOfReplies ?? 0)}',
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Text(
                '${numberFormat.format(widget.cast.numberOfLikes)} ${t.farcaster.like(n: widget.cast.numberOfLikes ?? 0)}',
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Text(
                '/${widget.cast.channel?.channelId}',
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
