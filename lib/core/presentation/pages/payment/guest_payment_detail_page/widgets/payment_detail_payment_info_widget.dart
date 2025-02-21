import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class PaymentDetailPaymentInfoWidget extends StatelessWidget {
  final Payment payment;
  const PaymentDetailPaymentInfoWidget({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final widgets = [
      _PaymentInfoItem(
        title: t.event.eventPaymentDetail.paid,
        value: '${payment.formattedTotalAmount} ${payment.currency}',
      ),
      if (payment.stripePaymentInfo != null)
        _PaymentInfoItem(
          title: t.event.eventPaymentDetail.paymentMethod,
          value:
              '${payment.stripePaymentInfo?.card?.brand} **** ${payment.stripePaymentInfo?.card?.last4}',
        ),
      if (payment.stripePaymentInfo != null)
        _PaymentInfoItem(
          title: t.event.eventPaymentDetail.stripePaymentId,
          value: payment.stripePaymentInfo?.paymentIntent ?? '',
        ),
      if (payment.cryptoPaymentInfo != null)
        _PaymentInfoItem(
          title: t.event.eventPaymentDetail.paymentMethod,
          value:
              Web3Utils.formatIdentifier('${payment.transferParams?['from']}'),
        ),
      if (payment.cryptoPaymentInfo != null)
        _PaymentInfoItem(
          title: 'Transaction ID',
          value: Web3Utils.formatIdentifier(
            payment.cryptoPaymentInfo?.txHash ?? '',
          ),
        ),
      if (payment.state != null)
        _PaymentInfoItem(
          title: 'Status',
          value: PaymentUtils.getPaymentStatus(payment.state!),
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Payment",
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.small),
        SizedBox(
          height: Sizing.medium,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => widgets[index],
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.small,
              child: VerticalDivider(
                width: Sizing.small,
                color: colorScheme.outline,
                thickness: 1,
              ),
            ),
            itemCount: widgets.length,
          ),
        ),
      ],
    );
  }
}

class _PaymentInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const _PaymentInfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Typo.small.copyWith(color: colorScheme.onSecondary),
        ),
        Text(
          value,
          style: Typo.medium.copyWith(color: colorScheme.onPrimary),
        ),
      ],
    );
  }
}
