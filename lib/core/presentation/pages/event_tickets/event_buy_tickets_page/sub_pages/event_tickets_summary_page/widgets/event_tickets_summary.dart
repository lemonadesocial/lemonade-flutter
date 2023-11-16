import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTicketsSummary extends StatelessWidget {
  final List<PurchasableTicketType> ticketTypes;
  final List<PurchasableItem> selectedTickets;
  final Currency selectedCurrency;
  final EventTicketsPricingInfo pricingInfo;
  const EventTicketsSummary({
    super.key,
    required this.ticketTypes,
    required this.selectedTickets,
    required this.selectedCurrency,
    required this.pricingInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: selectedTickets.map((selectedTicket) {
        final selectedTicketType =
            ticketTypes.firstWhere((item) => item.id == selectedTicket.id);
        final currencyInfo = pricingInfo
            .paymentAccounts?.first.accountInfo?.currencyMap?[selectedCurrency];

        return TicketSummaryItem(
          ticketType: selectedTicketType,
          count: selectedTicket.count,
          currency: selectedCurrency,
          currencyInfo: currencyInfo,
        );
      }).toList(),
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
  final Currency currency;
  final CurrencyInfo? currencyInfo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCrypto = PaymentUtils.isCryptoCurrency(currency);

    return Container(
      margin: EdgeInsets.only(bottom: Spacing.xSmall),
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$count x  '),
          Text(ticketType.title ?? ''),
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
                amount: (ticketType.defaultPrice?.fiatCost?.toDouble() ?? 0) *
                    count,
                currency: currency,
              ),
            ),
          if (isCrypto)
            Text(
              Web3Utils.formatCryptoCurrency(
                ticketType.prices![currency]!.cryptoCost! * BigInt.from(count),
                currency: currency,
                decimals: currencyInfo?.decimals ?? 0,
              ),
            ),
        ],
      ),
    );
  }
}
