import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/payment_card_brand_icon.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCardButton extends StatelessWidget {
  final PaymentCard? paymentCard;
  final Function()? onPressedSelect;

  const SelectCardButton({
    super.key,
    this.paymentCard,
    this.onPressedSelect,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onPressedSelect,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (paymentCard != null && paymentCard?.brand != null) ...[
            Container(
              width: Sizing.medium,
              height: Sizing.medium,
              padding: EdgeInsets.all(Spacing.superExtraSmall),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizing.medium),
              ),
              child: Center(
                child: PaymentCardBrandIcon(cardBrand: paymentCard!.brand!),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
          ],
          if (paymentCard != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.eventPayment.payUsing,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  t.event.eventPayment.cardEnding(
                    lastCardNumber: paymentCard?.last4 ?? '',
                  ),
                ),
              ],
            ),
          if (paymentCard == null)
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
                  t.event.eventPayment.selectCard,
                  style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                ),
              ],
            ),
          const Spacer(),
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            padding: EdgeInsets.all(Spacing.superExtraSmall),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.normal),
              border: Border.all(
                color: colorScheme.outlineVariant,
              ),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
