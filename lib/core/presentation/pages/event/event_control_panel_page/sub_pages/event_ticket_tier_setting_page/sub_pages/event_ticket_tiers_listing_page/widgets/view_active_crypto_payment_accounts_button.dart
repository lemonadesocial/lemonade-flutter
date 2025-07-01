import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ViewActiveCryptoPaymentAccountsButton extends StatelessWidget {
  const ViewActiveCryptoPaymentAccountsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: () {
        context.router.push(
          const EventActiveCryptoPaymentAccountsRoute(),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: appColors.cardBg,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icParkOutline.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Text(
                t.event.ticketTierSetting.activeNetworks,
                style: Typo.medium.copyWith(
                  color: appColors.textPrimary,
                ),
              ),
            ),
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
