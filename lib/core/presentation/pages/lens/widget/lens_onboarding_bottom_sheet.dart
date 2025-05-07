import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/lens/login_lens_account_bloc/login_lens_account_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      ],
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  Future<void> _onChangeWalletAddress(BuildContext context) async {
    Navigator.pop(context);
    await getIt<WalletConnectService>().w3mService?.disconnect();
    context.read<WalletBloc>().add(const WalletEvent.disconnect());
    await Future.delayed(const Duration(milliseconds: 500));
    getIt<WalletConnectService>().w3mService?.openModalView();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetGrabber(),
          ),
          MultiBlocListener(
            listeners: [
              BlocListener<LoginLensAccountBloc, LoginLensAccountState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success:
                        (token, refreshToken, idToken, accountStatus) async {
                      context.read<LensAuthBloc>().add(
                            LensAuthEvent.authorized(
                              token: token,
                              refreshToken: refreshToken,
                              idToken: idToken,
                            ),
                          );
                      if (accountStatus == LensAccountStatus.accountOwner) {
                        Navigator.of(context).pop(true);
                      }
                      if (accountStatus == LensAccountStatus.onboarding) {
                        final success = await AutoRouter.of(context).push(
                          const CreateLensAccountRoute(),
                        );
                        if (success == true) {
                          Navigator.of(context).pop(true);
                        }
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
            ],
            child: BlocConsumer<LensAuthBloc, LensAuthState>(
              listener: (context, state) async {},
              builder: (context, lensAuthState) {
                final isWalletConnected =
                    context.watch<WalletBloc>().state.activeSession != null;

                if (!isWalletConnected) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Sizing.large,
                          height: Sizing.large,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(Sizing.large),
                            border: Border.all(
                              color: colorScheme.outlineVariant,
                              width: 1.w,
                            ),
                          ),
                          child: Center(
                            child: ThemeSvgIcon(
                              color: colorScheme.onPrimary,
                              builder: (filter) => Assets.icons.icWallet.svg(
                                width: 18.w,
                                height: 18.w,
                                colorFilter: filter,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Spacing.medium),
                        Text(
                          t.common.actions.connectWallet,
                          style: Typo.extraLarge.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          t.lens.connectWalletDescription,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        SizedBox(height: Spacing.medium),
                        const ConnectWalletButton(),
                      ],
                    ),
                  );
                }

                return Builder(
                  builder: (context) {
                    final ownerAddress =
                        context.read<WalletBloc>().state.activeSession?.address;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LemonAppBar(
                            title: t.common.actions.verifyWallet,
                            backgroundColor: LemonColor.atomicBlack,
                          ),
                          SizedBox(height: Spacing.small),
                          if (lensAuthState.isFetching) ...[
                            Loading.defaultLoading(context),
                          ] else ...[
                            _AddressBox(
                              address: ownerAddress ?? "",
                              onTapEdit: () => _onChangeWalletAddress(context),
                            ),
                            SizedBox(height: Spacing.small),
                            Text(
                              t.lens.signMessageDescription,
                              style: Typo.medium.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: Spacing.small),
                            SizedBox(height: Spacing.small),
                            BlocBuilder<LoginLensAccountBloc,
                                LoginLensAccountState>(
                              builder: (context, state) {
                                final isLoginProcessing = state.maybeWhen(
                                  loading: () => true,
                                  orElse: () => false,
                                );
                                return LinearGradientButton.primaryButton(
                                  label: t.common.actions.sign,
                                  loadingWhen: isLoginProcessing,
                                  onTap: () async {
                                    if (isLoginProcessing) {
                                      return;
                                    }
                                    final ownerAddress =
                                        (await getIt<WalletConnectService>()
                                                .getActiveSession())
                                            ?.address;
                                    if (ownerAddress == null) {
                                      return null;
                                    }

                                    final availableAccounts =
                                        lensAuthState.availableAccounts;
                                    final accountAddress = availableAccounts
                                            .isEmpty
                                        ? null
                                        : availableAccounts
                                            .firstWhereOrNull(
                                              (account) =>
                                                  account.owner
                                                      ?.toLowerCase() ==
                                                  ownerAddress.toLowerCase(),
                                            )
                                            ?.address;

                                    context.read<LoginLensAccountBloc>().add(
                                          LoginLensAccountEvent.login(
                                            ownerAddress: ownerAddress,
                                            accountAddress:
                                                accountAddress ?? ownerAddress,
                                            accountStatus: accountAddress ==
                                                    null
                                                ? LensAccountStatus.onboarding
                                                : LensAccountStatus
                                                    .accountOwner,
                                          ),
                                        );
                                  },
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressBox extends StatelessWidget {
  const _AddressBox({
    required this.address,
    this.onTapEdit,
  });

  final String address;
  final Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ThemeSvgIcon(
            builder: (filter) => Assets.icons.icWallet.svg(
              colorFilter: filter,
            ),
            color: colorScheme.onSecondary,
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Text(
              Web3Utils.formatIdentifier(address),
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
          ),
          if (onTapEdit != null)
            InkWell(
              onTap: onTapEdit,
              child: ThemeSvgIcon(
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                ),
                color: colorScheme.onSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
