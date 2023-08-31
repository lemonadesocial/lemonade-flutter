import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/reply_content_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class ReplyDisplay extends StatelessWidget {
  const ReplyDisplay(this.controller, {Key? key}) : super(key: key);
  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return controller.editEvent != null || controller.replyEvent != null
        ? Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.small),
                topRight: Radius.circular(LemonRadius.small),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: Spacing.extraSmall),
                    child: controller.replyEvent != null
                        ? ReplyContent(
                            controller.replyEvent!,
                            timeline: controller.timeline!,
                          )
                        : _EditContent(
                            controller.editEvent?.getDisplayEvent(
                              controller.timeline!,
                            ),
                          ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: controller.cancelReplyOrEditEventAction,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _EditContent extends StatelessWidget {

  const _EditContent(this.event);
  final Event? event;

  @override
  Widget build(BuildContext context) {
    final event = this.event;
    if (event == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: <Widget>[
        Icon(
          Icons.edit,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        Container(width: Spacing.small),
        Flexible(
          child: FutureBuilder<String>(
            future: event.calcLocalizedBody(
              const MatrixDefaultLocalizations(),
              hideReply: true,
            ),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ??
                    event.calcLocalizedBodyFallback(
                      const MatrixDefaultLocalizations(),
                      hideReply: true,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
