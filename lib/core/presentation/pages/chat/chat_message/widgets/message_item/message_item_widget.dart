import 'package:app/core/presentation/pages/chat/chat_message/widgets/message_item/message_content_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/message_item/state_message_item_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/matrix_date_time_extension.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';

class MessageItem extends StatelessWidget {
  final Event event;
  final Event? nextEvent;
  final bool displayReadMarker;
  final void Function(Event)? onSelect;
  final void Function(Event)? onAvatarTab;
  final void Function(Event)? onInfoTab;
  final void Function(String)? scrollToEventId;
  final bool longPressSelect;
  final bool selected;
  final Timeline timeline;
  final client = getIt<MatrixService>().client;

  MessageItem(
    this.event, {
    this.nextEvent,
    this.displayReadMarker = false,
    this.longPressSelect = false,
    this.onSelect,
    this.onInfoTab,
    this.onAvatarTab,
    this.scrollToEventId,
    this.selected = false,
    required this.timeline,
    Key? key,
  }) : super(key: key);

  Event get displayEvent => event.getDisplayEvent(timeline);

  bool get ownMessage => event.senderId == client.userID;

  bool get shouldDisplayTime =>
      event.type == EventTypes.RoomCreate ||
      nextEvent == null ||
      // check if 2 time close enough
      !event.originServerTs.sameEnvironment(nextEvent!.originServerTs);

  bool get sameSender =>
      nextEvent != null &&
      [
        EventTypes.Message,
        EventTypes.Sticker,
        EventTypes.Encrypted,
      ].contains(nextEvent!.type) &&
      nextEvent?.relationshipType == null &&
      nextEvent!.senderId == event.senderId &&
      !shouldDisplayTime;

  double get columnWidth => 360;

  bool get noBubble =>
      {
        MessageTypes.Video,
        MessageTypes.Image,
        MessageTypes.Sticker,
      }.contains(event.messageType) &&
      !event.redacted;

  bool get noPadding => {
        MessageTypes.File,
        MessageTypes.Audio,
      }.contains(event.messageType);

  Alignment get alignment => ownMessage ? Alignment.topRight : Alignment.topLeft;

  MainAxisAlignment get rowMainAxisAlignment => ownMessage ? MainAxisAlignment.end : MainAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    if (!{
      EventTypes.Message,
      EventTypes.Sticker,
      EventTypes.Encrypted,
      EventTypes.CallInvite,
    }.contains(event.type)) {
      return _buildStateMessage();
    }

    if (event.type == EventTypes.Message && event.messageType == EventTypes.KeyVerificationRequest) {
      return _buildVerificationRequestContent();
    }

