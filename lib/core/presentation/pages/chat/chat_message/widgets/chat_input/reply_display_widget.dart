import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/reply_content_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class ReplyDisplay extends StatelessWidget {
  final ChatController controller;
  const ReplyDisplay(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.replyEvent == null
        ? SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.small),
                topRight: Radius.circular(LemonRadius.small),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(width: Spacing.small),
                Flexible(
                  child: controller.replyEvent != null
                      ? ReplyContent(
                          controller.replyEvent!,
                          timeline: controller.timeline!,
                        )
                      : SizedBox.shrink(),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => controller.reply(replyTo: null),
                ),
              ],
            ),
          );
  }
}
