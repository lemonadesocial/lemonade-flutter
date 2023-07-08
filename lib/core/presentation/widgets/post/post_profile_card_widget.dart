import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/presentation/widgets/event/event_post_card_widget.dart';
import 'package:app/core/presentation/widgets/hero_image_viewer_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostProfileCard extends StatelessWidget {
  final Post post;
  const PostProfileCard({
    super.key,
    required this.post,
  });

  DbFile? get postUserAvatar =>
      post.userExpanded?.newPhotosExpanded?.isNotEmpty == true ? post.userExpanded!.newPhotosExpanded![0] : null;

  String get postUsername => post.userExpanded?.username ?? '';

  String get postText => post.text ?? '';

  Event? get postEvent => post.refEvent;

  DateTime? get postCreatedAt => post.createdAt;

  DbFile? get postFile => post.refFile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Card left
          LemonCircleAvatar(
            size: Sizing.medium,
            url: ImageUtils.generateUrl(file: postUserAvatar),
          ),
          SizedBox(width: Spacing.xSmall),
          // Card right
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(postUsername),
                    if (postCreatedAt != null)
                      Text(
                        ' • ${timeago.format(postCreatedAt!)}',
                        style: Typo.medium.copyWith(color: colorScheme.onSurface),
                      ),
                    Spacer(),
                    ThemeSvgIcon(
                      color: colorScheme.onSurface,
                      builder: (filter) => Assets.icons.icMoreHoriz.svg(colorFilter: filter),
                    ),
                  ],
                ),
                if (postText.isNotEmpty) ...[
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    postText,
                    style: Typo.medium.copyWith(color: colorScheme.onSurface),
                  ),
                ],
                if (postEvent != null) ...[
                  SizedBox(height: Spacing.superExtraSmall),
                  EventPostCard(event: postEvent!),
                ],
                if (postFile != null) ...[
                  SizedBox(height: Spacing.superExtraSmall),
                  _buildFile(colorScheme, postFile),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildFile(ColorScheme colorScheme, DbFile? file) {
    return Container(
      width: double.infinity,
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        border: Border.all(color: colorScheme.outline),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        child: HeroImageViewer(
          tag: file?.key ?? '',
          imageUrl: ImageUtils.generateUrl(file: file),
          child: CachedNetworkImage(
            imageUrl: ImageUtils.generateUrl(file: file),
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => ImagePlaceholder.defaultPlaceholder(),
            placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
          ),
        ),
      ),
    );
  }
}
