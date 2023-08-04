import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/chat_input_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/messages_list_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/stream_extension.dart';
import 'package:flutter/material.dart';

class ChatMessageView extends StatelessWidget {
  final ChatController controller;
  const ChatMessageView(
    this.controller,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.room.onUpdate.stream.rateLimit(Duration(seconds: 1)),
      builder: (context, snapshot) => FutureBuilder(
        future: controller.loadTimelineFuture,
        builder: (context, _snapshot) => Scaffold(
          appBar: LemonAppBar(
            title: controller.room.getLocalizedDisplayname(),
          ),
          body: controller.timeline == null
              ? Center(
                  child: Loading.defaultLoading(context),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: MessagesList(controller: controller),
                      ),
                      ChatInput(controller)
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
