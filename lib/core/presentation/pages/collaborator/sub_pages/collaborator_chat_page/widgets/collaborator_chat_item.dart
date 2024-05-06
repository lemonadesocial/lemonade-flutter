import 'package:app/core/presentation/pages/chat/chat_list/widgets/chat_list_item.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/core/utils/chat/date_time_extension.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorChatItem extends ChatListItem {
  const CollaboratorChatItem({
    super.key,
    required super.room,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => clickAction(context),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            buildAvatar(),
            SizedBox(
              width: Spacing.xSmall,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  buildSubtitle(context),
                ],
              ),
            ),
            SizedBox(
              width: Spacing.xSmall,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  room.timeCreated.localizedTimeShort(context),
                  style: Typo.small.copyWith(color: LemonColor.paleViolet),
                ),
                SizedBox(
                  height: 4.w,
                ),
                UnseenMessageCountWidget(room: room),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
