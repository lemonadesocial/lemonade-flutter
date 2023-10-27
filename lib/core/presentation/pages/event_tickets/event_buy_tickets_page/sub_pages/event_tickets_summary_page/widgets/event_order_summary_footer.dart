import 'package:app/core/application/payment/payment_bloc/payment_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_card_entity/payment_card_entity.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/add_card_bottomsheet.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_card_tile.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_slide_to_pay.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
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
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return state.selectedCard != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EventCardTile(paymentCardEntity: state.selectedCard!),
                      SizedBox(height: Spacing.smMedium),
                      const EventOrderSlideToPay(),
                    ],
                  )
                : _emptyPaymentWidget(context);
          },
        ),
      ),
    );
  }

  Widget _emptyPaymentWidget(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.event.eventPayment.howYouPay,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: 2.w),
            Text(
              t.event.eventPayment.selectPayment,
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            final newCard = await AddCardBottomSheet()
                .showAsBottomSheet(context) as PaymentCardEntity?;
            if (newCard != null) {
              context.read<PaymentBloc>().newCardAdded(newCard);
            }
          },
          child: Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.09),
              borderRadius: BorderRadius.circular(LemonRadius.normal),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icAdd.svg(
                  colorFilter: filter,
                  height: Sizing.xSmall,
                  width: Sizing.xSmall,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
