import 'package:app/core/application/payment/create_payment_account_bloc/create_payment_account_bloc.dart';
import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/vault/vault_pin_storage/vault_pin_storage.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateVaultSubmitTransactionPage extends StatelessWidget {
  const CreateVaultSubmitTransactionPage({super.key});

  submitTransaction() {
    // TODO:
    // final data = state.data;
    // context.read<CreatePaymentAccountBloc>().add(
    //       CreatePaymentAccountEvent.create(
    //         input: CreatePaymentAccountInput(
    //           title: data.vaultName,
    //           type: PaymentAccountType.ethereum,
    //           provider: PaymentProvider.safe,
    //           accountInfo: AccountInfoInput(
    //             owners: data.owners,
    //             threshold: data.threshold,
    //             network: data.selectedChain?.chainId,
    //             currencies: (data.selectedChain?.tokens ?? [])
    //                 .map(
    //                   (token) => token.symbol ?? '',
    //                 )
    //                 .toList(),
    //           ),
    //         ),
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreatePaymentAccountConsumer(),
    );
  }
}

class CreatePaymentAccountConsumer extends StatelessWidget {
  const CreatePaymentAccountConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePaymentAccountBloc, CreatePaymentAccountState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: (vault) async {
            // when create wallet success
            // Check if already set passcode ?
            // if yes => Go to success page
            final userId = AuthUtils.getUserId(context);
            if (await VaultPinStorage.hasPinCode(userId)) {
              return AutoRouter.of(context).replaceAll(
                [
                  CreateVaultSuccessRoute(
                    vaultName: vault.title,
                    vaultType: VaultType.individual,
                    onPressed: (innerContext) {
                      innerContext.read<GetPaymentAccountsBloc>().add(
                            GetPaymentAccountsEvent.fetch(
                              input: GetPaymentAccountsInput(
                                type: PaymentAccountType.ethereum,
                                provider: PaymentProvider.safe,
                              ),
                            ),
                          );
                      AutoRouter.of(innerContext).pop();
                    },
                  ),
                ],
              );
            } else {
              // if no => Go to setup passcode page
              AutoRouter.of(context).replaceAll([
                CreateVaultSetupPinRoute(
                  vault: vault,
                ),
              ]);
            }
          },
        );
      },
      builder: (context, state) => state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        loading: () => Align(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Loading.defaultLoading(context),
          ),
        ),
      ),
    );
  }
}
