import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_pick_my_ticket_page/widgets/pick_my_tickets_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventPickMyTicketPage extends StatelessWidget {
  const EventPickMyTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventPickMyTicketView();
  }
}

class EventPickMyTicketView extends StatelessWidget {
  const EventPickMyTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.event.eventPickMyTickets.pickYourTicket,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    t.event.eventPickMyTickets.pickYourTicketDescription,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            const PickMyTicketsList(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: SizedBox(
                height: Sizing.large,
                child: Opacity(
                  opacity: 1, // 0.5 for disabled state,
                  child: LinearGradientButton(
                    radius: BorderRadius.circular(LemonRadius.small * 2),
                    mode: GradientButtonMode.lavenderMode,
                    label: t.common.confirm,
                    textStyle: Typo.medium.copyWith(
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary.withOpacity(0.87),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
