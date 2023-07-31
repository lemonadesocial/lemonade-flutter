import 'package:app/core/mock_model/chat_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ChannelListItem extends StatelessWidget {
  final ChatRoom room;
  ChannelListItem({required this.room});

  Widget _buildAvatar(ColorScheme colorScheme) {
    bool isPrivateChannel = room.isPrivate ?? false;
    bool isMuted = room.isMuted ?? false;
    var color = isMuted ? colorScheme.onSurface : colorScheme.onPrimary;

    if (isPrivateChannel) {
      var icon = Icons.lock;
      return Container(
        width: 27,
        height: 27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          size: 15,
          color: color,
        ),
      );
    } else {
      return Container(
        width: 27,
        height: 27,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
        child: Center(
          child: Text(
            '#',
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var name = room.name ?? '';
    var isMuted = room.isMuted ?? false;
    var textColor = isMuted ? colorScheme.onSurface : colorScheme.onPrimary;
    return Container(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).navigateNamed('/chat/detail/chatId');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Spacing.extraSmall, horizontal: Spacing.small),
          child: Row(
            children: [
              _buildAvatar(colorScheme),
              SizedBox(
                  width: Spacing
                      .extraSmall), // Add some spacing between avatar and title
              Expanded(
                child: Text(
                  name,
                  style: Typo.medium.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              UnseenMessageCountWidget(room: room),
            ],
          ),
        ),
      ),
    );
  }
}
