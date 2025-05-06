import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/lens/create_lens_account_bloc/create_lens_account_bloc.dart';
import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/lens/login_lens_account_bloc/login_lens_account_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class LensOnboardingBottomSheet extends StatelessWidget {
  const LensOnboardingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginLensAccountBloc(
            lensRepository: getIt<LensRepository>(),
            walletConnectService: getIt<WalletConnectService>(),
          ),
        ),
        BlocProvider(
          create: (context) => CreateLensAccountBloc(
            getIt<LensRepository>(),
            getIt<LensGroveService>(),
          ),
        ),
      ],
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<LoginLensAccountBloc, LoginLensAccountState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (token, refreshToken, idToken, accountStatus) {
                        context.read<LensAuthBloc>().add(
                              LensAuthEvent.authorized(
                                token: token,
                                refreshToken: refreshToken,
                                idToken: idToken,
                              ),
                            );
                        if (accountStatus == LensAccountStatus.accountOwner) {
                          Navigator.of(context).pop(true);
                          SnackBarUtils.showSuccess(
                            message: "Login to lens successfully",
                          );
                        }
                        if (accountStatus == LensAccountStatus.onboarding) {
                          SnackBarUtils.showSuccess(
                            message:
                                "You're logged in as onboarding user. Creating Lens Account for you",
                          );
                        }
                      },
                      failed: (failure) {
                        Navigator.of(context).pop();
                        SnackBarUtils.showError(message: failure.message);
                      },
                      orElse: () {},
                    );
                  },
                ),
                BlocListener<CreateLensAccountBloc, CreateLensAccountState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (token, refreshToken, account, idToken) {
                        Navigator.of(context).pop(true);
                        context.read<LensAuthBloc>().add(
                              LensAuthEvent.accountCreated(
                                token: token,
                                refreshToken: refreshToken,
                                account: account,
                              ),
                            );
                        SnackBarUtils.showSuccess(
                          message: "Lens account successfully created",
                        );
                      },
                      failed: (failure) {
                        Navigator.of(context).pop();
                        SnackBarUtils.showError(message: failure.message);
                      },
                      orElse: () {},
                    );
                  },
                ),
              ],
              child: BlocConsumer<LensAuthBloc, LensAuthState>(
                listener: (context, state) async {},
                builder: (context, lensAuthState) {
                  final isWalletConnected =
                      context.watch<WalletBloc>().state.activeSession != null;

                  if (!isWalletConnected) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Connect Wallet',
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "It looks like your wallet is not connected. Connect your wallet to post on the feed.",
                          ),
                          const SizedBox(height: 16),
                          const ConnectWalletButton(),
                        ],
                      ),
                    );
                  }

                  if (lensAuthState.loggedIn) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (lensAuthState.accountStatus ==
                              LensAccountStatus.accountOwner) ...[
                            Text(
                              'Account Owner',
                              style: Typo.extraLarge.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            const Text(
                              "You're logged in as account owner. Can create post now.",
                            ),
                            const SizedBox(height: 16),
                            Builder(
                              builder: (context) {
                                final accountOwner =
                                    lensAuthState.availableAccounts.firstOrNull;
                                return Text(
                                  [
                                    "Lens Account Address:\n${accountOwner?.address ?? ""}",
                                    "Lens Account Owner (should be your wallet address):\n${accountOwner?.owner ?? ""}",
                                    "Lens Account UserName: ${accountOwner?.username?.value ?? ""}",
                                  ].join(
                                    "\n\n",
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            LinearGradientButton.secondaryButton(
                              label: 'Disconnect',
                              onTap: () {
                                context
                                    .read<WalletBloc>()
                                    .add(const WalletEvent.disconnect());
                              },
                            ),
                          ],
                          if (lensAuthState.accountStatus ==
                              LensAccountStatus.onboarding) ...[
                            Text(
                              'Onboarding',
                              style: Typo.extraLarge.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            const Text(
                              "You're logged in as onboarding user. Let's create Lens Account",
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<CreateLensAccountBloc,
                                CreateLensAccountState>(
                              builder: (context, state) {
                                final isLoading = state.maybeWhen(
                                  loading: () => true,
                                  orElse: () => false,
                                );
                                return LinearGradientButton.primaryButton(
                                  label: 'Create',
                                  loadingWhen: isLoading,
                                  onTap: () {
                                    if (isLoading) {
                                      return;
                                    }
                                    final user =
                                        getIt<AuthBloc>().state.maybeWhen(
                                              authenticated: (user) => user,
                                              orElse: () => null,
                                            );
                                    if (user == null) {
                                      return;
                                    }
                                    context.read<CreateLensAccountBloc>().add(
                                          CreateLensAccountEvent
                                              .requestCreateLensAccount(
                                            lemonadeUser: user,
                                          ),
                                        );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            LinearGradientButton.secondaryButton(
                              label: 'Disconnect',
                              onTap: () {
                                context
                                    .read<WalletBloc>()
                                    .add(const WalletEvent.disconnect());
                              },
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        if (lensAuthState.isFetching) ...[
                          Text(
                            'Connect Wallet',
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text("Checking available accounts..."),
                          const SizedBox(height: 16),
                          Loading.defaultLoading(context),
                        ] else ...[
                          Text(
                            'Connect Wallet',
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          FutureBuilder(
                            future: () async {
                              await Future.delayed(const Duration(seconds: 1));
                              final ownerAddress =
                                  (await getIt<WalletConnectService>()
                                          .getActiveSession())
                                      ?.address;
                              if (ownerAddress == null) {
                                return null;
                              }

                              final availableAccounts =
                                  lensAuthState.availableAccounts;
                              final accountAddress = availableAccounts.isEmpty
                                  ? null
                                  : availableAccounts
                                      .firstWhereOrNull(
                                        (account) =>
                                            account.owner?.toLowerCase() ==
                                            ownerAddress.toLowerCase(),
                                      )
                                      ?.address;

                              context.read<LoginLensAccountBloc>().add(
                                    LoginLensAccountEvent.login(
                                      ownerAddress: ownerAddress,
                                      accountAddress:
                                          accountAddress ?? ownerAddress,
                                      accountStatus: accountAddress == null
                                          ? LensAccountStatus.onboarding
                                          : LensAccountStatus.accountOwner,
                                    ),
                                  );
                            }(),
                            builder: (context, snapshot) =>
                                const Text("Processing...."),
                          ),
                          const SizedBox(height: 16),
                          Loading.defaultLoading(context),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
