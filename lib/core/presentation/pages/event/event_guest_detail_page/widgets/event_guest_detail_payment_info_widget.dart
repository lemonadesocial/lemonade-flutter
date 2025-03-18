import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventGuestDetailPaymentInfoWidget extends StatelessWidget {
  final EventGuestDetail eventGuestDetail;
  const EventGuestDetailPaymentInfoWidget({
    super.key,
    required this.eventGuestDetail,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final payment = eventGuestDetail.payment;
    if (payment == null) {
      return const SizedBox.shrink();
    }
    final widgets = [
      _PaymentInfoItem(
        title: t.event.eventGuestDetail.paid,
        value: '${payment.formattedTotalAmount} ${payment.currency}',
      ),
      if (payment.stripePaymentInfo != null)
        _PaymentInfoItem(
          title: t.event.eventGuestDetail.paymentMethod,
          value:
              '${payment.stripePaymentInfo?.card?.brand} **** ${payment.stripePaymentInfo?.card?.last4}',
        ),
      if (payment.stripePaymentInfo != null)
        _PaymentInfoItem(
          title: t.event.eventGuestDetail.stripePaymentId,
          value: Web3Utils.formatIdentifier(
            payment.stripePaymentInfo?.paymentIntent ?? '',
          ),
          onTap: () {
            final paymentId = payment.stripePaymentInfo?.paymentIntent;
            if (paymentId != null && paymentId.isNotEmpty) {
              Clipboard.setData(ClipboardData(text: paymentId));
              SnackBarUtils.showInfo(
                title: t.common.copied,
              );
            }
          },
        ),
      if (payment.cryptoPaymentInfo != null)
        ChainQuery(
          chainId: payment.cryptoPaymentInfo?.network ?? '',
          builder: (chain, {required bool isLoading}) => _PaymentInfoItem(
            title: t.event.eventGuestDetail.chain,
            value: chain?.name ?? payment.cryptoPaymentInfo?.network ?? '',
            icon: chain?.logoUrl != null
                ? LemonNetworkImage(
                    imageUrl: chain?.logoUrl ?? '',
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                  )
                : null,
          ),
        ),
      if (payment.cryptoPaymentInfo != null)
        _PaymentInfoItem(
          title: t.event.eventGuestDetail.walletID,
          value:
              Web3Utils.formatIdentifier('${payment.transferParams?['from']}'),
        ),
      if (payment.cryptoPaymentInfo != null)
        _PaymentInfoItem(
          title: t.event.eventGuestDetail.transactionID,
          value: Web3Utils.formatIdentifier(
            payment.cryptoPaymentInfo?.txHash ?? '',
          ),
        ),
      _PaymentInfoItem(
        title: t.event.eventGuestDetail.status,
        value: PaymentUtils.getPaymentStatus(payment.state),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.event.eventGuestDetail.payment,
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
  final VoidCallback? onTap;
  final Widget? icon;

  const _PaymentInfoItem({
    required this.title,
    required this.value,
    this.onTap,
    this.icon,
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
        SizedBox(height: Spacing.superExtraSmall / 2),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: Spacing.superExtraSmall / 2),
                  child: icon!,
                ),
              Text(
                value,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
