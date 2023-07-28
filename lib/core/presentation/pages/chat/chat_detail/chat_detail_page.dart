import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LemonAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chat detail'),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).navigateNamed('/chat/setting/chatId');
              },
              child: Text("Go to chat setting"),
            )
          ],
        ),
      ),
    );
  }
}
