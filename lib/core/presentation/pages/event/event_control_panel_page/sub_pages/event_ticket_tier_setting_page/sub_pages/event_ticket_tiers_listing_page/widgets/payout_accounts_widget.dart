import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayoutAccountsWidget extends StatelessWidget {
  const PayoutAccountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.ticketTierSetting.payoutAccounts,
          style: Typo.medium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        PayoutAccountItem(
          title: t.event.ticketTierSetting.creditDebit,
          subTitle: t.event.ticketTierSetting.connectAccount,
          icon: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icCash.svg(
              colorFilter: filter,
            ),
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        PayoutAccountItem(
          title: t.event.ticketTierSetting.crypto,
          subTitle: t.common.actions.connectWallet,
          icon: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icWallet.svg(
              colorFilter: filter,
            ),
          ),
        ),
      ],
    );
  }
}

class PayoutAccountItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;

  const PayoutAccountItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              border: Border.all(
                color: LemonColor.chineseBlack,
              ),
            ),
            child: Center(
              child: icon,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  subTitle,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Edit icon
          LinearGradientButton(
            height: Sizing.medium,
            radius: BorderRadius.circular(LemonRadius.small * 2),
            label: t.common.actions.connect,
          ),
        ],
      ),
    );
  }
}
