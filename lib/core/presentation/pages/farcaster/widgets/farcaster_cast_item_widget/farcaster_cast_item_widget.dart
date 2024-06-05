import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_cast_item_widget/cast_item_actions_widget.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_channel_newsfeed_page/widgets/mention_linkifier.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class FarcasterCastItemWidget extends StatefulWidget {
  final AirstackFarcasterCast cast;
  final Function()? onTap;
  final bool showActions;
  const FarcasterCastItemWidget({
    super.key,
    required this.cast,
    required this.showActions,
    this.onTap,
  });

  @override
  State<FarcasterCastItemWidget> createState() =>
      _FarcasterCastItemWidgetState();
}

class _FarcasterCastItemWidgetState extends State<FarcasterCastItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                AutoRouter.of(context).push(
                  FarcasterUserProfileRoute(
                    profileName: widget.cast.castedBy?.profileName ?? '',
                  ),
                );
              },
              child: LemonNetworkImage(
                width: Sizing.medium,
                height: Sizing.medium,
                borderRadius: BorderRadius.circular(Sizing.medium),
                imageUrl: widget.cast.castedBy?.profileImage ?? '',
                placeholder: ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.cast.quotedCast?.isNotEmpty == true) ...[
                    _Recast(cast: widget.cast),
                    SizedBox(height: 4.w),
                  ],
                  Row(
                    children: [
                      Text(
                        widget.cast.castedBy?.profileName ?? '',
                        style: Typo.medium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      if (widget.cast.castedAtTimestamp != null)
                        Text(
                          ' ${timeago.format(widget.cast.castedAtTimestamp!.toLocal())}',
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                    ],
                  ),
                  _CastBody(cast: widget.cast),
                  if (widget.showActions) ...[
                    SizedBox(height: Spacing.xSmall),
                    CastItemActionsWidget(cast: widget.cast),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CastBody extends StatelessWidget {
  final AirstackFarcasterCast cast;

  const _CastBody({
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cast.text?.isNotEmpty == true) ...[
          SizedBox(height: 4.w),
          Linkify(
            text: cast.text ?? '',
            linkifiers: const [
              EmailLinkifier(),
              UrlLinkifier(),
              FarcasterMentionLinkifier(),
            ],
            linkStyle: Typo.medium.copyWith(
              color: LemonColor.paleViolet,
              decoration: TextDecoration.none,
            ),
            style: Typo.medium.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              decoration: TextDecoration.none,
            ),
            onOpen: (link) {
              if (link is MentionElement) {
                AutoRouter.of(context).push(
                  FarcasterUserProfileRoute(
                    profileName: link.url,
                  ),
                );
                return;
              }
              launchUrl(Uri.parse(link.url));
            },
          ),
        ],
        if (cast.frame?.imageUrl?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.xSmall),
          LemonNetworkImage(
            imageUrl: cast.frame?.imageUrl ?? '',
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
          ),
        ],
        if (cast.embeds?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.xSmall),
          LemonNetworkImage(
            imageUrl: cast.embeds?.firstOrNull?.tryGet('url') ?? '',
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
          ),
        ],
      ],
    );
  }
}

class _Recast extends StatelessWidget {
  const _Recast({
    required this.cast,
  });

  final AirstackFarcasterCast cast;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      children: [
        ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) => Assets.icons.icRetry.svg(
            colorFilter: filter,
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          '${cast.quotedCast?.firstOrNull?.castedBy?.profileName ?? ''} ${t.farcaster.recasted}',
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
