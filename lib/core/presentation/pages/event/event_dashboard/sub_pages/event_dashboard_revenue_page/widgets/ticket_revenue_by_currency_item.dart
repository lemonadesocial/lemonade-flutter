import 'package:app/core/domain/cubejs/cubejs_enums.dart';
import 'package:app/core/domain/cubejs/entities/cube_payment/cube_payment.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/utils/cubejs_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class TicketRevenueByCurrencyItem extends StatelessWidget {
  final String currency;
  final List<CubePaymentMember> payments;
  final int decimals;
  final bool isLast;

  const TicketRevenueByCurrencyItem({
    super.key,
    required this.currency,
    required this.payments,
    this.decimals = 0,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isFiat = payments.firstOrNull?.kind == CubePaymentKind.Fiat.name;
    final totalAmount = CubeJsUtils.calculateTotalAmount(payments);
    final totalSoldCount =
        CubeJsUtils.calculateTotalTicketSold(payments).toString();
    final displayedTotalAmount = isFiat
        ? NumberUtils.formatCurrency(
            amount: totalAmount.toDouble(),
            attemptedDecimals: decimals,
            currency: currency,
          )
        : Web3Utils.formatCryptoCurrency(
            totalAmount,
            currency: currency,
            decimals: decimals,
          );

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.superExtraSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text.rich(
            TextSpan(
              text: '$totalSoldCount ${t.event.eventDashboard.revenue.sold}',
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
              children: [
                TextSpan(text: ' ($currency)'),
              ],
            ),
          ),
          Expanded(
            child: DottedLine(
              dashColor: colorScheme.outline,
            ),
          ),
          Text(
            displayedTotalAmount,
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
