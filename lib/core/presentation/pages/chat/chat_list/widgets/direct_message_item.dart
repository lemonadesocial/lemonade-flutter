import 'package:app/core/mock_model/chat_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DirectMessageItem extends StatelessWidget {
  final ChatRoom room;
  DirectMessageItem({required this.room});

  Widget _buildAvatar() {
    var avatarUrl = room.avatarUrl;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: avatarUrl != null
              ? DecorationImage(
                  image: NetworkImage(avatarUrl),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var name = room.name ?? '';
    bool isMuted = room.isMuted ?? false;
    var color = isMuted ? colorScheme.onSurface : colorScheme.onPrimary;
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
              _buildAvatar(),
              SizedBox(
                  width: Spacing
                      .extraSmall), // Add some spacing between avatar and title
              Expanded(
                child: Text(
                  name,
                  style: Typo.medium.copyWith(
                      color: color,
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
