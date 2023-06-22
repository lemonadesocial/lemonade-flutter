import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
    );
  }
}