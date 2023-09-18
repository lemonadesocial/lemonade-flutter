import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/date_time_extension.dart';
import 'package:app/core/utils/chat/room_status_extension.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.room});
  final Room room;

  bool get isMuted => room.pushRuleState != PushRuleState.notify;
  bool get isPrivateChannel => room.joinRules == JoinRules.private;
  bool get isChannel => room.directChatMatrixID == null;
  String get roomName => room.getLocalizedDisplayname();

  Widget _buildAvatar() {
    final avatarUrl = room.avatar;
    final isDirectChat = room.isDirectChat;
    final presence = room.directChatPresence?.presence;
    final radius = isChannel ? 6.r : 42.r;
    return MatrixAvatar(
      client: getIt<MatrixService>().client,
      mxContent: avatarUrl,
      size: 42.w,
      name: roomName,
      fontSize: Typo.small.fontSize!,
      radius: radius,
      presence: presence,
      isDirectChat: isDirectChat,
    );
  }

  void clickAction(BuildContext context) async {
    if (room.membership == Membership.invite) {
      final joinResult = await showFutureLoadingDialog(
        context: context,
        future: () async {
          final waitForRoom = room.client.waitForRoomInSync(
            room.id,
            join: true,
          );
          await room.join();
          await waitForRoom;
        },
      );
      if (joinResult.error != null) return;
    }
    print("room.id : ${room.id}");
    AutoRouter.of(context).navigateNamed('/chat/detail/${room.id}');
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
      future: room.lastEvent?.calcLocalizedBody(
            const MatrixDefaultLocalizations(),
            hideReply: true,
            hideEdit: true,
            plaintextBody: true,
            removeMarkdown: true,
            withSenderNamePrefix: !room.isDirectChat ||
                room.directChatMatrixID != room.lastEvent?.senderId,
          ) ??
          Future.value(t.chat.emptyChat),
      builder: (context, snapshot) {
        return Text(
          room.membership == Membership.invite
              ? t.chat.youAreInvitedToThisChat
              : snapshot.data ??
                  room.lastEvent?.calcLocalizedBodyFallback(
                    const MatrixDefaultLocalizations(),
                    hideReply: true,
                    hideEdit: true,
                    plaintextBody: true,
                    removeMarkdown: true,
                    withSenderNamePrefix: !room.isDirectChat ||
                        room.directChatMatrixID != room.lastEvent?.senderId,
                  ) ??
                  t.chat.emptyChat,
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: unread ? FontWeight.w600 : null,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            decoration: room.lastEvent?.redacted ?? false
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

    return InkWell(
      onTap: () => clickAction(context),
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
                  height: 4.h,
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
