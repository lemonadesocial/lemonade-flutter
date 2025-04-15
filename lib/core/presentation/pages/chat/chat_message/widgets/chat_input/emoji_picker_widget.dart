import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class LemonEmojiPicker extends StatelessWidget {
  final Function(Emoji emoji)? onEmojiSelected;
  const LemonEmojiPicker({
    super.key,
    this.onEmojiSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LemonSnapBottomSheet(
      defaultSnapSize: 0.7,
      minSnapSize: 0.7,
      maxSnapSize: 0.7,
      snapSizes: const [0.7],
      builder: (controller) => Flexible(
        child: SafeArea(
          child: SizedBox(
            height: 600,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                onEmojiSelected?.call(emoji);
              },
              config: const Config(),
            ),
          ),
        ),
      ),
    );
  }
}
