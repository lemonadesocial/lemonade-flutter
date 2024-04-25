import 'package:app/core/domain/cubejs/cubejs_enums.dart';
import 'package:app/core/domain/cubejs/entities/cube_payment/cube_payment.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/cubejs_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardRevenueTotalTicketsSold extends StatelessWidget {
  final List<CubePaymentMember> payments;
  const DashboardRevenueTotalTicketsSold({
    super.key,
    required this.payments,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final totalTicketsSold = CubeJsUtils.calculateTotalTicketSold(payments);
    final totalTicketsSoldInCrypto = CubeJsUtils.calculateTotalTicketSold(
      payments
          .where((item) => item.kind == CubePaymentKind.Crypto.name)
          .toList(),
    );
    final totalTicketsSoldInFiat = CubeJsUtils.calculateTotalTicketSold(
      payments
          .where((item) => item.kind != CubePaymentKind.Crypto.name)
          .toList(),
    );
    double ratioFiat =
        totalTicketsSold != 0 ? totalTicketsSoldInFiat / totalTicketsSold : 1;
    double ratioCrypto =
        totalTicketsSold != 0 ? totalTicketsSoldInCrypto / totalTicketsSold : 1;
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.event.eventDashboard.revenue.totalTicketsSold,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                LemonOutlineButton(
                  radius: BorderRadius.circular(LemonRadius.normal),
                  backgroundColor: colorScheme.secondaryContainer,
                  borderColor: Colors.transparent,
                  label: totalTicketsSold.toString(),
                  leading: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icTicket.svg(
                      colorFilter: filter,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.smMedium),
            PaymentKindMeter(
              fiatRatio: ratioFiat,
              cryptoRatio: ratioCrypto,
            ),
            SizedBox(height: Spacing.smMedium),
            PaymentKindTicketsSold(
              ratio: ratioFiat,
              count: totalTicketsSoldInFiat,
              label: t.event.eventDashboard.revenue.cardSales,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icCash.svg(
                  colorFilter: filter,
                ),
              ),
              ratioColor: LemonColor.malachiteGreen,
            ),
            SizedBox(height: Spacing.small),
            PaymentKindTicketsSold(
              ratio: ratioCrypto,
              count: totalTicketsSoldInCrypto,
              label: t.event.eventDashboard.revenue.cryptoSales,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icWallet.svg(
                  colorFilter: filter,
                ),
              ),
              ratioColor: LemonColor.paleViolet,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentKindMeter extends StatelessWidget {
  final double fiatRatio;
  final double cryptoRatio;
  const PaymentKindMeter({
    super.key,
    required this.fiatRatio,
    required this.cryptoRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: (fiatRatio * 100).toInt(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              gradient: LinearGradient(
                colors: [
                  LemonColor.atomicBlack,
                  LemonColor.malachiteGreen,
                ],
              ),
            ),
            height: 6.w,
          ),
        ),
        SizedBox(width: Spacing.superExtraSmall),
        Expanded(
          flex: (cryptoRatio * 100).toInt(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              gradient: LinearGradient(
                colors: [
                  LemonColor.atomicBlack,
                  LemonColor.paleViolet,
                ],
              ),
            ),
            height: 6.w,
          ),
        ),
      ],
    );
  }
}

class PaymentKindTicketsSold extends StatelessWidget {
  final String label;
  final Widget icon;
  final double ratio;
  final Color ratioColor;
  final int count;
  const PaymentKindTicketsSold({
    super.key,
    required this.ratio,
    required this.count,
    required this.label,
    required this.icon,
    required this.ratioColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: Spacing.extraSmall),
        Text(label),
        SizedBox(width: Spacing.extraSmall),
        Expanded(
          child: DottedLine(
            dashColor: colorScheme.outline,
            dashLength: 5.w,
            lineThickness: 2.w,
          ),
        ),
        SizedBox(width: Spacing.extraSmall),
        Text(
          count.toString(),
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Container(
          padding: EdgeInsets.all(Spacing.superExtraSmall),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall / 2),
          ),
          child: Center(
            child: Text(
              '${(ratio * 100).toStringAsFixed(0)}%',
              style: Typo.xSmall.copyWith(
                color: ratioColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
