import 'dart:io';

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/add_ticket_to_apple_wallet_button.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/add_ticket_to_calendar_button.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/my_ticket_card.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_actions.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/tickets_cost_summary.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyEventTicketPage extends StatelessWidget {
  final Event event;
  final EventPayment? eventPayment;

  const MyEventTicketPage({
    super.key,
    required this.event,
    this.eventPayment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(
        title: '',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title ?? '',
                    style: Typo.superLarge.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.87),
                    ),
                  ),
                  Text(
                    DateFormatUtils.custom(
                      event.start,
                      pattern: 'EEEE, dd MMMM  •  hh:mm a',
                    ),
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.medium),
                  EventTicketActions(
                    event: event,
                    eventPayment: eventPayment,
                  ),
                  SizedBox(height: Spacing.medium),
                  const AddTicketToCalendarButton(),
                  if (Platform.isIOS) ...[
                    SizedBox(height: Spacing.xSmall),
                    const AddTicketToAppleWalletButton(),
                  ],
                  SizedBox(height: Spacing.medium),
                  MyTicketCard(
                    event: event,
                    eventPayment: eventPayment,
                  ),
                  if (eventPayment != null) ...[
                    SizedBox(
                      height: Spacing.medium,
                    ),
                    TicketCostSummary(
                      event: event,
                      eventPayment: eventPayment!,
                    ),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
