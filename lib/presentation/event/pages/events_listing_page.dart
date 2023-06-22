import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventsListingPage extends StatelessWidget {
  const EventsListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text("Event detail"),
        onPressed: () {
          AutoRouter.of(context).navigateNamed('/events/detail');
        },
      )),

    );
  }
}