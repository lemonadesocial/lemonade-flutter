import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/payment_cards_list.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_slide_to_pay.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTicketsPaymentMethodPage extends StatelessWidget {
  const EventTicketsPaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventTicketsPaymentMethodView();
  }
}

class EventTicketsPaymentMethodView extends StatelessWidget {
  const EventTicketsPaymentMethodView({super.key});

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
                    t.event.eventPayment.payUsing,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    t.event.eventPayment.payUsingDescription,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            const PaymentCardsList(),
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  top: Spacing.smMedium,
                  left: Spacing.smMedium,
                  right: Spacing.smMedium,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.w,
                      color: colorScheme.onPrimary.withOpacity(0.06),
                    ),
                  ),
                ),
                child: const EventOrderSlideToPay(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
