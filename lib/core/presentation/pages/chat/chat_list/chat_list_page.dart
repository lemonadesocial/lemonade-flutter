import 'package:app/core/mock_model/chat_room.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/channel_list_item.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/direct_message_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/spaces_drawer.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/common/collapsible/collapsible_section.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'mock_data.dart';

@RoutePage()
class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  Widget _buildCollapsibleSection(String title, List<ChatRoom> chatRooms, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
      ),
      child: CollapsibleSection(
        title: title,
        chatRooms: chatRooms,
        children: [
          for (var room in chatRooms)
            title == 'Channels'
                ? ChannelListItem(room: room)
                : DirectMessageItem(room: room),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        actionsHeight: 27,
        title: t.common.lemonade,
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: themeColor.onSurface,
                    builder: (filter) => Assets.icons.icLemonadeWhite.svg(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: SpacesDrawer(),
      backgroundColor: themeColor.primary,
      body: ListView(
        children: [
          _buildCollapsibleSection('Unread', mockDirectMessages, colorScheme),
          _buildCollapsibleSection('Channels', mockChannels, colorScheme),
          _buildCollapsibleSection('Direct messages', mockDirectMessages, colorScheme),
        ],
      ),
    );
  }
}
