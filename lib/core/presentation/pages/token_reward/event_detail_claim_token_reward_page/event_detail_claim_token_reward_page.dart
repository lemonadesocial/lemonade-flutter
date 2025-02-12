import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:app/core/domain/reward/reward_repository.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/presentation/pages/token_reward/views/claim_token_reward_processing_view.dart';
import 'package:app/core/presentation/pages/token_reward/views/claim_token_reward_success_view.dart';
import 'package:app/core/presentation/pages/token_reward/widgets/reward_by_vault_widget_item/reward_by_vault_widget_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/web3/token_reward/token_reward_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/graphql/backend/event/query/get_my_tickets.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart' as web3modal;

@RoutePage()
class EventDetailClaimTokenRewardPage extends StatefulWidget {
  final Event event;
  const EventDetailClaimTokenRewardPage({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailClaimTokenRewardPage> createState() =>
      _EventDetailClaimTokenRewardPageState();
}

class _EventDetailClaimTokenRewardPageState
    extends State<EventDetailClaimTokenRewardPage> {
  bool _isClaiming = false;
  bool _isSuccess = false;

  Future<List<RewardSignatureResponse>> getAllAvailableRewards() async {
    final payments = (await getIt<EventTicketRepository>().getMyTickets(
          input: Variables$Query$GetMyTickets(
            event: widget.event.id ?? '',
            withPaymentInfo: true,
          ),
        ))
            .fold(
              (l) => null,
              (r) => r,
            )
            ?.payments ??
        [];
    final response = await Future.wait(
      [
        getIt<RewardRepository>().generateClaimTicketRewardSignature(
          event: widget.event.id ?? '',
          payment: null,
        ),
        ...payments.map(
          (p) => getIt<RewardRepository>().generateClaimTicketRewardSignature(
            event: widget.event.id ?? '',
            payment: p.id ?? '',
          ),
        ),
      ],
    );
    final signatureResponses = response
        .map((r) => r.fold((l) => null, (r) => r))
        .whereType<RewardSignatureResponse>()
        .toList();
    return signatureResponses;
  }

  Future<void> _claim(
    TokenRewardVault? vault,
    RewardSignatureResponse? rewardSignatureResponse,
  ) async {
    if (_isClaiming) return;

    setState(() {
      _isClaiming = true;
    });
    try {
      final walletAddress =
          context.read<WalletBloc>().state.activeSession?.address;
      final txHash = await TokenRewardUtils.claimReward(
        vault: vault!,
        signature: rewardSignatureResponse!.signature!,
        from: walletAddress ?? '',
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
          _isClaiming = false;
        });
      }
    } catch (e) {
      setState(() {
        _isClaiming = false;
        _isSuccess = false;
      });
      SnackBarUtils.showError(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Stack(
      children: [
        Scaffold(
          appBar: LemonAppBar(
            title: t.event.tokenReward.claimRewards,
          ),
          body: FutureBuilder<List<RewardSignatureResponse>>(
            future: getAllAvailableRewards(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Loading.defaultLoading(context),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                );
              }
              final signatureResponses = snapshot.data ?? [];
              if (signatureResponses.isEmpty) {
                return Center(
                  child: EmptyList(
                    emptyText: t.common.defaultEmptyList,
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.small,
                    ),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        return _ClaimableRewardItem(
                          rewardSignatureResponse: signatureResponses[index],
                          onTapClaim: (vault) {
                            _claim(
                              vault,
                              signatureResponses[index],
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: signatureResponses.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (_isClaiming && !_isSuccess) const ClaimTokenRewardProcessingView(),
        if (_isSuccess)
          ClaimTokenRewardSuccessView(
            onTapDone: () {
              setState(() {
                _isSuccess = false;
                _isClaiming = false;
              });
            },
          ),
      ],
    );
  }
}

class _ClaimableRewardItem extends StatelessWidget {
  final RewardSignatureResponse rewardSignatureResponse;
  final Function(TokenRewardVault) onTapClaim;
  const _ClaimableRewardItem({
    required this.rewardSignatureResponse,
    required this.onTapClaim,
  });

  Map<TokenRewardVault?, List<TokenRewardSetting>>
      get rewardSettingsGroupByVault {
    return groupBy(
      rewardSignatureResponse.settings ?? <TokenRewardSetting>[],
      (rewardSetting) => rewardSetting.vaultExpanded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return RewardByVaultWidgetItem(
          onTapClaim: (vault) {
            onTapClaim(vault);
          },
          signature: rewardSignatureResponse.signature!,
          tokenRewardSettings:
              rewardSettingsGroupByVault.values.elementAt(index),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: rewardSettingsGroupByVault.length,
    );
  }
}
