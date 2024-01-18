import 'package:app/core/domain/crypto_ramp/crypto_ramp_repository.dart';
import 'package:app/core/domain/crypto_ramp/stripe_onramp/entities/stripe_onramp_session/stripe_onramp_session.dart';
import 'package:app/core/domain/crypto_ramp/stripe_onramp/input/create_stripe_onramp_session_input/create_stripe_onramp_session_input.dart';
import 'package:app/core/domain/crypto_ramp/stripe_onramp/stripe_onramp_enum.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/cryto-ramp/stripe_onramp/stripe_onramp_webview.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrix/matrix.dart';
import 'package:web3dart/web3dart.dart';

class OwnerKeyBalanceWidget extends StatefulWidget {
  final Chain network;
  final String ownerAddress;
  final Function()? onPressRefresh;

  const OwnerKeyBalanceWidget({
    super.key,
    required this.network,
    required this.ownerAddress,
    this.onPressRefresh,
  });

  @override
  State<OwnerKeyBalanceWidget> createState() => _OwnerKeyBalanceWidgetState();
}

class _OwnerKeyBalanceWidgetState extends State<OwnerKeyBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final nativeToken = widget.network.nativeToken;
    final nativeTokenDecimals = (nativeToken?.decimals ?? 18).toInt();

    return FutureBuilder<BigInt>(
      future: Web3Utils.getBalance(
        EthereumAddress.fromHex(widget.ownerAddress),
        network: widget.network,
      ),
      builder: (context, snapshot) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(text: widget.ownerAddress),
                  );
                  SnackBarUtils.showSuccessSnackbar(t.common.copiedToClipboard);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${t.vault.createVault.owner}: ${Web3Utils.formatIdentifier(widget.ownerAddress)}',
                      style: Typo.medium,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${t.vault.createVault.balance} ',
                          style: Typo.xSmall.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        Text(
                          Web3Utils.formatCryptoCurrency(
                            snapshot.data ?? BigInt.zero,
                            currency: nativeToken?.symbol ?? '',
                            decimals: nativeTokenDecimals,
                          ),
                          style: Typo.xSmall.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: Spacing.extraSmall),
              InkWell(
                onTap: widget.onPressRefresh,
                child: Icon(Icons.refresh, size: Sizing.xSmall),
              ),
            ],
          ),
          LinearGradientButton(
            onTap: () async {
              final destinationCurrency =
                  (nativeToken?.symbol ?? '').toLowerCase();
              final destinationNetwork =
                  stripeOnrampSupportedNetworkByCurrencyMap
                      .tryGet(destinationCurrency) as String?;
              if (destinationNetwork == null) {
                return SnackBarUtils.showErrorSnackbar(
                  t.payment.stripeOnramp.networkNotSupported,
                );
              }

              final value = await showFutureLoadingDialog(
                context: context,
                future: () =>
                    getIt<CryptoRampRepository>().createStripeOnrampSession(
                  input: CreateStripeOnrampSessionInput(
                    destinationNetwork: destinationNetwork,
                    destinationCurrency: destinationCurrency,
                    walletAddress: widget.ownerAddress,
                  ),
                ),
              );

              if (value.result == null || value.result?.isLeft() == true) {
                return;
              }

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StripeOnrampWebview(
                    stripeOnrampSession:
                        value.result!.getOrElse(() => StripeOnrampSession()),
                    onStripeOnrampSessionUpdated: (stripeOnrampSession) {
                      Navigator.of(context).pop();
                      widget.onPressRefresh?.call();
                    },
                  ),
                ),
              );
            },
            label: t.vault.createVault.topup,
            radius: BorderRadius.circular(
              LemonRadius.button,
            ),
          ),
        ],
      ),
    );
  }
}
