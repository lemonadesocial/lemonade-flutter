import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_basic_info_page/widgets/create_vault_chains_list.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateVaultBasicInfoPage extends StatelessWidget {
  const CreateVaultBasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        leading: const LemonBackButton(),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${t.vault.vaultType.individual} ${StringUtils.capitalize(t.vault.vault(n: 1))}',
                  style: Typo.extraLarge.copyWith(
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                Text(
                  t.vault.createVault.setupYourNewVault,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
                LemonTextField(
                  onChange: (value) {},
                  hintText: t.vault.createVault.enterVaultName,
                ),
                SizedBox(height: Spacing.smMedium * 2),
                const CreateVaultChainsList(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
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
          ),
        ],
      ),
    );
  }
}
