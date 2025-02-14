import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentLedgerItem extends StatelessWidget {
  final Payment payment;
  const PaymentLedgerItem({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.chineseBlack,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizing.small),
              topRight: Radius.circular(Sizing.small),
            ),
          ),
          child: Row(
            children: [
              _BuyerInfoWidget(payment: payment),
            ],
          ),
        ),
        Divider(
          color: colorScheme.outlineVariant,
          thickness: 1.w,
          height: 1.w,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Spacing.small),
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Sizing.small),
              bottomRight: Radius.circular(Sizing.small),
            ),
          ),
          child: _PaymentInfoWidget(payment: payment),
        ),
      ],
    );
  }
}

class _PaymentInfoWidget extends StatelessWidget {
  const _PaymentInfoWidget({
    required this.payment,
  });

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: Spacing.extraSmall,
      runSpacing: Spacing.extraSmall,
      children: [
        FittedBox(
          child: LemonOutlineButton(
            leading: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icTicket.svg(
                colorFilter: filter,
              ),
            ),
            label: payment.tickets?.length.toString() ?? '1',
          ),
        ),
        FittedBox(
          child: LemonOutlineButton(
            leading: (payment.stripePaymentInfo != null ||
                    payment.cryptoPaymentInfo == null)
                ? Assets.icons.icStripeCircle.svg()
                : ChainQuery(
                    chainId: payment.cryptoPaymentInfo?.network ?? '',
                    builder: (
                      chain, {
                      required bool isLoading,
                    }) =>
                        LemonNetworkImage(
                      imageUrl: chain?.logoUrl ?? '',
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                    ),
                  ),
            label: '${payment.formattedTotalAmount} ${payment.currency}',
          ),
        ),
        if (payment.discountCode.isNotEmpty)
          FittedBox(
            child: LemonOutlineButton(
              leading: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icDiscount.svg(
                  colorFilter: filter,
                ),
              ),
              label: payment.discountCode,
            ),
          ),
      ],
    );
  }
}

class _BuyerInfoWidget extends StatelessWidget {
  final Payment payment;
  const _BuyerInfoWidget({
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        LemonNetworkImage(
          imageUrl: payment.buyerAvatar,
          width: Sizing.medium,
          height: Sizing.medium,
          borderRadius: BorderRadius.circular(Sizing.medium),
          placeholder: ImagePlaceholder.avatarPlaceholder(),
        ),
        SizedBox(
          width: Spacing.small,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              payment.buyerName,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            Text(
              payment.buyerEmail,
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
