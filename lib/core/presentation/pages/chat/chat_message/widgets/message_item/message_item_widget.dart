import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/reply_content_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/message_item/message_content_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/message_item/message_reaction_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/message_item/state_message_item_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/common/swipe/swipeable.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/matrix_date_time_extension.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import 'package:matrix/matrix.dart';

class MessageItem extends StatefulWidget {
  final Event event;
  final Event? nextEvent;
  final bool displayReadMarker;
  final void Function(Event)? onSwipe;
  final void Function(Event)? onSelect;
  final void Function(Event, String)? onReact;
  final void Function(Event)? onAvatarTab;
  final void Function(Event)? onInfoTab;
  final void Function(String)? scrollToEventId;
  final bool longPressSelect;
  final bool selected;
  final Timeline timeline;

  const MessageItem(
    this.event, {
    this.nextEvent,
    this.displayReadMarker = false,
    this.longPressSelect = true,
    this.onSwipe,
    this.onReact,
    this.onSelect,
    this.onInfoTab,
    this.onAvatarTab,
    this.scrollToEventId,
    this.selected = false,
    required this.timeline,
    Key? key,
  }) : super(key: key);

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  final client = getIt<MatrixService>().client;

  Event get displayEvent => widget.event.getDisplayEvent(widget.timeline);

  bool get ownMessage => widget.event.senderId == client.userID;

  bool get shouldDisplayTime =>
      widget.event.type == EventTypes.RoomCreate ||
      widget.nextEvent == null ||
      // check if 2 time close enough
      !widget.event.originServerTs
          .sameEnvironment(widget.nextEvent!.originServerTs);

  bool get sameSender =>
      widget.nextEvent != null &&
      [
        EventTypes.Message,
        EventTypes.Sticker,
        EventTypes.Encrypted,
      ].contains(widget.nextEvent!.type) &&
      widget.nextEvent?.relationshipType == null &&
      widget.nextEvent!.senderId == widget.event.senderId &&
      !shouldDisplayTime;

  bool get hasReactions => widget.event.hasAggregatedEvents(
        widget.timeline,
        RelationshipTypes.reaction,
      );

  double get columnWidth => 360;

  bool get noBubble =>
      {
        MessageTypes.Video,
        MessageTypes.Image,
        MessageTypes.Sticker,
      }.contains(widget.event.messageType) &&
      !widget.event.redacted;

  bool get noPadding => {
        MessageTypes.File,
        MessageTypes.Audio,
      }.contains(widget.event.messageType);

  Alignment get alignment =>
      ownMessage ? Alignment.topRight : Alignment.topLeft;

  MainAxisAlignment get rowMainAxisAlignment =>
      ownMessage ? MainAxisAlignment.end : MainAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    if (!{
      EventTypes.Message,
      EventTypes.Sticker,
      EventTypes.Encrypted,
      EventTypes.CallInvite,
    }.contains(widget.event.type)) {
      return _buildStateMessage();
    }

    if (widget.event.type == EventTypes.Message &&
        widget.event.messageType == EventTypes.KeyVerificationRequest) {
      return _buildVerificationRequestContent();
    }

