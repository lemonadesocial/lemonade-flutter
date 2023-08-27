import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/room_status_extension.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';

class DirectMessageItem extends StatelessWidget {
  const DirectMessageItem({super.key, required this.room});
  final Room room;

  bool get isMuted => room.pushRuleState != PushRuleState.notify;

  String get roomName => room.getLocalizedDisplayname();

  Widget _buildAvatar() {
    final avatarUrl = room.avatar;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: MatrixAvatar(
        client: getIt<MatrixService>().client,
        mxContent: avatarUrl,
        size: 42.w,
        name: roomName,
        fontSize: Typo.small.fontSize!,
        radius: 42.w,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final typingText = room.getLocalizedTypingText(context);
    final ownMessage =
        room.lastEvent?.senderId == getIt<MatrixService>().client.userID;
    final unread = room.isUnread || room.membership == Membership.invite;
    if (typingText.isEmpty && ownMessage && room.lastEvent!.status.isSending) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator.adaptive(strokeWidth: 2),
      );
    }
    if (typingText.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Text(
          typingText,
          style: Typo.small.copyWith(color: colorScheme.onSecondary),
          maxLines: 1,
          softWrap: false,
        ),
      );
    }
    return FutureBuilder<String>(
      future: room.lastEvent?.calcLocalizedBody(MatrixDefaultLocalizations(),
              hideReply: true,
              hideEdit: true,
              plaintextBody: true,
              removeMarkdown: true,
              withSenderNamePrefix: !room.isDirectChat ||
                  room.directChatMatrixID != room.lastEvent?.senderId) ??
          Future.value(t.chat.emptyChat),
      builder: (context, snapshot) {
        return Text(
          room.membership == Membership.invite
              ? t.chat.youAreInvitedToThisChat
              : snapshot.data ??
                  room.lastEvent?.calcLocalizedBodyFallback(
                      MatrixDefaultLocalizations(),
                      hideReply: true,
                      hideEdit: true,
                      plaintextBody: true,
                      removeMarkdown: true,
                      withSenderNamePrefix: !room.isDirectChat ||
                          room.directChatMatrixID !=
                              room.lastEvent?.senderId) ??
                  t.chat.emptyChat,
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: unread ? FontWeight.w600 : null,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            decoration: room.lastEvent?.redacted == true
                ? TextDecoration.lineThrough
                : null,
          ),
        );
      },
    );
    // return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = room.isUnread ? colorScheme.onPrimary : colorScheme.onSurface;

    return Container(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).navigateNamed('/chat/detail/${room.id}');
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomName,
                      style: Typo.medium.copyWith(
                        color: color,
                        fontWeight:
                            room.isUnread ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    _buildSubtitle(context),
                  ],
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
