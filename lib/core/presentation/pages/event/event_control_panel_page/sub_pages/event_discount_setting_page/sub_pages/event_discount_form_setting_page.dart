import 'package:app/core/domain/event/entities/event_payment_ticket_discount.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventDiscountFormSettingPage extends StatelessWidget {
  final EventPaymentTicketDiscount? discount;
  const EventDiscountFormSettingPage({
    super.key,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
