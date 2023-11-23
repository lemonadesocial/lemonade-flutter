import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/ticket_wave_custom_paint.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventOrderSummary extends StatelessWidget {
  const EventOrderSummary({
    super.key,
    required this.pricingInfo,
    required this.selectedCurrency,
  });

  final EventTicketsPricingInfo pricingInfo;
  final Currency selectedCurrency;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isCryptoCurrency = PaymentUtils.isCryptoCurrency(selectedCurrency);
    final currencyInfo =
        PaymentUtils.getCurrencyInfo(pricingInfo, currency: selectedCurrency);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraint) => CustomPaint(
              size: Size(constraint.maxWidth, 11.w),
              painter: TicketWaveCustomPaint(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(LemonRadius.normal),
                bottomRight: Radius.circular(LemonRadius.normal),
              ),
            ),
            padding: EdgeInsets.only(
              top: Spacing.medium,
              left: Spacing.medium,
              right: Spacing.medium,
              bottom: Spacing.xSmall,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SummaryRow(
                  label: t.event.eventOrder.itemTotal,
                  value: isCryptoCurrency
                      ? Web3Utils.formatCryptoCurrency(
                          pricingInfo.cryptoSubTotal ?? BigInt.zero,
                          currency: selectedCurrency,
                          decimals: currencyInfo?.decimals ?? 0,
                        )
                      : NumberUtils.formatCurrency(
                          amount: pricingInfo.fiatSubTotal ?? 0,
                          currency: selectedCurrency,
                        ),
                  textColor: colorScheme.onPrimary.withOpacity(0.87),
                ),
                if (pricingInfo.discount != null &&
                    pricingInfo.promoCode?.isNotEmpty == true) ...[
                  SizedBox(height: Spacing.xSmall),
                  SummaryRow(
                    label:
                        '${t.event.eventOrder.promo} [${pricingInfo.promoCode}]',
                    value:
                        '-${isCryptoCurrency ? Web3Utils.formatCryptoCurrency(
                            pricingInfo.cryptoDiscount ?? BigInt.zero,
                            currency: selectedCurrency,
                            decimals: currencyInfo?.decimals ?? 0,
                          ) : NumberUtils.formatCurrency(
                            amount: pricingInfo.fiatDiscount ?? 0,
                            currency: selectedCurrency,
                          )}',
                    textColor: LemonColor.promoApplied,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(
            height: 3.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.medium,
              horizontal: Spacing.medium,
            ),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.normal),
                topRight: Radius.circular(LemonRadius.normal),
              ),
            ),
            child: SummaryRow(
              label: t.event.eventOrder.grandTotal,
              value: isCryptoCurrency
                  ? Web3Utils.formatCryptoCurrency(
                      pricingInfo.cryptoTotal ?? BigInt.zero,
                      currency: selectedCurrency,
                      decimals: currencyInfo?.decimals ?? 0,
                    )
                  : NumberUtils.formatCurrency(
                      amount: pricingInfo.fiatTotal ?? 0,
                      currency: selectedCurrency,
                    ),
              textStyle: Typo.mediumPlus.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Transform.flip(
            flipY: true,
            child: LayoutBuilder(
              builder: (context, constraint) => CustomPaint(
                size: Size(constraint.maxWidth, 11.w),
                painter: TicketWaveCustomPaint(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.textColor,
    this.textStyle,
  });

  final String label;
  final String value;
  final Color? textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final customTextStyle = textStyle ??
        Typo.mediumPlus.copyWith(
          color: textColor ?? colorScheme.onSecondary,
        );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: customTextStyle,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.w),
            child: DottedLine(
              dashColor: colorScheme.onPrimary.withOpacity(0.06),
            ),
          ),
        ),
        Text(
          value,
          style: customTextStyle,
        ),
      ],
    );
  }
}
