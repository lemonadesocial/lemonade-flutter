import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/input_bar_widget.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final ChatController controller;

  const ChatInput(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 56,
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: InputBar(
              room: controller.room,
              minLines: 1,
              maxLines: 8,
              autofocus: false,
              keyboardType: TextInputType.multiline,
              onSubmitted: controller.onInputBarSubmitted,
              // onSubmitImage: controller.sendImageFromClipBoard,
              // focusNode: controller.inputFocus,
              controller: controller.sendController,
              decoration: InputDecoration(
                hintText: "Write a message",
                hintMaxLines: 1,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                filled: false,
              ),
              onChanged: controller.onInputBarChanged,
            ),
          ),
        ),
        if (controller.inputText.isEmpty)
          Container(
            height: 56,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.mic_none_outlined),
              onPressed: () {},
            ),
          ),
        if (controller.inputText.isNotEmpty)
          Container(
            height: 56,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.send_outlined),
              onPressed: controller.send,
            ),
          ),
      ],
    );
  }
}
