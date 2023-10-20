import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/common/dialog/report_user_dialog.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCommentTile extends StatelessWidget {
  const PostCommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);
  final PostComment comment;

  String? get username => comment.userExpanded?.username;

  String? get userAvatar {
    if (comment.userExpanded?.newPhotosExpanded == null ||
        comment.userExpanded!.newPhotosExpanded!.isEmpty) {
      return '';
    }
    return ImageUtils.generateUrl(
      file: comment.userExpanded?.newPhotosExpanded!.first,
      imageConfig: ImageConfig.userPhoto,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final isMe = comment.user == AuthUtils.getUserId(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.small,
        horizontal: Spacing.extraSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (isMe) {
                AutoRouter.of(context).navigate(const MyProfileRoute());
              } else {
                AutoRouter.of(context)
                    .navigate(ProfileRoute(userId: comment.user ?? ''));
              }
            },
            child: LemonCircleAvatar(
              size: Sizing.medium,
              url: userAvatar ?? '',
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username ?? '',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.87),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (comment.createdAt != null)
                      Text(
                        '  •  ${timeago.format(comment.createdAt!)}',
                        style: Typo.medium
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    const Spacer(),
                    FloatingFrostedGlassDropdown(
                      offset: Offset(0, -Spacing.small),
                      items: <DropdownItemDpo<CommentMenuOption>>[
                        DropdownItemDpo<CommentMenuOption>(
                          label: t.profile.reportProfile,
                          value: CommentMenuOption.report,
                          customColor: LemonColor.report,
                        ),
                      ],
                      onItemPressed: (item) {
                        switch (item?.value) {
                          case CommentMenuOption.report:
                            ReportUserDialog(
                              userId: comment.user ?? '',
                            ).showAsBottomSheet(
                              context,
                              heightFactor: 0.79,
                            );
                            break;
                          default:
                            break;
                        }
                      },
                      child: ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) =>
                            Assets.icons.icMoreHoriz.svg(colorFilter: filter),
                      ),
                    ),
                  ],
                ),
                if (comment.text?.isNotEmpty == true) ...[
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    comment.text!,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.87),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum CommentMenuOption {
  viewProfile,
  report,
  editComment,
  deleteComment,
}
