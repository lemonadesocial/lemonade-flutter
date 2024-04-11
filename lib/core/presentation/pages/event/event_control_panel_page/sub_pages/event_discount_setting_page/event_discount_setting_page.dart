import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventDiscountSettingPage extends StatelessWidget
    implements AutoRouteWrapper {
  const EventDiscountSettingPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
