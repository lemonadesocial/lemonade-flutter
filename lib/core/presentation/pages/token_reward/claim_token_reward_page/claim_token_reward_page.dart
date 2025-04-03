import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/presentation/pages/token_reward/views/claim_multiple_token_rewards_view.dart';
import 'package:app/core/presentation/pages/token_reward/views/claim_single_token_reward_view.dart';
import 'package:app/core/presentation/pages/token_reward/views/claim_token_reward_processing_view.dart';
import 'package:app/core/presentation/pages/token_reward/views/claim_token_reward_success_view.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/service/web3/token_reward/token_reward_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ClaimTokenRewardPage extends StatefulWidget {
  final RewardSignatureResponse rewardSignatureResponse;
  const ClaimTokenRewardPage({
    super.key,
    required this.rewardSignatureResponse,
  });

  @override
  State<ClaimTokenRewardPage> createState() => _ClaimTokenRewardPageState();
}

class _ClaimTokenRewardPageState extends State<ClaimTokenRewardPage> {
  bool _isLoading = false;
  bool _isSuccess = false;

  Map<TokenRewardVault?, List<TokenRewardSetting>>
      get rewardSettingsGroupByVault {
    return groupBy(
      widget.rewardSignatureResponse.settings ?? <TokenRewardSetting>[],
      (rewardSetting) => rewardSetting.vaultExpanded,
    );
  }

  Future<void> _claim(
    TokenRewardVault? vault,
  ) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });
    try {
      final walletAddress =
          getIt<WalletConnectService>().w3mService?.session?.address ?? '';
      final txHash = await TokenRewardUtils.claimReward(
        vault: vault!,
        signature: widget.rewardSignatureResponse.signature!,
        from: walletAddress,
      );
      final chain = (await getIt<Web3Repository>()
              .getChainById(chainId: vault.network ?? ''))
          .fold(
        (l) => null,
        (r) => r,
      );
      if (chain == null) {
        throw Exception('Chain not found');
      }
      final receipt = await Web3Utils.waitForReceipt(
        rpcUrl: chain.rpcUrl ?? '',
        txHash: txHash,
      );
      if (receipt?.status == true) {
        setState(() {
          _isSuccess = true;
        });
      } else {
        final t = Translations.of(context);
        SnackBarUtils.showError(
          message: t.event.tokenReward.claimRewardFailed,
        );
        setState(() {
          _isSuccess = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isSuccess = false;
      });
      SnackBarUtils.showError(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, walletState) {
        final walletConnected = walletState.activeSession != null;
        return Stack(
          children: [
            rewardSettingsGroupByVault.length == 1
                ? ClaimSingleTokenRewardView(
                    rewardSettingByVault: (
                      rewardSettingsGroupByVault.entries.first.key,
                      rewardSettingsGroupByVault.entries.first.value,
                    ),
                    ticketCount: 1,
                    walletConnected: walletConnected,
                    onTapClaim: () {
                      _claim(rewardSettingsGroupByVault.entries.first.key);
                    },
                    onTapDoItLater: () {
                      AutoRouter.of(context).pop(false);
                    },
                  )
                : ClaimMultipleTokenRewardsView(
                    signature: widget.rewardSignatureResponse.signature!,
                    rewardSettingsGroupByVault: rewardSettingsGroupByVault,
                    onTapClaim: (vault) {
                      _claim(vault);
                    },
                    onTapDoItLater: () {
                      AutoRouter.of(context).pop(false);
                    },
                  ),
            if (_isLoading && !_isSuccess)
              const ClaimTokenRewardProcessingView(),
            if (_isSuccess)
              ClaimTokenRewardSuccessView(
                onTapDone: () {
                  AutoRouter.of(context).pop(true);
                },
              ),
          ],
        );
      },
    );
  }
}
