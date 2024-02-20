import 'dart:math';

import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/chain_metadata.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_button_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/presentation/widgets/web3/wallet_connect_active_session.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class SendTokenPoc extends StatefulWidget {
  const SendTokenPoc({super.key});

  @override
  State<SendTokenPoc> createState() => _SendTokenViewState();
}

class _SendTokenViewState extends State<SendTokenPoc> {
  String? recipient;
  String? amount;
  bool isLoading = false;
  String? txHash;
  ChainMetadata? chainMetadata;
  String? signature;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state.activeSession == null) {
          return const ConnectWalletButton();
        }

        final userWalletAddress = NamespaceUtils.getAccount(
          state.activeSession!.namespaces.entries.first.value.accounts.first,
        );
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              WalletConnectActiveSessionWidget(
                activeSession: state.activeSession!,
                onPressDisconnect: () => context
                    .read<WalletBloc>()
                    .add(const WalletEvent.disconnect()),
              ),
              SizedBox(height: Spacing.xSmall),
              LinearGradientButton(
                label: "switch network",
                onTap: () async {
                  await getIt<WalletConnectService>()
                      .switchChain(
                    chain: Chain(),
                  )
                      .catchError((error) {
                    return null;
                  });
                },
              ),
              SizedBox(height: Spacing.xSmall),
              LinearGradientButton(
                label: "Sign the payment",
                onTap: () async {
                  try {
                    final currentWalletAppAccount =
                        getIt<WalletConnectService>().currentWalletAppAccount;
                    if (currentWalletAppAccount != null &&
                        userWalletAddress != currentWalletAppAccount) {
                      SnackBarUtils.showSnackbar(
                        'Please switch to your connected account',
                      );
                      return;
                    }
                    final mSignature =
                        await getIt<WalletConnectService>().personalSign(
                      message: Web3Utils.toHex('Your payment ID: 123'),
                      wallet: userWalletAddress,
                    );
                    setState(() {
                      signature = mSignature;
                    });
                  } catch (e) {
                    if (e is JsonRpcError) {
                      SnackBarUtils.showErrorSnackbar(e.message ?? '');
                    }
                  }
                },
              ),
              SizedBox(height: Spacing.medium),
              const Text("the mock message is 'Your payment ID: 123'"),
              SizedBox(height: Spacing.medium),
              if (signature != null) Text('Your signature: $signature'),
              SizedBox(height: Spacing.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Chains.testnet.map((chain) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: LemonButton(
                      label: chain.name,
                      onTap: () {
                        setState(() {
                          chainMetadata = chain;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: Sizing.medium,
              ),
              if (chainMetadata != null)
                Text('selected chain: ${chainMetadata?.name}'),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Recipient",
                ),
                onChanged: (v) {
                  recipient = v;
                },
              ),
              SizedBox(
                height: Sizing.medium,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Amount",
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (v) {
                  amount = v;
                },
              ),
              SizedBox(
                height: Sizing.medium,
              ),
              InkWell(
                onTap: () {
                  if (txHash == null) return;
                  launchUrl(
                    Uri.parse(
                      chainMetadata!.blockExplorerForTransaction(txHash!),
                    ),
                  );
                },
                child: Text(
                  'Your txhash: ${txHash ?? ''}',
                ),
              ),
              SizedBox(
                height: Sizing.medium,
              ),
              LinearGradientButton(
                label: "Send",
                loadingWhen: isLoading,
                onTap: () async {
                  if (chainMetadata == null) return;
                  if (recipient == null) return;
                  if (amount == null) return;
                  final sendAmount = double.parse(amount!);
                  try {
                    final txId =
                        await getIt<WalletConnectService>().requestTransaction(
                      chainId: chainMetadata!.chainId,
                      transaction: EthereumTransaction(
                        from: userWalletAddress,
                        to: recipient!,
                        value: BigInt.from(
                          sendAmount *
                              pow(10, chainMetadata!.nativeCurrency.decimals),
                        ).toRadixString(16),
                      ),
                    );
                    setState(() {
                      txHash = txId;
                    });
                  } catch (e) {
                    if (e is JsonRpcError) {
                      SnackBarUtils.showErrorSnackbar(e.message ?? '');
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
