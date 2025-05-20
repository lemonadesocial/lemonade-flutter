import 'package:app/core/utils/chat/matrix_room_extension.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:app/app_theme/app_theme.dart';

class UnseenMessageCountWidget extends StatelessWidget {
  final Room room;
  const UnseenMessageCountWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    int unseenMessageCount = room.notificationCount;
    var boxColor = room.isMuted ? appColors.cardBg : appColors.buttonPrimaryBg;
    var textColor =
        room.isMuted ? appColors.textTertiary : appColors.textPrimary;

    if (unseenMessageCount == 0) {
      return const SizedBox.shrink();
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
          style: appText.sm.copyWith(color: textColor),
        ),
      ),
    );
  }
}
