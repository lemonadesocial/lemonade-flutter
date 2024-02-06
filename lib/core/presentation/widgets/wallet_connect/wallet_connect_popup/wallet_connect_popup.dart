import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletConnectPopup extends StatelessWidget {
  const WalletConnectPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      backgroundColor: LemonColor.atomicBlack,
      child: Container(
        padding: EdgeInsets.only(
          top: Spacing.medium,
          bottom: Spacing.medium,
          left: Spacing.medium,
          right: Spacing.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.nft.walletConnectPopup.title,
              style: Typo.large.copyWith(
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
            SizedBox(height: Spacing.xSmall),
            Text(
              t.nft.walletConnectPopup.description,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: Spacing.medium),
            SelectWalletAppButton(
              onPressed: () => null,
              label: t.nft.supportedWalletApps.metamask,
              icon: Assets.icons.icMetamask.svg(),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectWalletAppButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget? icon;

  const SelectWalletAppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
        height: Sizing.xLarge,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: colorScheme.outline),
          borderRadius: BorderRadius.circular(LemonRadius.xSmall),
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: Typo.mediumPlus.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
            const Spacer(),
            if (icon != null) icon!,
          ],
        ),
      ),
    );
  }
}
