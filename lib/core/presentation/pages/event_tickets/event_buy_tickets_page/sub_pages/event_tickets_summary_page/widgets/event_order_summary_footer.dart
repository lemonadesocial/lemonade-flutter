import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_slide_to_pay.dart';
import 'package:app/core/presentation/widgets/common/slide_to_act/slide_to_act.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventOrderSummaryFooter extends StatelessWidget {
  const EventOrderSummaryFooter({
    super.key,
    this.pricingInfo,
    required this.onSlideToPay,
    required this.slideActionKey,
  });
  final Function() onSlideToPay;
  final EventTicketsPricingInfo? pricingInfo;
  final GlobalKey<SlideActionState> slideActionKey;

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
        child:
            // true
            //     ?
            // TODO: will show add card
            Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: will handle add card later
            // EventCardTile(paymentCard: state.selectedCard!),
            SizedBox(height: Spacing.smMedium),
            EventOrderSlideToPay(
              onSlideToPay: onSlideToPay,
              pricingInfo: pricingInfo,
              slideActionKey: slideActionKey,
            ),
          ],
        ),
        // : _emptyPaymentWidget(context, ''),
      ),
    );
  }

  // TODO: comment to resolve dart analyze
  // Widget _emptyPaymentWidget(BuildContext context, String publishableKey) {
  //   final t = Translations.of(context);
  //   final colorScheme = Theme.of(context).colorScheme;

  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             t.event.eventPayment.howYouPay,
  //             style: Typo.small.copyWith(
  //               color: colorScheme.onSecondary,
  //             ),
  //           ),
  //           SizedBox(height: 2.w),
  //           Text(
  //             t.event.eventPayment.selectPayment,
  //             style: Typo.medium.copyWith(color: colorScheme.onPrimary),
  //           ),
  //         ],
  //       ),
  //       const Spacer(),
  //       InkWell(
  //         onTap: () async {
  //           // TODO: will handle add card later
  //           // final newCard = await AddCardBottomSheet(
  //           //   publishableKey: publishableKey,
  //           // ).showAsBottomSheet(context) as PaymentCard?;
  //           // if (newCard != null) {
  //           //   context.read<PaymentBloc>().newCardAdded(newCard);
  //           // }
  //         },
  //         child: Container(
  //           width: Sizing.medium,
  //           height: Sizing.medium,
  //           decoration: BoxDecoration(
  //             color: colorScheme.onPrimary.withOpacity(0.09),
  //             borderRadius: BorderRadius.circular(LemonRadius.normal),
  //           ),
  //           child: Center(
  //             child: ThemeSvgIcon(
  //               color: colorScheme.onSurfaceVariant,
  //               builder: (filter) => Assets.icons.icAdd.svg(
  //                 colorFilter: filter,
  //                 height: Sizing.xSmall,
  //                 width: Sizing.xSmall,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
