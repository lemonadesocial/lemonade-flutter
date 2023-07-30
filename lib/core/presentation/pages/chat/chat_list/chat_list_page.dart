import 'package:app/core/presentation/pages/chat/chat_list/mock_data.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/channel_list_item.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/chat_list_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


class Channels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockChannels.length,
      itemBuilder: (context, index) {
        final chatRoom = mockChannels[index];
        return ChannelListItem(room: chatRoom);
      },
    );
  }
}

class DirectMessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockDirectMessages.length,
      itemBuilder: (context, index) {
        final chatRoom = mockDirectMessages[index];
        return ChatListItem(room: chatRoom);
      },
    );
  }
}

class GroupsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Groups Tab'),
    );
  }
}

class EventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Events Tab'),
    );
  }
}

@RoutePage()
class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: LemonAppBar(
          title: t.common.lemonade,
        ),
        backgroundColor: themeColor.primary,
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Channels'),
                Tab(text: 'DMs'),
                Tab(text: 'Groups'),
                Tab(text: 'Events'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Channels(),
                  DirectMessagesTab(),
                  GroupsTab(),
                  EventsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
