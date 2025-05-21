import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class GuildRoomItem extends StatelessWidget {
  const GuildRoomItem({
    super.key,
    required this.guildRoom,
    required this.onTap,
  });
  final GuildRoom guildRoom;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.extraSmall,
          horizontal: Spacing.small,
        ),
        child: Row(
          children: [
            MatrixAvatar(
              client: getIt<MatrixService>().client,
              mxContent: null,
              size: 42.w,
              name: guildRoom.title ?? '',
              fontSize: appText.md.fontSize!,
            ),
            SizedBox(
              width: Spacing.xSmall,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    guildRoom.title ?? '',
                    style: appText.md.copyWith(
                      color: appColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
