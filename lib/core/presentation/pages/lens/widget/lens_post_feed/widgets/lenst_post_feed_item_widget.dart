import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_channel_newsfeed_page/widgets/mention_linkifier.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lens_post_item_actions_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
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
              onTap: () {},
              child: LemonNetworkImage(
                width: Sizing.medium,
                height: Sizing.medium,
                borderRadius: BorderRadius.circular(Sizing.medium),
                imageUrl: widget.post.author?.metadata?.picture ?? '',
                placeholder: ImagePlaceholder.avatarPlaceholder(),
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
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
                      // TODO: Lens account profile
                    },
                    child: Row(
                      children: [
                        Text(
                          widget.post.author?.username?.localName ?? '',
                          style: Typo.medium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        if (widget.post.timestamp != null)
                          Text(
                            ' ${timeago.format(widget.post.timestamp!.toLocal())}',
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  _PostBody(post: widget.post),
                  if (widget.showActions) ...[
                    SizedBox(height: Spacing.xSmall),
                    LensPostItemActionsWidget(post: widget.post),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.metadata?.content?.isNotEmpty == true) ...[
          SizedBox(height: 4.w),
          Linkify(
            text: post.metadata!.content!,
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
                return;
              }
              launchUrl(Uri.parse(link.url));
            },
          ),
        ],
        if (post.metadata?.imageUrl?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.xSmall),
          LemonNetworkImage(
            imageUrl: post.metadata!.imageUrl!,
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
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
