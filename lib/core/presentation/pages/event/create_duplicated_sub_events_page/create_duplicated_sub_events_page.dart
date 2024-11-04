import 'package:app/core/domain/event/entities/event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateDuplicatedSubEventsPage extends StatefulWidget {
  final Event subEvent;
  const CreateDuplicatedSubEventsPage({
    super.key,
    required this.subEvent,
  });

  @override
  State<CreateDuplicatedSubEventsPage> createState() =>
      _CreateDuplicatedSubEventsPageState();
}

class _CreateDuplicatedSubEventsPageState
    extends State<CreateDuplicatedSubEventsPage> {
  List<DateTime> dates = [];
  late DateTime startDate;
  late String timezone;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
