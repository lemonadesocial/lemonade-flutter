import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/service/web3/escrow/escrow_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class EscrowFirstDepositAmountBuilder extends StatelessWidget {
  final EventJoinRequest eventJoinRequest;
  final Function({
    required String formattedFirstDepositAmount,
    required String formattedFirstDueAmount,
    required bool isLoading,
  }) builder;
  const EscrowFirstDepositAmountBuilder({
    super.key,
    required this.eventJoinRequest,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final escrowAccountInfo =
        eventJoinRequest.paymentExpanded?.accountExpanded?.accountInfo;
    final networkChainId = escrowAccountInfo?.network;
    final escrowContractAddress = escrowAccountInfo?.address ?? '';
    final paymentId = eventJoinRequest.paymentExpanded?.id ?? '';

    return FutureBuilder<BigInt?>(
      future: () async {
        if (networkChainId == null) {
          return null;
        }
        final chainResponse =
            await getIt<Web3Repository>().getChainById(chainId: networkChainId);
        final chain = chainResponse.fold((l) => null, (r) => r);
        if (chain == null) {
          return null;
        }
        final firstDepositAmount = await EscrowUtils.getFirstDepositAmount(
          chain: chain,
          paymentId: paymentId,
          escrowContractAddress: escrowContractAddress,
        );
        if (firstDepositAmount == null) {
          return null;
        }
        return firstDepositAmount;
      }(),
      builder: (context, snapshot) {
        final firstDepositAmount = snapshot.data ?? BigInt.zero;
        final firstDueAmount =
            BigInt.parse(eventJoinRequest.paymentExpanded?.amount ?? '0') -
                firstDepositAmount;
        final currency = eventJoinRequest.paymentExpanded?.currency;
        final decimals = escrowAccountInfo?.currencyMap
                ?.tryGet<CurrencyInfo>(currency ?? '')
                ?.decimals
                ?.toInt() ??
            18;

        final formattedFirstDepositAmount = Web3Utils.formatCryptoCurrency(
          firstDepositAmount,
          currency: currency ?? '',
          decimals: decimals,
        );

        final formattedFirstDueAmount = Web3Utils.formatCryptoCurrency(
          firstDueAmount,
          currency: currency ?? '',
          decimals: decimals,
        );

        return builder(
          formattedFirstDepositAmount: formattedFirstDepositAmount,
          formattedFirstDueAmount: formattedFirstDueAmount,
          isLoading: snapshot.connectionState == ConnectionState.waiting,
        );
      },
    );
  }
}
