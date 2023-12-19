import 'package:app/core/application/payment/create_payment_account_bloc/create_payment_account_bloc.dart';
import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/application/vault/create_vault_bloc/create_vault_bloc.dart';
import 'package:app/core/application/vault/deploy_vault_safe_wallet_bloc/deploy_vault_safe_wallet_bloc.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/vault/entities/free_safe_init_info/free_safe_init_info.dart';
import 'package:app/core/domain/vault/input/get_safe_free_limit_input/get_safe_free_limit_input.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/domain/vault/vault_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/vault/create_vault_page/sub_pages/create_vault_submit_transaction_page/view/deploy_paid_vault_view.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/vault/vault_pin_storage/vault_pin_storage.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateVaultSubmitTransactionPage extends StatelessWidget {
  const CreateVaultSubmitTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final createVaultData = context.read<CreateVaultBloc>().state.data;
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<Either<Failure, FreeSafeInitInfo>>(
      future: getIt<VaultRepository>().getSafeFreeLimit(
        input: GetSafeFreeLimitInput(
          network: createVaultData.selectedChain?.chainId ?? '',
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            body: Container(
              child: Loading.defaultLoading(context),
            ),
          );
        }

        if (snapshot.data?.isLeft() == true) {
          return Scaffold(
            body: Center(
              child: EmptyList(emptyText: t.common.somethingWrong),
            ),
          );
        }

        final isFreeDeployment = snapshot.data?.fold(
              (l) => false,
              (freeInfo) => (freeInfo.remaining ?? 0) > 0,
            ) ??
            false;

        if (!isFreeDeployment) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CreatePaymentAccountBloc(),
              ),
              BlocProvider(
                create: (context) => DeployVaultSafeWalletBloc(),
              ),
            ],
            child: const CreateVaultSubmitTransactionPageView(),
          );
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreatePaymentAccountBloc()
                ..add(
                  CreatePaymentAccountEvent.create(
                    input: CreatePaymentAccountInput(
                      title: createVaultData.vaultName,
                      type: PaymentAccountType.ethereum,
                      provider: PaymentProvider.safe,
                      accountInfo: AccountInfoInput(
                        owners: createVaultData.owners,
                        threshold: createVaultData.threshold,
                        network: createVaultData.selectedChain?.chainId,
                        currencies:
                            (createVaultData.selectedChain?.tokens ?? [])
                                .map(
                                  (token) => token.symbol ?? '',
                                )
                                .toList(),
                      ),
                    ),
                  ),
                ),
            ),
            BlocProvider(
              create: (context) => DeployVaultSafeWalletBloc(),
            ),
          ],
          child: const CreateVaultSubmitTransactionPageView(),
        );
      },
    );
  }
}

class CreateVaultSubmitTransactionPageView extends StatelessWidget {
  const CreateVaultSubmitTransactionPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeployVaultSafeWalletBloc, DeployVaultSafeWalletState>(
            listener: (context, deployVaultState) {
              deployVaultState.maybeWhen(
                orElse: () => null,
                success: (safeWalletAddress, owners, threshold, chain) {
                  final createPaymentAccountBloc =
                      context.read<CreatePaymentAccountBloc>();
                  final createVaultBloc = context.read<CreateVaultBloc>();
                  final createVaultData = createVaultBloc.state.data;

                  createPaymentAccountBloc.add(
                    CreatePaymentAccountEvent.create(
                      input: CreatePaymentAccountInput(
                        title: createVaultData.vaultName,
                        type: PaymentAccountType.ethereum,
                        provider: PaymentProvider.safe,
                        accountInfo: AccountInfoInput(
                          address: safeWalletAddress,
                          owners: owners,
                          threshold: threshold,
                          network: chain.chainId,
                          currencies: (chain.tokens ?? [])
                              .map(
                                (token) => token.symbol ?? '',
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          BlocListener<CreatePaymentAccountBloc, CreatePaymentAccountState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
                failure: () async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  AutoRouter.of(context).pop();
                },
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
          ),
        ],
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(Spacing.smMedium),
                child: const DeployPaidVaultView(),
              ),
            ),
            context.watch<CreatePaymentAccountBloc>().state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => _loading(context),
                ),
            context.watch<DeployVaultSafeWalletBloc>().state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => _loading(context),
                ),
          ],
        ),
      ),
    );
  }

  Widget _loading(BuildContext context) {
    return Align(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Loading.defaultLoading(context),
      ),
    );
  }
}
