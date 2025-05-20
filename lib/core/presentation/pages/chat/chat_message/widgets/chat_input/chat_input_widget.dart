import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/input_bar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

class ChatInput extends StatelessWidget {
  final ChatController controller;

  const ChatInput(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return Container(
      color: appColors.pageBg,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.xSmall,
          horizontal: Spacing.xSmall,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Commented out because add button functionality is not implemented yet
            // _buildAddButton(context),
            SizedBox(width: Spacing.superExtraSmall),
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(
                        color: appColors.inputBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(
                        color: appColors.inputBorder,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Spacing.extraSmall,
                      horizontal: Spacing.smMedium,
                    ),
                  ),
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: appColors.textTertiary,
                    selectionColor: appColors.textInverse,
                  ),
                ),
                child: InputBar(
                  room: controller.room,
                  minLines: 1,
                  maxLines: 8,
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  onSubmitted: controller.onInputBarSubmitted,
                  // TODO:
                  // onSubmitImage: controller.sendImageFromClipBoard,
                  // focusNode: controller.inputFocus,
                  controller: controller.sendController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: t.chat.typeMessage,
                    hintMaxLines: 1,
                    filled: false,
                    hintStyle: appText.md.copyWith(
                      color: appColors.textTertiary,
                    ),
                  ),
                  onChanged: controller.onInputBarChanged,
                ),
              ),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            _buildSendButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    final appColors = context.theme.appColors;
    return GestureDetector(
      onTap: controller.send,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: appColors.buttonTertiaryBg,
          borderRadius: BorderRadius.circular(42 / 2),
        ),
        child: Center(
          child: Icon(
            Icons.send_rounded,
            size: 21,
            color: appColors.buttonTertiary,
          ),
        ),
      ),
    );
  }

  // Widget _buildAddButton(BuildContext context) {
  //   return GestureDetector(
  //     child: Container(
  //       height: 42,
  //       width: 42,
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).colorScheme.surfaceVariant,
  //         borderRadius: BorderRadius.circular(42 / 2),
  //       ),
  //       child: Center(
  //         child: Assets.icons.icAdd.svg(),
  //       ),
  //     ),
  //   );
  // }
}
