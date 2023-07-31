import 'package:app/core/utils/chat/matrix_room_extension.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class UnseenMessageCountWidget extends StatelessWidget {
  final Room room;
  UnseenMessageCountWidget({required this.room});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    int unseenMessageCount = room.notificationCount;
    var boxColor = room.isMuted ? LemonColor.white12 : LemonColor.paleViolet;
    var textColor = room.isMuted ? colorScheme.onSecondary : colorScheme.secondary;

    if (unseenMessageCount == 0) {
      return SizedBox.shrink();
    }

    return Container(
      width: unseenMessageCount > 9 ? 32 : 25,
      height: 20,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          unseenMessageCount > 9 ? '9+' : '$unseenMessageCount',
          style: Typo.medium.copyWith(color: textColor),
        ),
      ),
    );
  }
}
