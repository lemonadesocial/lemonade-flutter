import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateVaultSetupPhrasePage extends StatelessWidget {
  const CreateVaultSetupPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.vault.createVault.beforeContinue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoCard(
              icon: Assets.icons.icHome.svg(),
              title: t.vault.createVault.safeEnvironment,
              subTitle: t.vault.createVault.safeEnvironmentDescription,
            ),
            SizedBox(height: Spacing.xSmall),
            _InfoCard(
              icon: Assets.icons.icWarning.svg(),
              title: t.vault.createVault.sensitiveInformation,
              subTitle: t.vault.createVault.sensitiveInformationDescription,
            ),
            SizedBox(height: Spacing.xSmall),
            _InfoCard(
              icon: Assets.icons.icShield.svg(),
              title: t.vault.createVault.safelyStored,
              subTitle: t.vault.createVault.safelyStoredDescription,
            ),
            const Spacer(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.smMedium,
                ),
                child: LinearGradientButton(
                  label: t.common.next,
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  height: Sizing.large,
                  mode: GradientButtonMode.lavenderMode,
                  textStyle: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subTitle;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        Spacing.medium,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.smMedium),
        border: Border.all(
          color: colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: Spacing.smMedium),
          Text(
            title,
            style: Typo.medium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            subTitle,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
