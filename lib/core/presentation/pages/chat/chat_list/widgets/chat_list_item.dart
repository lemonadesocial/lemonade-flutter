import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/unseen_message_count_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/date_time_extension.dart';
import 'package:app/core/utils/chat/room_status_extension.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';

class ChatListItem extends StatelessWidget {
  final Room room;
  final EdgeInsets? padding;
  const ChatListItem({
    super.key,
    required this.room,
    this.padding,
  });

  bool get isMuted => room.pushRuleState != PushRuleState.notify;
  bool get isPrivateChannel => room.joinRules == JoinRules.private;
  bool get isChannel => room.directChatMatrixID == null;
  String get roomName => room.getLocalizedDisplayname();

  Widget buildAvatar() {
    final avatarUrl = room.avatar;
    final isDirectChat = room.isDirectChat;
    final presence = room.directChatPresence?.presence;
    final radius = isChannel ? 6.r : 42.r;
    return MatrixAvatar(
      client: getIt<MatrixService>().client,
      mxContent: avatarUrl,
      size: 42.w,
      name: roomName,
      fontSize: Typo.medium.fontSize!,
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
    AutoRouter.of(context).navigateNamed('/chat/detail/${room.id}');
  }

  Widget buildSubtitle(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

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
          style: appText.sm.copyWith(color: appColors.textTertiary),
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
          style: appText.sm.copyWith(
            fontWeight: unread ? FontWeight.w600 : null,
            color: appColors.textTertiary,
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final color =
        room.isUnread ? appColors.textPrimary : appColors.textSecondary;

    return InkWell(
      onTap: () => clickAction(context),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: Spacing.extraSmall,
              horizontal: Spacing.small,
            ),
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
                    style: appText.md.copyWith(
                      color: color,
                      fontWeight: room.isUnread ? FontWeight.w600 : null,
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
                  style: appText.sm.copyWith(color: appColors.textAccent),
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
