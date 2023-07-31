import 'package:app/core/application/chat/chat_list_bloc/chat_list_bloc.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/channel_list_item.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/direct_message_item.dart';
import 'package:app/core/presentation/widgets/chat/spaces_drawer.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/collapsible/collapsible_section_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/stream_extension.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart';

class ChatListPageView extends StatelessWidget {
  const ChatListPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        title: t.common.lemonade,
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Center(
                child: Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ThemeSvgIcon(
                    color: colorScheme.onSurface,
                    builder: (filter) => Assets.icons.icLemonadeWhite.svg(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: SpacesDrawer(),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: StreamBuilder(
          stream: getIt<MatrixService>()
              .client
              .onSync
              .stream
              .where((event) => event.hasRoomUpdate)
              .rateLimit(Duration(seconds: 1)),
          builder: (context, snapshot) => BlocBuilder<ChatListBloc, ChatListState>(
            builder: (context, chatListState) {
              return CustomScrollView(
                slivers: [
                  if (chatListState.unreadDmRooms.isNotEmpty) ...[
                    _ChatListSection(
                      title: StringUtils.capitalize(t.chat.unread),
                      rooms: chatListState.unreadDmRooms,
                      itemBuilder: (room) => DirectMessageItem(room: room),
                    ),
                    SliverToBoxAdapter(
                      child: Divider(color: colorScheme.onSurfaceVariant, height: 1),
                    ),
                  ],
                  _ChatListSection(
                    title: StringUtils.capitalize(t.chat.channels),
                    rooms: chatListState.channelRooms,
                    itemBuilder: (room) => ChannelListItem(room: room),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(color: colorScheme.onSurfaceVariant, height: 1),
                  ),
                  _ChatListSection(
                    title: StringUtils.capitalize(t.chat.directMessages),
                    rooms: chatListState.dmRooms,
                    itemBuilder: (room) => DirectMessageItem(room: room),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ChatListSection extends StatelessWidget {
  const _ChatListSection({
    required this.title,
    required this.rooms,
    required this.itemBuilder,
  });

  final String title;
  final List<Room> rooms;
  final Widget Function(Room room) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CollapsibleSection(
        title: title,
        children: rooms.map(itemBuilder).toList(),
      ),
    );
  }
}
