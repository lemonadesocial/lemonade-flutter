import 'package:app/core/application/chat/new_chat_bloc/new_chat_bloc.dart';
import 'package:app/core/presentation/pages/chat/new_chat/widgets/search_user_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart' as sdk;

class NewChatView extends StatelessWidget {
  final debouncer = Debouncer(milliseconds: 300);

  NewChatView({super.key});

  void onSearchChanged(BuildContext context, String value) {
    debouncer.run(() {
      context.read<NewChatBloc>().add(NewChatEvent.searchUsers(text: value));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.onPrimaryContainer,
        title: t.chat.newMessage,
        actions: [
          InkWell(
            onTap: () async {
              final roomID = await showFutureLoadingDialog(
                context: context,
                future: () async {
                  final client =
                      context.read<NewChatBloc>().matrixService.client;
                  final roomId = await client.createGroupChat(
                    visibility: sdk.Visibility.private,
                    preset: sdk.CreateRoomPreset.privateChat,
                    invite: context.read<NewChatBloc>().state.selectedUsers,
                  );
                  await client.joinRoom(roomId);
                  return roomId;
                },
              );
              if (roomID.error == null) {
                AutoRouter.of(context)
                    .navigateNamed('/chat/detail/${roomID.result}');
                await Future.delayed(const Duration(milliseconds: 400));
                Navigator.of(context).pop();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              alignment: Alignment.centerRight,
              child: Text(
                "Start",
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16.0, // Adjust the font size as needed
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      body: BlocBuilder<NewChatBloc, NewChatState>(
        builder: (context, newChatState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) => onSearchChanged(context, value),
                decoration: const InputDecoration(
                  hintText: 'Search users',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              if (newChatState.userSearchResult != null) ...[
                Expanded(
                  child: _buildUserList(newChatState, context),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserList(NewChatState newChatState, BuildContext context) {
    final t = Translations.of(context);

    return ListView.builder(
      itemCount: newChatState.userSearchResult?.results.length,
      itemBuilder: (context, i) {
        final userResult = newChatState.userSearchResult?.results[i];
        final userId = userResult?.userId ?? '';
        final isSelected = newChatState.selectedUsers.isNotEmpty &&
            newChatState.selectedUsers.contains(userId);

        return SearchUserItem(
          isSelected: isSelected,
          name: userResult?.displayName ??
              userId.localpart ??
              t.chat.unknownDevice,
          avatarUrl: userResult?.avatarUrl,
          onTap: () {
            if (isSelected) {
              context.read<NewChatBloc>().add(
                    NewChatEvent.deselectUser(userId: userId),
                  );
            } else {
              context.read<NewChatBloc>().add(
                    NewChatEvent.selectUser(userId: userId),
                  );
            }
          },
        );
      },
    );
  }
}