    return _buildMessage(context);
  }

  Widget _buildMessage(BuildContext context) {
    final messageBody = _buildMessageBody(context);
    Widget container;
    if (event.hasAggregatedEvents(timeline, RelationshipTypes.reaction) ||
        shouldDisplayTime ||
        selected ||
        displayReadMarker) {
      container = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: ownMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (shouldDisplayTime || selected) _buildMessageSentTime(context),
          messageBody,
          //TODO: if (event.hasAggregatedEvents(timeline, RelationshipTypes.reaction)) _buildMessageReaction(),
          if (displayReadMarker) _buildMessageReadMarker(context),
        ],
      );
    } else {
      container = messageBody;
    }

    if (event.messageType == MessageTypes.BadEncrypted || event.redacted) {
      container = Opacity(opacity: 0.33, child: container);
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 100 * 2.5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: container,
      ),
    );
  }

  Row _buildMessageBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var bodyColor = ownMessage ? colorScheme.primaryContainer : colorScheme.secondaryContainer;
    final textColor = ownMessage ? colorScheme.onPrimary : colorScheme.onSurface;
    final borderRadius = BorderRadius.only(
      topLeft: !ownMessage ? const Radius.circular(4) : Radius.circular(LemonRadius.extraSmall),
      topRight: Radius.circular(LemonRadius.extraSmall),
      bottomLeft: Radius.circular(LemonRadius.extraSmall),
      bottomRight: ownMessage ? Radius.circular(4) : Radius.circular(LemonRadius.extraSmall),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: rowMainAxisAlignment,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildSenderAvatar(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: alignment,
                padding: EdgeInsets.only(left: sameSender ? 0 : 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: noBubble ? Colors.transparent : bodyColor,
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                  ),
                  padding: noBubble || noPadding
                      ? EdgeInsets.zero
                      : EdgeInsets.symmetric(
                          horizontal: Spacing.xSmall,
                          vertical: Spacing.extraSmall,
                        ),
                  constraints: BoxConstraints(
                    maxWidth: columnWidth * 1.5,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onLongPress: !longPressSelect ? null : () => onSelect!(event),
                    borderRadius: borderRadius,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (event.relationshipType == RelationshipTypes.reply) _buildRepliedMessage(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              flex: 6,
                              child: MessageContent(
                                displayEvent,
                                textColor: textColor,
                                onInfoTab: onInfoTab,
                              ),
                            ),
                            SizedBox(width: Spacing.superExtraSmall),
                            Flexible(
                              flex: 1,
                              child: 
                              _buildMessageEditTime(colorScheme.onSurfaceVariant)
                            )
                            
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageReadMarker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Theme.of(context).colorScheme.primary),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Text(
            'read up to here',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        Expanded(
          child: Divider(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Padding _buildMessageReaction() {
    return Padding(
      padding: EdgeInsets.only(
        top: 4.0,
        left: (ownMessage ? 0 : MatrixAvatar.defaultSize) + 12.0,
        right: 12.0,
      ),
      // child: MessageReactions(event, timeline),
      child: Text("Message reaction"),
    );
  }

  Widget _buildMessageSentTime(BuildContext context) {
    return Padding(
      padding: shouldDisplayTime
          ? EdgeInsets.symmetric(
              vertical: Spacing.extraSmall
            )
          : EdgeInsets.zero,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: shouldDisplayTime
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.background.withOpacity(0.33),
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.all(Spacing.superExtraSmall),
            child: Text(
              DateFormatUtils.fullDateWithTime(event.originServerTs),
              style: Typo.small.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<Event?> _buildRepliedMessage() {
    return FutureBuilder<Event?>(
      future: event.getReplyEvent(timeline),
      builder: (BuildContext context, snapshot) {
        final replyEvent = snapshot.hasData
            ? snapshot.data
            : Event(
                eventId: event.relationshipEventId!,
                content: {'msgtype': 'm.text', 'body': '...'},
                senderId: event.senderId,
                type: 'm.room.message',
                room: event.room,
                status: EventStatus.sent,
                originServerTs: DateTime.now(),
              );
        return InkWell(
          onTap: () {
            if (scrollToEventId != null) {
              scrollToEventId!(replyEvent!.eventId);
            }
          },
          child: AbsorbPointer(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              // child: ReplyContent(
              //   replyEvent,
              //   ownMessage: ownMessage,
              //   timeline: timeline,
              // ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSenderAvatar() {
    return sameSender || ownMessage
        ? SizedBox(
            width: MatrixAvatar.defaultSize,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: event.status == EventStatus.sending
                      ? const CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                        )
                      : event.status == EventStatus.error
                          ? const Icon(Icons.error, color: Colors.red)
                          : null,
                ),
              ),
            ),
          ) 
        : FutureBuilder<User?>(
            future: event.fetchSenderUser(),
            builder: (context, snapshot) {
              final user = snapshot.data ?? event.senderFromMemoryOrFallback;
              return MatrixAvatar(
                name: user.calcDisplayname(),
                onTap: () => onAvatarTab!(event),
                size: Sizing.regular,
                radius: Sizing.regular / 2,
                fontSize: Typo.small.fontSize!,
                mxContent: user.avatarUrl,
              );
            },
          );
  }

  _buildMessageEditTime(Color textColor) {
    final displayEvent = event.getDisplayEvent(timeline);
    return Padding(
      padding: EdgeInsets.only(top: Spacing.extraSmall / 2),
      child: Text(
        DateFormatUtils.timeOnly(displayEvent.originServerTs).toLowerCase(),
        style: Typo.xSmall.copyWith(color: textColor),
      ),
    );
  }

  Widget _buildVerificationRequestContent() {
    // TODO: // return VerificationRequestContent(event: event, timeline: timeline);
    return Text("Verification request content");
  }

  Widget _buildStateMessage() {
    if (event.type.startsWith('m.call.')) {
      return const SizedBox.shrink();
    }
    return StateMessageItem(event);
  }
}
