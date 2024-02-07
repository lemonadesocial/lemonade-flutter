import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/emoji_picker_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class MessageActions extends StatelessWidget {
  final Function()? onEdit;
  final Function(String emoji)? onReact;
  final Event event;

  const MessageActions({
    super.key,
    required this.event,
    this.onEdit,
    this.onReact,
  });

  List<String> get defaultEmojis => ['👍', '🥳', '😍', '✅', '🎉'];

  bool get canEdit {
    if ({Membership.leave, Membership.ban}.contains(event.room.membership) ||
        !event.status.isSent) {
      return false;
    }
    return event.senderId == getIt<MatrixService>().client.userID;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LemonSnapBottomSheet(
      defaultSnapSize: 0.3,
      minSnapSize: 0.3,
      maxSnapSize: 0.3,
      snapSizes: const [0.3],
      builder: (_) => Flexible(
        child: Column(
          children: [
            SizedBox(height: Spacing.xSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...defaultEmojis.map(
                  (emoji) => InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onReact?.call(emoji);
                    },
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                ),
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
                ),
              ],
            ),
            if (canEdit)
              ListTile(
                onTap: () {
                  onEdit?.call();
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.edit,
                  color: colorScheme.onSurface,
                ),
                title: Text(
                  Translations.of(context).chat.editMessage,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
