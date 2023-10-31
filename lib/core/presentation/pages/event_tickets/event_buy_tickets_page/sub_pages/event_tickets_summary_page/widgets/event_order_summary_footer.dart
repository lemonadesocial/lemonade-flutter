import 'package:app/core/application/payment/payment_bloc/payment_bloc.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/add_card_button.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_card_tile.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_slide_to_pay.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventOrderSummaryFooter extends StatelessWidget {
  const EventOrderSummaryFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.smMedium,
          vertical: Spacing.smMedium,
        ),
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: Border(
            top: BorderSide(
              width: 2.w,
              color: colorScheme.onPrimary.withOpacity(0.06),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                print('newSate: ${state.selectedCard}');
                return state.selectedCard != null
                    ? EventCardTile(paymentCardEntity: state.selectedCard!)
                    : const AddCardButton();
              },
            ),
            SizedBox(height: Spacing.smMedium),
            const EventOrderSlideToPay(),
          ],
        ),
      ),
    );
  }
}
