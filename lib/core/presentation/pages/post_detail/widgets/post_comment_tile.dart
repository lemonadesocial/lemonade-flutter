import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/common/dialog/report_user_dialog.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
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
    required this.userId,
    required this.userName,
    required this.comment,
    this.createTime,
    this.userAvatar,
  }) : super(key: key);

  final String userId;
  final String userName;
  final DateTime? createTime;
  final String? userAvatar;
  final String comment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final isMe = userId == AuthUtils.getUserId(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.small),
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
                AutoRouter.of(context).navigate(ProfileRoute(userId: userId));
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
                      userName,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.87),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (createTime != null)
                      Text(
                        '  •  ${timeago.format(createTime!)}',
                        style: Typo.medium
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    const Spacer(),
                    FloatingFrostedGlassDropdown(
                      items: <DropdownItemDpo<CommentMenuOption>>[
                        if (isMe) ...[
                          DropdownItemDpo<CommentMenuOption>(
                            label: t.profile.editComment,
                            value: CommentMenuOption.editComment,
                          ),
                          DropdownItemDpo<CommentMenuOption>(
                            label: t.profile.deleteComment,
                            value: CommentMenuOption.deleteComment,
                            customColor: LemonColor.menuRed,
                          ),
                        ] else ...[
                          DropdownItemDpo<CommentMenuOption>(
                            label: t.profile.viewProfile,
                            value: CommentMenuOption.viewProfile,
                          ),
                          DropdownItemDpo<CommentMenuOption>(
                            label: t.profile.reportProfile,
                            value: CommentMenuOption.report,
                            customColor: LemonColor.menuRed,
                          ),
                        ],
                      ],
                      onItemPressed: (item) {
                        switch (item?.value) {
                          case CommentMenuOption.report:
                            ReportUserDialog(
                              userId: userId,
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
                        color: colorScheme.onPrimary,
                        builder: (filter) =>
                            Assets.icons.icMoreHoriz.svg(colorFilter: filter),
                      ),
                    ),
                  ],
                ),
                if (comment.isNotEmpty) ...[
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    comment,
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
