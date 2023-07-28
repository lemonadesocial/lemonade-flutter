import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatStackPage extends StatelessWidget {
  const ChatStackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}