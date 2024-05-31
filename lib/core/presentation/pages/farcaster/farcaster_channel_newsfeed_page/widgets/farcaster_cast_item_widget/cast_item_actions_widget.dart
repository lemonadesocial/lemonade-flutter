import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/domain/farcaster/input/cast_has_reaction_input.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast_reaction.graphql.dart';
import 'package:app/graphql/backend/farcaster/mutation/delete_cast_reaction.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_casts.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

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
            setState(() {
              localLiked = r;
            });
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Flexible(
      child: Row(
        children: [
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icChatBubble.svg(
              colorFilter: filter,
              width: Sizing.small,
              height: Sizing.small,
            ),
          ),
          // TODO: currently airstack data is not correct
          // Text(
          //   ' ${numberFormat.format(widget.cast.numberOfReplies)}',
          //   style: Typo.medium.copyWith(
          //     color: colorScheme.onSecondary,
          //   ),
          // ),
          SizedBox(width: Spacing.small),
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
                        width: Sizing.small,
                        height: Sizing.small,
                      ),
                    )
                  : Assets.icons.icHeart.svg(
                      colorFilter: filter,
                      width: Sizing.small,
                      height: Sizing.small,
                    ),
            ),
          ),
          // TODO: currently airstack data is not correct
          // Text(
          //   ' ${numberFormat.format(widget.cast.numberOfLikes)}',
          //   style: Typo.medium.copyWith(
          //     color: colorScheme.onSecondary,
          //   ),
          // ),
        ],
      ),
    );
  }
}
