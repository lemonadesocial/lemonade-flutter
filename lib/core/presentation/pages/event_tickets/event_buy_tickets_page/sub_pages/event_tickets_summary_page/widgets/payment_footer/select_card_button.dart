import 'package:app/core/domain/payment/entities/payment_card/payment_card.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
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
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.09),
              borderRadius: BorderRadius.circular(LemonRadius.normal),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  height: Sizing.xSmall,
                  width: Sizing.xSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
