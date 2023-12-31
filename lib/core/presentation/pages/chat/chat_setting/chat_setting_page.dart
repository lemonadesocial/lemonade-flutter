import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatSettingPage extends StatelessWidget {
  const ChatSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LemonAppBar(),
      body: Center(
        child: Text('Chat setting'),
      ),
    );
  }
}
