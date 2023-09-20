import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/add_promo_code_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_summary_footer.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/events_tickets_summary.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTicketsSummaryPage extends StatelessWidget {
  const EventTicketsSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventTicketsSummaryView();
  }
}

class EventTicketsSummaryView extends StatelessWidget {
  const EventTicketsSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.event.eventBuyTickets.orderSummary,
                          style: Typo.extraLarge.copyWith(
                            color: colorScheme.onPrimary,
                            fontFamily: FontFamily.nohemiVariable,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Culture Fest Wed, Setp 20",
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Spacing.large),
                  const EventsTicketSummary(),
                  SizedBox(height: Spacing.smMedium),
                  const AddPromoCodeInput(),
                  SizedBox(height: Spacing.smMedium),
                  const EventOrderSummary(),
                  SizedBox(height: 150.w + Spacing.medium),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: EventOrderSummaryFooter(),
            )
          ],
        ),
      ),
    );
  }
}
