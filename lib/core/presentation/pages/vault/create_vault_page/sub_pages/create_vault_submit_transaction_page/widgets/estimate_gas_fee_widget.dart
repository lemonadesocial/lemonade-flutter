import 'package:app/core/constants/crypto_ramp/crypto_ramp.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EstimateGasFeeWidget extends StatelessWidget {
  final Chain network;
  final BigInt estimatedGasFee;

  const EstimateGasFeeWidget({
    super.key,
    required this.network,
    required this.estimatedGasFee,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final tokenDecimals = (network.nativeToken?.decimals ?? 18).toInt();
    final tokenAmount = Web3Utils.getAmountByDecimals(
      estimatedGasFee,
      decimals: tokenDecimals,
    );
    return Column(
      children: [
        Row(
          children: [
            Text(
              t.vault.estimateFee,
            ),
            SizedBox(
              width: Spacing.xSmall,
            ),
            Text(
              tokenAmount < minTopupAmount
                  ? '≈ ${minTopupAmount.toString()} ${network.nativeToken?.symbol ?? ''}'
                  : '≈ ${Web3Utils.formatCryptoCurrency(
                      estimatedGasFee,
                      currency: network.nativeToken?.symbol ?? '',
                      decimals: tokenDecimals,
                    )}',
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
