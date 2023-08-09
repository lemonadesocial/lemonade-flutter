import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/emoji_picker_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class MessageActions extends StatelessWidget {
  final Function()? onEdit;
  final Function(String emoji)? onReact;

  const MessageActions({
    super.key,
    this.onEdit,
    this.onReact,
  });

  List<String> get defaultEmojis => ['👍', '🥳', '😍', '✅', '🎉'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonSnapBottomSheet(
      defaultSnapSize: 0.3,
      minSnapSize: 0.3,
      maxSnapSize: 0.3,
      snapSizes: [0.3],
      builder: (_) => Flexible(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Spacing.xSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...defaultEmojis
                      .map(
                        (emoji) => InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            onReact?.call(emoji);
                          },
                          child: Text(
                            emoji,
                            style: TextStyle(fontSize: 36),
                          ),
                        ),
                      )
                      .toList(),
                  IconButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      BottomSheetUtils.showSnapBottomSheet(
                        context,
                        builder: (context) {
                          return LemonEmojiPicker(
                            onEmojiSelected: (emoji) {
                              Navigator.of(context).pop();
                              onReact?.call(emoji.emoji);
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add_circle_outline_sharp,
                      size: Sizing.medium,
                      color: colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
