import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';

import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTicketsSummary extends StatelessWidget {
  final List<PurchasableTicketType> ticketTypes;
  final List<PurchasableItem> selectedTickets;
  final String selectedCurrency;
  final EventTicketsPricingInfo pricingInfo;
  final PaymentAccount? selectedPaymentAccount;

  const EventTicketsSummary({
    super.key,
    required this.ticketTypes,
    required this.selectedTickets,
    required this.selectedCurrency,
    required this.pricingInfo,
    required this.selectedPaymentAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: selectedTickets.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: Spacing.xSmall),
          itemBuilder: (context, index) {
            final selectedTicket = selectedTickets[index];
            final selectedTicketType =
                ticketTypes.firstWhere((item) => item.id == selectedTicket.id);
            final currencyInfo = PaymentUtils.getCurrencyInfo(
              selectedPaymentAccount,
              currency: selectedCurrency,
            );

            return TicketSummaryItem(
              ticketType: selectedTicketType,
              count: selectedTicket.count,
              currency: selectedCurrency,
              currencyInfo: currencyInfo,
            );
          },
        ),
        // ],
      ],
    );
  }
}

class TicketSummaryItem extends StatelessWidget {
  const TicketSummaryItem({
    super.key,
    required this.count,
    required this.ticketType,
    required this.currency,
    this.currencyInfo,
  });

  final PurchasableTicketType ticketType;
  final int count;
  final String currency;
  final CurrencyInfo? currencyInfo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCrypto = currencyInfo?.contracts?.isNotEmpty == true;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$count x ${ticketType.title ?? ''}',
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(width: Spacing.extraSmall),
        InkWell(
          onTap: () => context.router.pop(),
          child: Container(
            width: 21.w,
            height: 21.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              color: colorScheme.outline,
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: Sizing.small / 2,
                  height: Sizing.small / 2,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        if (!isCrypto)
          Text(
            NumberUtils.formatCurrency(
              amount: (EventTicketUtils.getTicketPriceByCurrencyAndNetwork(
                        ticketType: ticketType,
                        currency: currency,
                      )?.fiatCost ??
                      0) *
                  count,
              currency: currency,
            ),
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        if (isCrypto)
          Text(
            Web3Utils.formatCryptoCurrency(
              (EventTicketUtils.getTicketPriceByCurrencyAndNetwork(
                        ticketType: ticketType,
                        currency: currency,
                      )?.cryptoCost ??
                      BigInt.zero) *
                  BigInt.from(count),
              currency: currency,
              decimals: currencyInfo?.decimals ?? 0,
            ),
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
      ],
    );
  }
}
