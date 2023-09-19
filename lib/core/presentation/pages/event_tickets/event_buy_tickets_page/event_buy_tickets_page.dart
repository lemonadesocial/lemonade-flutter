import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventBuyTicketsPage extends StatelessWidget implements AutoRouteWrapper {
  const EventBuyTicketsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    // TODO: add root bloc
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
