import 'package:app/core/application/vault/create_vault_bloc/create_vault_bloc.dart';
import 'package:app/core/application/vault/deploy_vault_with_wallet_bloc/deploy_vault_with_wallet_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/vault/input/get_init_safe_transaction_input/get_init_safe_transaction_input.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/presentation/widgets/web3/wallet_connect_active_session.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeployVaultIWithWalletAppView extends StatelessWidget {
  const DeployVaultIWithWalletAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, walletState) {
        if (walletState.activeSession == null) {
          return const Column(
            children: [
              ConnectWalletButton(),
            ],
          );
        }
        final createVaultData = context.read<CreateVaultBloc>().state.data;
        final userWalletAddress =
            getIt<WalletConnectService>().w3mService.address ?? '';
        final network = createVaultData.selectedChain!;
        return Column(
          children: [
            WalletConnectActiveSessionWidget(
              activeSession: walletState.activeSession,
            ),
            SizedBox(height: Spacing.xSmall),
            LinearGradientButton(
              onTap: () {
                context.read<DeployVaultWithWalletBloc>().add(
                      DeployVaultWithWalletEvent.startDeploy(
                        userWalletAddress: userWalletAddress,
                        network: network,
                        input: GetInitSafeTransactionInput(
                          owners: createVaultData.owners!,
                          threshold: createVaultData.threshold!,
                          network: network.chainId!,
                        ),
                      ),
                    );
              },
              label: t.vault.actions.createVault,
              mode: GradientButtonMode.lavenderMode,
              height: Sizing.large,
              radius: BorderRadius.circular(
                LemonRadius.button,
              ),
            ),
          ],
        );
      },
    );
  }
}
