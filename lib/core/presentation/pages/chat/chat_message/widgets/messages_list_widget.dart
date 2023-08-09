import 'dart:io';

import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/message_actions_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/message_item/message_item_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/message_item/typing_indicator_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/chat/filter_event_timeline_extension.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MessagesList extends StatelessWidget {
  final ChatController controller;
  const MessagesList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  int? findChildIndexCallback(Key key, Map<String, int> thisEventsKeyMap) {
    // this method is called very often. As such, it has to be optimized for speed.
    if (key is! ValueKey) {
      return null;
    }
    final eventId = key.value;
    if (eventId is! String) {
      return null;
    }
    // first fetch the last index the event was at
    final index = thisEventsKeyMap[eventId];
    if (index == null) {
      return null;
    }
    // we need to +1 as 0 is the typing thing at the bottom
    return index + 1;
  }

  _createEventsKeyMap() {
    // create a map of eventId --> index to greatly improve performance of
    // ListView's findChildIndexCallback
    final eventsKeyMap = <String, int>{};
    for (var i = 0; i < controller.timeline!.events.length; i++) {
      eventsKeyMap[controller.timeline!.events[i].eventId] = i;
    }
    return eventsKeyMap;
  }

  @override
  Widget build(BuildContext context) {
    final eventsKeyMap = _createEventsKeyMap();

    return ListView.custom(
      reverse: true,
      controller: controller.scrollController,
      keyboardDismissBehavior:
          Platform.isIOS ? ScrollViewKeyboardDismissBehavior.onDrag : ScrollViewKeyboardDismissBehavior.manual,
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int i) {
          // Footer to display typing indicator and read receipts:
          if (i == 0) {
            if (controller.timeline?.isRequestingFuture == true) {
              return _buildLoading();
            }
            if (controller.timeline?.canRequestFuture == true) {
              return _buildRefreshButton(
                action: controller.requestFuture,
              );
            }
            return _buildSeenAndTyping();
          }

          // Request history button or progress indicator:
          if (i == controller.timeline!.events.length + 1) {
            if (controller.timeline!.isRequestingHistory) {
              return _buildLoading();
            }
            if (controller.timeline!.canRequestHistory) {
              return _buildRefreshButton(action: controller.requestHistory);
            }
            return const SizedBox.shrink();
          }

          // The message at this index:
          final event = controller.timeline!.events[i - 1];
          return AutoScrollTag(
            key: ValueKey(event.eventId),
            index: i - 1,
            controller: controller.scrollController,
            child: event.isVisibleInGui
                ? MessageItem(
                    event,
                    onSwipe: (event) => controller.reply(replyTo: event),
                    onSelect: (event) {
                      BottomSheetUtils.showSnapBottomSheet(
                        context,
                        builder: (context) => MessageActions(
                          onReact: (emoji) {
                            controller.sendEmojiAction(event: event, emoji: emoji);
                          }
                        ),
                      );
                    },
                    onReact: (event, emoji) {
                      controller.sendEmojiAction(event: event, emoji: emoji);
                    },
                    timeline: controller.timeline!,
                    displayReadMarker:
                        controller.readMarkerEventId == event.eventId && controller.timeline?.allowNewEvent == false,
                    nextEvent: i < controller.timeline!.events.length ? controller.timeline!.events[i] : null,
                    // onInfoTab: controller.showEventInfo,
                    // onAvatarTab: (Event event) => showAdaptiveBottomSheet(
                    //   context: context,
                    //   builder: (c) => UserBottomSheet(
                    //     user: event.senderFromMemoryOrFallback,
                    //     outerContext: context,
                    //     onMention: () => controller.sendController.text +=
                    //         '${event.senderFromMemoryOrFallback.mention} ',
                    //   ),
                    // ),
                    // onSelect: controller.onSelectMessage,
                    // scrollToEventId: (String eventId) =>
                    //     controller.scrollToEventId(eventId),
                  )
                : const SizedBox.shrink(),
          );
        },
        childCount: controller.timeline!.events.length + 2,
        findChildIndexCallback: (key) => findChildIndexCallback(key, eventsKeyMap),
      ),
    );
  }

  Widget _buildSeenAndTyping() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO: todo widgets
        // SeenByRow(controller),
        TypingIndicators(controller),
      ],
    );
  }

  Widget _buildRefreshButton({
    required Function() action,
  }) {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) => action());
        return Center(
          child: IconButton(
            onPressed: action,
            icon: const Icon(Icons.refresh_outlined),
          ),
        );
      },
    );
  }

  Center _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
    );
  }
}
