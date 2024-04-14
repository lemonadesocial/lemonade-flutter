import 'package:app/core/domain/chat/entities/guild_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/date_time_extension.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuildRoomItem extends StatelessWidget {
  const GuildRoomItem({super.key, required this.guildRoom});
  final GuildRoom guildRoom;

  Widget _buildAvatar() {
    return MatrixAvatar(
      client: getIt<MatrixService>().client,
      mxContent: null,
      size: 42.w,
      name: guildRoom.title ?? '',
      fontSize: Typo.medium.fontSize!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.extraSmall,
          horizontal: Spacing.small,
        ),
        child: Row(
          children: [
            _buildAvatar(),
            SizedBox(
              width: Spacing.xSmall,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    guildRoom.title ?? '',
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
