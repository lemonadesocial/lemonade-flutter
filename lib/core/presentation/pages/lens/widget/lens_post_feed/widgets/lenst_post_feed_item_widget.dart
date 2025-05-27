import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_channel_newsfeed_page/widgets/mention_linkifier.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lens_post_item_actions_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:app/app_theme/app_theme.dart';

class LensPostFeedItemWidget extends StatefulWidget {
  final LensPost post;
  final Function()? onTap;
  final bool showActions;
  const LensPostFeedItemWidget({
    super.key,
    required this.post,
    required this.showActions,
    this.onTap,
  });

  @override
  State<LensPostFeedItemWidget> createState() => _LensPostFeedItemWidgetState();
}

class _LensPostFeedItemWidgetState extends State<LensPostFeedItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap?.call();
          return;
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (widget.post.author == null) {
                  return;
                }
                AutoRouter.of(context).push(
                  LensUserProfileRoute(
                    lensAccount: widget.post.author!,
                  ),
                );
              },
              child: LemonNetworkImage(
                width: Sizing.s10,
                height: Sizing.s10,
                borderRadius: BorderRadius.circular(Sizing.medium),
                imageUrl: widget.post.author?.metadata?.picture ?? '',
                placeholder: ImagePlaceholder.avatarPlaceholder(),
              ),
            ),
            SizedBox(width: Spacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (widget.post.quoteOf != null) ...[
                  //   _RePost(post: widget.post),
                  //   SizedBox(height: 4.w),
                  // ],
                  InkWell(
                    onTap: () {
                      if (widget.post.author == null) {
                        return;
                      }
                      AutoRouter.of(context).push(
                        LensUserProfileRoute(
                          lensAccount: widget.post.author!,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.author?.username?.localName ?? '',
                          style: appText.md,
                        ),
                        if (widget.post.timestamp != null)
                          Text(
                            timeago.format(widget.post.timestamp!.toLocal()),
                            style: appText.sm.copyWith(
                              color: appColors.textTertiary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  _PostBody(post: widget.post),
                  if (widget.showActions) ...[
                    SizedBox(height: Spacing.s2_5),
                    LensPostItemActionsWidget(
                      post: widget.post,
                    ),
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

class _PostBody extends StatelessWidget {
  final LensPost post;

  const _PostBody({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.metadata?.content?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.s2_5),
          Linkify(
            text: post.metadata!.content!,
            linkifiers: const [
              EmailLinkifier(),
              UrlLinkifier(),
              FarcasterMentionLinkifier(),
            ],
            linkStyle: appText.md.copyWith(
              color: appColors.textAccent,
              decoration: TextDecoration.none,
            ),
            style: appText.md.copyWith(
              decoration: TextDecoration.none,
            ),
            onOpen: (link) {
              if (link is MentionElement) {
                return;
              }
              launchUrl(Uri.parse(link.url));
            },
          ),
        ],
        if (post.metadata?.imageUrl?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.s2_5),
          LemonNetworkImage(
            imageUrl: post.metadata!.imageUrl!,
            borderRadius: BorderRadius.circular(
              LemonRadius.sm,
            ),
          ),
        ],
        // if (cast.frame != null) ...[
        //   SizedBox(height: Spacing.xSmall),
        //   FarcasterFrameWidget(
        //     initialFrame: cast.frame!,
        //   ),
        // ],
        // if (cast.embeds?.isNotEmpty == true) ...[
        //   SizedBox(height: Spacing.xSmall),
        //   InkWell(
        //     onTap: () {},
        //     child: LemonNetworkImage(
        //       imageUrl: cast.embeds?.firstOrNull?.tryGet('url') ?? '',
        //       borderRadius: BorderRadius.circular(
        //         LemonRadius.small,
        //       ),
        //     ),
        //   ),
        // ],
      ],
    );
  }
}

// class _RePost extends StatelessWidget {
//   const _RePost({
//     required this.post,
//   });

//   final LensPost post;

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final t = Translations.of(context);
//     return Row(
//       children: [
//         ThemeSvgIcon(
//           color: colorScheme.onSecondary,
//           builder: (filter) => Assets.icons.icRetry.svg(
//             colorFilter: filter,
//           ),
//         ),
//         SizedBox(width: 3.w),
//         Text(
//           '${post.quoteOf?.author?.username?.localName ?? ''} ${t.farcaster.recasted}',
//           style: Typo.small.copyWith(
//             color: colorScheme.onSecondary,
//           ),
//         ),
//       ],
//     );
//   }
// }
