import 'package:app/core/application/vault/create_vault_bloc/create_vault_bloc.dart';
import 'package:app/core/application/vault/deploy_vault_with_owner_key_bloc/deploy_vault_with_owner_key_bloc.dart';
import 'package:app/core/domain/web3/entities/raw_transaction.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_submit_transaction_page/widgets/estimate_gas_fee_widget.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_submit_transaction_page/widgets/owner_key_balance_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class DeployVaultWithOwnerKeyView extends StatefulWidget {
  final RawTransaction rawTransaction;
  const DeployVaultWithOwnerKeyView({
    super.key,
    required this.rawTransaction,
  });

  @override
  State<DeployVaultWithOwnerKeyView> createState() =>
      _DeployVaultWithOwnerKeyViewState();
}

class _DeployVaultWithOwnerKeyViewState
    extends State<DeployVaultWithOwnerKeyView> {
  @override
  Widget build(BuildContext context) {
    final createVaultData = context.read<CreateVaultBloc>().state.data;
    final selectedChain = createVaultData.selectedChain!;
    final ownerAddress = createVaultData.owners!.first;
    final t = Translations.of(context);

    return FutureBuilder<BigInt>(
      future: Web3Utils.estimateGasFee(
        selectedChain,
        sender: EthereumAddress.fromHex(ownerAddress),
        to: EthereumAddress.fromHex(widget.rawTransaction.to!),
        data: hexToBytes(widget.rawTransaction.data!),
      ),
      builder: (context, gasFreeSnapshot) => Column(
        children: [
          OwnerKeyBalanceWidget(
            network: createVaultData.selectedChain!,
            ownerAddress: ownerAddress,
            estimatedGasFee: gasFreeSnapshot.data ?? BigInt.zero,
            onPressRefresh: () => setState(() {}),
          ),
          SizedBox(height: Spacing.xSmall),
          EstimateGasFeeWidget(
            network: createVaultData.selectedChain!,
            estimatedGasFee: gasFreeSnapshot.data ?? BigInt.zero,
          ),
          SizedBox(height: Spacing.xSmall),
          FutureBuilder(
            future: Web3Utils.getBalance(
              EthereumAddress.fromHex(ownerAddress),
              network: selectedChain,
            ),
            builder: (context, snapshot) {
              final balanceAmount = snapshot.data ?? BigInt.zero;
              final isDisabled =
                  gasFreeSnapshot.connectionState == ConnectionState.waiting ||
                      balanceAmount <= (gasFreeSnapshot.data ?? BigInt.zero);

              return Opacity(
                opacity: isDisabled ? 0.5 : 1,
                child: LinearGradientButton(
                  radius: BorderRadius.circular(LemonRadius.button),
                  height: 42.w,
                  mode: GradientButtonMode.lavenderMode,
                  onTap: () async {
                    if (isDisabled) return;
                    context.read<DeployVaultWithOwnerKeyBloc>().add(
                          DeployVaultWithOwnerKeyEvent.startDeploy(
                            rawTransaction: widget.rawTransaction,
                            ownerAddress: ownerAddress,
                            network: selectedChain,
                          ),
                        );
                  },
                  label: t.common.next,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
