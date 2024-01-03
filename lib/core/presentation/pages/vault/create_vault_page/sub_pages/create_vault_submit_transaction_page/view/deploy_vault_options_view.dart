import 'package:app/core/application/vault/create_vault_bloc/create_vault_bloc.dart';
import 'package:app/core/domain/vault/input/get_init_safe_transaction_input/get_init_safe_transaction_input.dart';
import 'package:app/core/domain/vault/vault_repository.dart';
import 'package:app/core/domain/web3/entities/raw_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_submit_transaction_page/view/deploy_vault_with_owner_key_view.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_submit_transaction_page/view/deploy_vault_with_wallet_app_view.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DeployVaultOptions {
  wallet,
  ownerKey,
}

class DeployVaultOptionsView extends StatefulWidget {
  const DeployVaultOptionsView({super.key});

  @override
  State<DeployVaultOptionsView> createState() => _DeployVaultOptionsViewState();
}

class _DeployVaultOptionsViewState extends State<DeployVaultOptionsView> {
  DeployVaultOptions deployVaultOption = DeployVaultOptions.ownerKey;

  @override
  Widget build(BuildContext context) {
    final createVaultData = context.read<CreateVaultBloc>().state.data;
    final t = Translations.of(context);
    return Column(
      children: [
        RadioListTile(
          activeColor: LemonColor.lavender,
          contentPadding: EdgeInsets.zero,
          title: Text(
            t.vault.createVault.topupOwnerKeyBalance,
            style: Typo.medium,
          ),
          value: DeployVaultOptions.ownerKey,
          groupValue: deployVaultOption,
          onChanged: (value) {
            setState(() {
              deployVaultOption = value!;
            });
          },
        ),
        RadioListTile(
          activeColor: LemonColor.lavender,
          contentPadding: EdgeInsets.zero,
          title: Text(
            t.event.eventCryptoPayment.connectWallet,
            style: Typo.medium,
          ),
          value: DeployVaultOptions.wallet,
          groupValue: deployVaultOption,
          onChanged: (value) {
            setState(() {
              deployVaultOption = value!;
            });
          },
        ),
        FutureBuilder<dartz.Either<Failure, RawTransaction>>(
          future: getIt<VaultRepository>().getInitSafeTransaction(
            input: GetInitSafeTransactionInput(
              owners: createVaultData.owners!,
              threshold: createVaultData.threshold!,
              network: createVaultData.selectedChain!.chainId!,
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 120.w,
                child: Loading.defaultLoading(context),
              );
            }

            if (snapshot.hasError ||
                (snapshot.hasData && snapshot.data?.isLeft() == true)) {
              return const EmptyList();
            }

            final rawTransaction =
                snapshot.data!.getOrElse(() => RawTransaction());

            if (deployVaultOption == DeployVaultOptions.wallet) {
              return const DeployVaultIWithWalletAppView();
            }

            return DeployVaultWithOwnerKeyView(
              rawTransaction: rawTransaction,
            );
          },
        ),
      ],
    );
  }
}
