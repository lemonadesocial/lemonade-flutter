import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class DirectMessageItem extends StatelessWidget {
  final Room room;
  DirectMessageItem({required this.room});

  bool get isMuted => room.pushRuleState != PushRuleState.notify;

  String get roomName => room.getLocalizedDisplayname();

  Widget _buildAvatar() {
    var avatarUrl = room.avatar;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: MatrixAvatar(
        client: getIt<MatrixService>().client,
        mxContent: avatarUrl,
        size: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var color = room.isUnread ? colorScheme.onPrimary : colorScheme.onSurface;

    return Container(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).navigateNamed('/chat/detail/chatId');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Spacing.extraSmall, horizontal: Spacing.small),
          child: Row(
            children: [
              _buildAvatar(),
              SizedBox(width: Spacing.extraSmall), // Add some spacing between avatar and title
              Expanded(
                child: Text(
                  roomName,
                  style: Typo.medium.copyWith(
                    color: color,
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
}
