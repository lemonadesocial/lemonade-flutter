import 'package:app/core/application/chat/chat_list_bloc/chat_list_bloc.dart';
import 'package:app/core/application/chat/chat_space_bloc/chat_space_bloc.dart';
import 'package:app/core/application/chat/get_guild_rooms_bloc/get_guild_rooms_bloc.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/chat_list_page_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatSpaceBloc, ChatSpaceState>(
      builder: (context, chatSpaceState) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              key: ValueKey(chatSpaceState.activeSpace?.id),
              create: (context) => ChatListBloc(
                spaceId: chatSpaceState.activeSpace?.id,
              )..add(
                  const ChatListEvent.fetchRooms(),
                ),
            ),
            BlocProvider(
              create: (context) => GetGuildRoomsBloc()
                ..add(
                  GetGuildRoomsEvent.fetch(),
                ),
            ),
          ],
          child: const ChatListPageView(),
        );
      },
    );
  }
}
