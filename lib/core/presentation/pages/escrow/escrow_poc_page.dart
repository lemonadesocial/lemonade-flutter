import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/service/web3/escrow/escrow_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EscroPocPage extends StatelessWidget {
  const EscroPocPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              return LinearGradientButton.primaryButton(
                onTap: () async {
                  await EscrowUtils.getRefundPolices();
                  // final receipt = await EscrowUtils.awaitForReceipt('0xc4193cbe6e4607cae399dff34fd471e13426c4df0a7871b5dd5cf4a1544dbb50');

                  // final escrowFactoryContract = Web3ContractService.getEscrowFactoryContract(
                  //   EscrowUtils.escrowFactoryContractAddress,
                  // );

                  // final result = escrowFactoryContract
                  //     .event('EscrowCreated')
                  //     .decodeResults(receipt?.logs[0].topics ?? [], receipt?.logs[0].data ?? '');

                  // print(result);
                  // EscrowHelper.createEscrowContract(
                  //   userWalletAddress: getIt<WalletConnectService>().w3mService.address ?? '',
                  //   chainId: 'eip155:11155111',
                  // );
                },
                label: 'Create escrow',
              );
            },
          ),
        ],
      ),
    );
  }
}
