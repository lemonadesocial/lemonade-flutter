import 'package:app/core/domain/payment/entities/payment_card_entity/payment_card_entity.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCardTile extends StatelessWidget {
  const EventCardTile({
    Key? key,
    required this.paymentCardEntity,
  }) : super(key: key);

  final PaymentCard paymentCardEntity;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => context.router.push(const EventTicketsPaymentMethodRoute()),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
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
                  lastCardNumber: paymentCardEntity.last4,
                ),
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
