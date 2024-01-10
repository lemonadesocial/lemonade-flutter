import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TicketTierPricingItem extends StatelessWidget {
  final TicketPriceInput ticketPrice;
  final EventCurrency? currencyInfo;

  const TicketTierPricingItem({
    super.key,
    required this.ticketPrice,
    this.currencyInfo,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final decimals = currencyInfo?.decimals?.toInt() ?? 0;
    final formatter = NumberFormat.currency(
      symbol: ticketPrice.currency,
      decimalDigits: decimals,
    );
    final doubleAmount = NumberUtils.getAmountByDecimals(
      BigInt.parse(ticketPrice.cost),
      decimals: decimals,
    );
    final isERC20 = ticketPrice.network?.isNotEmpty == true;
    final erc20DisplayedAmount = Web3Utils.formatCryptoCurrency(
      BigInt.parse(ticketPrice.cost),
      currency: ticketPrice.currency,
      decimals: decimals,
    );

    return Row(
      children: [
        Container(
          width: Sizing.medium,
          height: Sizing.medium,
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icCash.svg(colorFilter: filter),
            ),
          ),
        ),
        SizedBox(width: Spacing.small),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isERC20 ? erc20DisplayedAmount : formatter.format(doubleAmount),
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                t.event.ticketTierSetting.creditDebit,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
        ThemeSvgIcon(
          color: colorScheme.onSecondary,
          builder: (filter) =>
              Assets.icons.icMoreHoriz.svg(colorFilter: filter),
        ),
      ],
    );
  }
}
