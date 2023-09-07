import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/presentation/widgets/event/event_post_card_widget.dart';
import 'package:app/core/presentation/widgets/hero_image_viewer_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostProfileCard extends StatelessWidget {
  const PostProfileCard({
    super.key,
    required this.post,
  });
  final Post post;

  String get postName => post.userExpanded?.name ?? '';

  String get postText => post.text ?? '';

  Event? get postEvent => post.refEvent;

  DateTime? get postCreatedAt => post.createdAt;

  DbFile? get postFile => post.refFile;

  int? get reactions => post.reactions;

  int? get comments => post.comments;

  bool? get hasReaction => post.hasReaction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            final isMe = AuthUtils.isMe(context, user: post.userExpanded!);
            if (isMe) {
              AutoRouter.of(context).navigate(const MyProfileRoute());
            } else {
              AutoRouter.of(context).navigate(ProfileRoute(userId: post.user));
            }
          },
          child: LemonCircleAvatar(
            size: Sizing.medium,
            url: AvatarUtils.getAvatarUrl(user: post.userExpanded),
          ),
        ),
        const SizedBox(width: 9),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    postName,
                    style: Typo.medium.copyWith(
                      color: LemonColor.white87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (postCreatedAt != null)
                    Text(
                      '  •  ${timeago.format(postCreatedAt!)}',
                      style: Typo.medium
                          .copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  const Spacer(),
                  ThemeSvgIcon(
                    color: colorScheme.onSurfaceVariant,
                    builder: (filter) => Assets.icons.icMoreHoriz.svg(
                      colorFilter: filter,
                      width: 18.w,
                      height: 18.w,
                    ),
                  ),
                ],
              ),
              if (postText.isNotEmpty) ...[
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  postText,
                  style: Typo.medium.copyWith(
                    color: LemonColor.white87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
              if (postEvent != null) ...[
                SizedBox(height: Spacing.xSmall),
                EventPostCard(event: postEvent!),
              ],
              if (postFile != null) ...[
                SizedBox(height: Spacing.xSmall),
                _buildFile(colorScheme, postFile),
              ],
              _buildActions(colorScheme)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFile(ColorScheme colorScheme, DbFile? file) {
    return Container(
      width: double.infinity,
      height: 270,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(LemonRadius.xSmall),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.xSmall),
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

  Widget _buildActions(ColorScheme colorScheme) {
    final svgIcon = hasReaction ?? false
        ? ThemeSvgIcon(
            builder: (filter) => Assets.icons.icHeartFillled.svg(
              width: 18.w,
              height: 18.w,
            ),
          )
        : ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icHeart.svg(
              colorFilter: filter,
              width: 18.w,
              height: 18.w,
            ),
          );
    return Padding(
      padding: EdgeInsets.only(top: Spacing.xSmall),
      child: Row(
        children: [
          Row(
            children: [
              svgIcon,
              const SizedBox(width: 3),
              Text(
                reactions != null ? '$reactions' : '',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          SizedBox(width: Spacing.xSmall),
          Row(
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icMessage.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                comments != null ? '$comments' : '',
                style: Typo.small.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
          const Spacer(),
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icShare.svg(
              colorFilter: filter,
              width: 18.w,
              height: 18.w,
            ),
          ),
        ],
      ),
    );
  }
}
