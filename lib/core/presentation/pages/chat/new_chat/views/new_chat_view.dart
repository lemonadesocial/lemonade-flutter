import 'package:app/core/application/chat/new_chat_bloc/new_chat_bloc.dart';
import 'package:app/core/presentation/pages/chat/new_chat/widgets/search_user_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart';

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
                  child: ListView.builder(
                    itemCount: newChatState.userSearchResult?.results.length,
                    itemBuilder: (context, i) => SearchUserItem(
                      name: newChatState
                              .userSearchResult?.results[i].displayName ??
                          newChatState
                              .userSearchResult?.results[i].userId.localpart ??
                          t.chat.unknownDevice,
                      avatarUrl:
                          newChatState.userSearchResult?.results[i].avatarUrl,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
