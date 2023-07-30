import 'package:app/core/mock_model/chat_room.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ChannelListItem extends StatelessWidget {
  final ChatRoom room;
  ChannelListItem({required this.room});

  Widget _buildAvatar() {
    bool isPrivateChannel = room.isPrivate ?? false;
    var icon = isPrivateChannel ? Assets.icons.icPrivateChannel : Assets.icons.icPublicChannel;
    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: LemonColor.white12,
            borderRadius: BorderRadius.circular(9),
          ),
          child: ThemeSvgIcon(
            // color: colorScheme.onPrimary,
            builder: (filter) => icon.svg(
              colorFilter: filter,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreatedAt(ColorScheme colorScheme) {
    var createdAt = room.createdAt;
    var label = '';

    final DateTime now = DateTime.now().toLocal();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = today.subtract(Duration(days: 1));

    var color = room.unseenMessageCount! > 0
        ? LemonColor.paleViolet
        : LemonColor.white36;

    if (createdAt!.isAfter(today)) {
      label = DateFormatUtils.timeOnly(createdAt);
    } else if (createdAt.isAfter(yesterday)) {
      label = 'Yesterday';
    } else {
      label = DateFormatUtils.dateOnly(createdAt);
    }
    return Text(
      label,
      style: Typo.medium.copyWith(color: color),
    );
  }

  Widget _buildTrailing(ColorScheme colorScheme) {
    var unseenMessageCount = room.unseenMessageCount;
    if (unseenMessageCount == 0) {
      return Column(
        children: [
          _buildCreatedAt(colorScheme),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 5,
        ),
        _buildCreatedAt(colorScheme),
        SizedBox(
          height: 5,
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 9),
            decoration: BoxDecoration(
              color: LemonColor.paleViolet,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$unseenMessageCount',
              style: Typo.medium.copyWith(color: colorScheme.secondary),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var name = room.name ?? '';
    var latestMessage = room.latestMessage ?? '';
    return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colorScheme.outline)),
        ),
        child: ListTile(
          leading: _buildAvatar(),
          title: Text(name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(latestMessage)],
          ),
          trailing: _buildTrailing(colorScheme),
          onTap: () {
            AutoRouter.of(context).navigateNamed('/chat/detail/chatId');
          },
        ));
  }
}
