import 'package:app/core/application/vault/create_vault_bloc/create_vault_bloc.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_basic_info_page/widgets/create_vault_chains_list.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateVaultBasicInfoPage extends StatelessWidget {
  const CreateVaultBasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final createVaultBloc = context.read<CreateVaultBloc>();
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
                    fontFamily: FontFamily.clashDisplay,
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
                  onChange: (value) {
                    createVaultBloc.add(
                      CreateVaultEvent.onVaultNameChanged(vaultName: value),
                    );
                  },
                  hintText: t.vault.createVault.enterVaultName,
                ),
                SizedBox(height: Spacing.smMedium * 2),
                BlocBuilder<CreateVaultBloc, CreateVaultState>(
                  buildWhen: (previous, current) =>
                      previous.data.selectedChain != current.data.selectedChain,
                  builder: (context, state) => CreateVaultChainsList(
                    selectedChain: state.data.selectedChain,
                    onSelectChain: (selectedChain) {
                      context.read<CreateVaultBloc>().add(
                            CreateVaultEvent.onChainSelected(
                              selectedChain: selectedChain,
                            ),
                          );
                    },
                  ),
                ),
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
                child: BlocBuilder<CreateVaultBloc, CreateVaultState>(
                  builder: (context, state) {
                    final isValid = state.data.vaultName?.isNotEmpty == true &&
                        state.data.selectedChain != null;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Opacity(
                          opacity: isValid ? 1 : 0.5,
                          child: LinearGradientButton(
                            onTap: () {
                              if (!isValid) return;
                              AutoRouter.of(context)
                                  .push(const CreateVaultSetupPhraseRoute());
                            },
                            label: t.common.next,
                            radius:
                                BorderRadius.circular(LemonRadius.small * 2),
                            height: Sizing.large,
                            mode: GradientButtonMode.lavenderMode,
                            textStyle: Typo.medium.copyWith(
                              color: colorScheme.onPrimary.withOpacity(0.87),
                              fontFamily: FontFamily.clashDisplay,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
