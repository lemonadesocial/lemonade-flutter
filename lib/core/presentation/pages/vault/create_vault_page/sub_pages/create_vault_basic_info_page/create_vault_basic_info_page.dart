import 'package:app/core/application/payment/create_payment_account_bloc/create_payment_account_bloc.dart';
import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/application/vault/create_vault_bloc/create_vault_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_basic_info_page/widgets/create_vault_chains_list.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/presentation/widgets/web3/wallet_connect_active_session.dart';
import 'package:app/core/service/vault/vault_secure_storage.dart';
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
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:app/core/utils/auth_utils.dart' as auth_utils;

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
                child: BlocConsumer<WalletBloc, WalletState>(
                  listener: (context, walletConnectState) {
                    if (walletConnectState.activeSession == null) return;

                    final sessionAccount = walletConnectState.activeSession
                        ?.namespaces.entries.first.value.accounts.first;
                    final userWalletAddress =
                        NamespaceUtils.getAccount(sessionAccount!)
                            .toLowerCase();
                    createVaultBloc.add(
                      CreateVaultEvent.onOwnersChanged(
                        owners: [userWalletAddress],
                      ),
                    );
                    createVaultBloc.add(
                      CreateVaultEvent.onThresholdChanged(
                        threshold: 1,
                      ),
                    );
                  },
                  builder: (context, walletConnectState) {
                    if (walletConnectState.activeSession == null) {
                      return ConnectWalletButton(
                        onSelect: (walletApp) {
                          context.read<WalletBloc>().add(
                                WalletEvent.connectWallet(
                                  walletApp: walletApp,
                                  chainId: context
                                      .read<CreateVaultBloc>()
                                      .state
                                      .data
                                      .selectedChain
                                      ?.fullChainId,
                                ),
                              );
                        },
                      );
                    }

                    return BlocBuilder<CreateVaultBloc, CreateVaultState>(
                      builder: (context, state) => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          WalletConnectActiveSessionWidget(
                            title: t.vault.connectedWith,
                            activeSession: walletConnectState.activeSession!,
                          ),
                          SizedBox(height: Spacing.smMedium),
                          Opacity(
                            opacity: state.isValid ? 1 : 0.5,
                            child: LinearGradientButton(
                              onTap: () {
                                if (!state.isValid) return;
                                final data = state.data;
                                context.read<CreatePaymentAccountBloc>().add(
                                      CreatePaymentAccountEvent.create(
                                        input: CreatePaymentAccountInput(
                                          title: data.vaultName,
                                          type: PaymentAccountType.ethereum,
                                          provider: PaymentProvider.safe,
                                          accountInfo: AccountInfoInput(
                                            owners: data.owners,
                                            threshold: data.threshold,
                                            network:
                                                data.selectedChain?.chainId,
                                            currencies: (data.selectedChain
                                                        ?.tokens ??
                                                    [])
                                                .map(
                                                  (token) => token.symbol ?? '',
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    );
                              },
                              label: t.vault.actions.createVault,
                              radius:
                                  BorderRadius.circular(LemonRadius.small * 2),
                              height: Sizing.large,
                              mode: GradientButtonMode.lavenderMode,
                              textStyle: Typo.medium.copyWith(
                                color: colorScheme.onPrimary.withOpacity(0.87),
                                fontFamily: FontFamily.nohemiVariable,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          BlocConsumer<CreatePaymentAccountBloc, CreatePaymentAccountState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
                success: (vault) async {
                  // when create wallet success
                  // Check if already set passcode ?
                  // if yes => Go to success page
                  final userId = auth_utils.AuthUtils.getUserId(context);
                  if (await VaultSecureStorage.hasPinCode(userId)) {
                    return AutoRouter.of(context).replaceAll(
                      [
                        CreateVaultSuccessRoute(
                          vaultName: vault.title,
                          vaultType: VaultType.individual,
                          onPressed: (innerContext) {
                            innerContext.read<GetPaymentAccountsBloc>().add(
                                  GetPaymentAccountsEvent.fetch(
                                    input: GetPaymentAccountsInput(
                                      type: PaymentAccountType.ethereum,
                                      provider: PaymentProvider.safe,
                                    ),
                                  ),
                                );
                            AutoRouter.of(innerContext).pop();
                          },
                        ),
                      ],
                    );
                  } else {
                    // if no => Go to setup passcode page
                    AutoRouter.of(context).replaceAll([
                      CreateVaultSetupPinRoute(
                        vault: vault,
                      ),
                    ]);
                  }
                },
              );
            },
            builder: (context, state) => state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => Align(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Loading.defaultLoading(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