    return _buildMessage(context);
  }

  Widget _buildMessage(BuildContext context) {
    final messageBody = _buildMessageBody(context);
    Widget container;
    if (hasReactions ||
        shouldDisplayTime ||
        widget.selected ||
        widget.displayReadMarker) {
      container = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            ownMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (shouldDisplayTime || widget.selected)
            _buildMessageSentTime(context),
          messageBody,
          if (hasReactions) _buildMessageReaction(),
          if (widget.displayReadMarker) _buildMessageReadMarker(context),
        ],
      );
    } else {
      container = messageBody;
    }

    if (widget.event.messageType == MessageTypes.BadEncrypted ||
        widget.event.redacted) {
      container = Opacity(opacity: 0.45, child: container);
    }

    return Swipeable(
      direction:
          ownMessage ? SwipeDirection.endToStart : SwipeDirection.startToEnd,
      maxOffset: 0.4,
      onSwipe: (direction) {
        widget.onSwipe?.call(widget.event);
      },
      key: ValueKey(widget.event.eventId),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 100 * 2.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: container,
        ),
      ),
    );
  }

  Row _buildMessageBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor =
        ownMessage ? colorScheme.onPrimary : colorScheme.onSurface;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: rowMainAxisAlignment,
      mainAxisSize: MainAxisSize.max,
      children: [
        // _buildSenderAvatar(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: alignment,
                child: ChatBubble(
                  elevation: 0,
                  clipper: ownMessage
                      ? ChatBubbleClipper3(type: BubbleType.sendBubble)
                      : ChatBubbleClipper3(type: BubbleType.receiverBubble),
                  alignment: alignment,
                  backGroundColor: ownMessage
                      ? LemonColor.ownMessage
                      : LemonColor.otherMessage,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: InkWell(
                      onLongPress: !widget.longPressSelect
                          ? null
                          : () => widget.onSelect!(widget.event),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (widget.event.relationshipType ==
                              RelationshipTypes.reply)
                            _buildRepliedMessage(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex: 5,
                                child: MessageContent(
                                  displayEvent,
                                  textColor: textColor,
                                  onInfoTab: widget.onInfoTab,
                                ),
                              ),
                              SizedBox(width: Spacing.superExtraSmall),
                              Flexible(
                                flex: 2,
                                child: _buildMessageEditTime(
                                  colorScheme.onSurfaceVariant,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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

  Widget _buildMessageReaction() {
    return Padding(
      padding: EdgeInsets.only(
        top: Spacing.superExtraSmall,
        left: ownMessage ? 0 : MatrixAvatar.defaultSize,
      ),
      child: MessageReactions(
        event: widget.event,
        timeline: widget.timeline,
        onReact: ({required Event event, required String emoji}) {
          widget.onReact?.call(event, emoji);
        },
      ),
    );
  }

  Widget _buildMessageSentTime(BuildContext context) {
    return Padding(
      padding: shouldDisplayTime
          ? EdgeInsets.symmetric(vertical: Spacing.extraSmall)
          : EdgeInsets.zero,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: shouldDisplayTime
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.background.withOpacity(0.45),
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.all(Spacing.superExtraSmall),
            child: Text(
              DateFormatUtils.fullDateWithTime(widget.event.originServerTs),
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
      future: widget.event.getReplyEvent(widget.timeline),
      builder: (BuildContext context, snapshot) {
        final replyEvent = snapshot.hasData
            ? snapshot.data
            : Event(
                eventId: widget.event.relationshipEventId!,
                content: {'msgtype': 'm.text', 'body': '...'},
                senderId: widget.event.senderId,
                type: 'm.room.message',
                room: widget.event.room,
                status: EventStatus.sent,
                originServerTs: DateTime.now(),
              );
        return InkWell(
          onTap: () {
            if (widget.scrollToEventId != null) {
              widget.scrollToEventId!(replyEvent.eventId);
            }
          },
          child: AbsorbPointer(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              child: ReplyContent(
                replyEvent!,
                ownMessage: ownMessage,
                timeline: widget.timeline,
              ),
            ),
          ),
        );
      },
    );
  }

  // TODO: Not use for now, but maybe we need this in future
  // Widget _buildSenderAvatar() {
  //   return sameSender || ownMessage
  //       ? SizedBox(
  //           width: MatrixAvatar.defaultSize,
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 8.0),
  //             child: Center(
  //               child: SizedBox(
  //                 width: Sizing.xSmall,
  //                 height: Sizing.xSmall,
  //                 child: widget.event.status == EventStatus.sending
  //                     ? const CircularProgressIndicator.adaptive(
  //                         strokeWidth: 2,
  //                       )
  //                     : widget.event.status == EventStatus.error
  //                         ? const Icon(Icons.error, color: Colors.red)
  //                         : null,
  //               ),
  //             ),
  //           ),
  //         )
  //       : FutureBuilder<User?>(
  //           future: widget.event.fetchSenderUser(),
  //           builder: (context, snapshot) {
  //             final user = snapshot.data ?? widget.event.senderFromMemoryOrFallback;
  //             return MatrixAvatar(
  //               name: user.calcDisplayname(),
  //               onTap: () => widget.onAvatarTab!(widget.event),
  //               size: Sizing.regular,
  //               radius: Sizing.regular / 2,
  //               fontSize: Typo.small.fontSize!,
  //               mxContent: user.avatarUrl,
  //             );
  //           },
  //         );
  // }

  _buildMessageEditTime(Color textColor) {
    final displayEvent = widget.event.getDisplayEvent(widget.timeline);
    return Padding(
      padding: EdgeInsets.only(top: Spacing.extraSmall / 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.event.hasAggregatedEvents(
            widget.timeline,
            RelationshipTypes.edit,
          )) ...[
            Icon(Icons.edit_outlined,
                color: textColor, size: Typo.small.fontSize!),
            const SizedBox(width: 6),
          ],
          Text(
            DateFormatUtils.timeOnly(displayEvent.originServerTs).toLowerCase(),
            style: Typo.xSmall.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationRequestContent() {
    // TODO: // return VerificationRequestContent(event: event, timeline: timeline);
    return const Text("Verification request content");
  }

  Widget _buildStateMessage() {
    if (widget.event.type.startsWith('m.call.')) {
      return const SizedBox.shrink();
    }
    return StateMessageItem(widget.event);
  }
}
