import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_channel_newsfeed_page/widgets/mention_linkifier.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lens_post_item_actions_widget.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lens_post_item_carousel_widget.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lens_post_lemonade_event_thumbnail.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/lens/post/mutation/lens_delete_post.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:app/app_theme/app_theme.dart';

class LensPostFeedItemWidget extends StatefulWidget {
  final LensPost post;
  final bool showActions;
  final bool backOnDelete;
  final Function()? onTap;
  final Function()? onRefresh;

  const LensPostFeedItemWidget({
    super.key,
    required this.post,
    required this.showActions,
    this.backOnDelete = false,
    this.onTap,
    this.onRefresh,
  });

  @override
  State<LensPostFeedItemWidget> createState() => _LensPostFeedItemWidgetState();
}

class _LensPostFeedItemWidgetState extends State<LensPostFeedItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> deletePost(BuildContext context) async {
    final response =
        await showFutureLoadingDialog<QueryResult<Mutation$LensDeletePost>>(
      context: context,
      future: () async {
        return await getIt<LensGQL>().client.mutate$LensDeletePost(
              Options$Mutation$LensDeletePost(
                variables: Variables$Mutation$LensDeletePost(
                  request: Input$DeletePostRequest(
                    post: widget.post.id ?? '',
                  ),
                ),
              ),
            );
      },
    );
    response.result?.parsedData?.deletePost.maybeWhen(
      orElse: () => null,
      deletePostResponse: (postResponse) async {
        final result = await LensUtils.pollTransactionStatus(
          txHash: postResponse.hash,
        );
        if (result is FinishedTransactionStatus) {
          if (widget.backOnDelete) {
            AutoRouter.of(context).pop();
          }
          widget.onRefresh?.call();
        } else {
          SnackBarUtils.showError(
            message: result.maybeWhen(
              orElse: () => '',
              failedTransactionStatus: (reason, _) => reason,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return InkWell(
      onTap: () async {
        if (widget.onTap != null) {
          await widget.onTap?.call();
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
                  Row(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.author?.metadata?.name ??
                                  widget.post.author?.username?.localName ??
                                  '',
                              style: appText.md,
                            ),
                            if (widget.post.timestamp != null)
                              Text(
                                timeago
                                    .format(widget.post.timestamp!.toLocal()),
                                style: appText.sm.copyWith(
                                  color: appColors.textTertiary,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (widget.post.operations?.canDelete?.passed == true)
                        _MoreActions(
                          post: widget.post,
                          onDelete: () => deletePost(context),
                        ),
                    ],
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
        if (post.metadata?.attachedImages.isNotEmpty == true) ...[
          SizedBox(height: Spacing.s2_5),
          LensPostItemCarouselWidget(
            images: post.metadata!.attachedImages,
          ),
        ] else if (post.metadata?.imageUrl?.isNotEmpty == true) ...[
          SizedBox(height: Spacing.s2_5),
          LemonNetworkImage(
            imageUrl: post.metadata!.imageUrl!,
            borderRadius: BorderRadius.circular(
              LemonRadius.sm,
            ),
          ),
        ],
        if (post.metadata?.lemonadeEventLink != null) ...[
          SizedBox(height: Spacing.s2_5),
          LensPostLemonadeEventThumbnail(
            lemonadeEventLink: post.metadata?.lemonadeEventLink,
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

class _MoreActions extends StatelessWidget {
  final Function()? onDelete;
  const _MoreActions({
    required this.post,
    this.onDelete,
  });

  final LensPost post;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    return PopupMenuButton<void>(
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LemonRadius.sm),
        side: BorderSide(color: appColors.cardBorder),
      ),
      clipBehavior: Clip.none,
      menuPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: onDelete,
          child: Row(
            children: [
              ThemeSvgIcon(
                color: appColors.textError,
                builder: (filter) => Assets.icons.icDelete.svg(
                  colorFilter: filter,
                  width: Sizing.s5,
                  height: Sizing.s5,
                ),
              ),
              SizedBox(width: Spacing.s2),
              Text(
                t.common.actions.deletePost,
                style: appText.sm.copyWith(
                  color: appColors.textError,
                ),
              ),
            ],
          ),
        ),
      ],
      child: ThemeSvgIcon(
        color: context.theme.appColors.textSecondary,
        builder: (filter) => Assets.icons.icMoreVertical.svg(
          colorFilter: filter,
          width: Sizing.s5,
          height: Sizing.s5,
        ),
      ),
    );
  }
}
