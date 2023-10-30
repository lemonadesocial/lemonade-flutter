import 'package:app/core/application/payment/payment_bloc/payment_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_card_entity/payment_card_entity.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCardItem extends StatelessWidget {
  const PaymentCardItem({
    super.key,
    required this.listCard,
    required this.cardInfo,
  });

  final List<PaymentCard> listCard;
  final PaymentCard cardInfo;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.small),
        color: colorScheme.onPrimary.withOpacity(0.06),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: Center(
              child: Assets.icons.icVisa.image(
                width: Sizing.small,
                height: 7.w,
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Text(
            t.event.eventPayment.cardEnding(lastCardNumber: cardInfo.last4),
            style: Typo.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary.withOpacity(0.87),
            ),
          ),
          const Spacer(),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              return Checkbox(
                value: cardInfo == state.selectedCard,
                shape: const CircleBorder(),
                onChanged: (_) =>
                    context.read<PaymentBloc>().onCardSelected(cardInfo),
              );
            },
          ),
          SizedBox(width: 1.w),
        ],
      ),
    );
  }
}
