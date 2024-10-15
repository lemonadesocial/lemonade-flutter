import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_payment_method_page/widgets/payment_card_brand_icon.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCardItem extends StatelessWidget {
  final Function()? onPressed;
  final bool selected;
  final PaymentCard paymentCard;

  const PaymentCardItem({
    super.key,
    required this.paymentCard,
    this.onPressed,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          color: LemonColor.atomicBlack,
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            if (paymentCard.brand != null)
              Container(
                width: Sizing.mSmall,
                height: Sizing.mSmall,
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Center(
                  child: PaymentCardBrandIcon(cardBrand: paymentCard.brand!),
                ),
              ),
            SizedBox(width: Spacing.xSmall),
            Text(
              t.event.eventPayment
                  .cardEnding(lastCardNumber: paymentCard.last4 ?? ''),
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary.withOpacity(0.87),
              ),
            ),
            const Spacer(),
            if (selected)
              Assets.icons.icChecked.svg(
                colorFilter: ColorFilter.mode(
                  LemonColor.paleViolet,
                  BlendMode.srcIn,
                ),
              ),
            SizedBox(width: 1.w),
          ],
        ),
      ),
    );
  }
}
