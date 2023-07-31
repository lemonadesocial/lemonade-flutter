import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class ChannelListItem extends StatelessWidget {
  final Room room;
  ChannelListItem({required this.room});

  bool get isPrivateChannel => room.joinRules == JoinRules.private;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var name = room.getLocalizedDisplayname();
    var textColor = room.isUnread ? colorScheme.primary : colorScheme.onSurface;
    return Container(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).navigateNamed('/chat/detail/chatId');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Spacing.extraSmall, horizontal: Spacing.small),
          child: Row(
            children: [
              _buildAvatar(colorScheme),
              SizedBox(width: Spacing.extraSmall),
              Expanded(
                child: Text(
                  name,
                  style: Typo.medium.copyWith(
                    color: textColor,
                    fontWeight: room.isUnread ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              UnseenMessageCountWidget(room: room),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    var color =  room.isUnread  ? colorScheme.onPrimary : colorScheme.onSurface;
    if (isPrivateChannel) {
      var icon = Icons.lock;
      return Container(
        width: 27,
        height: 27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.xSmall),
        ),
        child: Icon(
          icon,
          size: Sizing.xSmall,
          color: color,
        ),
      );
    } else {
      return Container(
        width: 27,
        height: 27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.xSmall),
        ),
        child: Center(
          child: Text(
            '#',
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      );
    }
  }
}
