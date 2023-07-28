import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LemonAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chat list'),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).navigateNamed('/chat/detail/chatId');
              },
              child: Text('Go to chat detail'),
            )
          ],
        ),
      ),
    );
  }
}
