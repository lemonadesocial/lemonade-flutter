import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/sign_wallet_bloc/sign_wallet_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/pages/token_gating/widget/token_gating_wallet_address_box.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenGatingWalletVerificationPage extends StatelessWidget {
  const TokenGatingWalletVerificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignWalletBloc(),
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
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final currentUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final userVerifiedWalletAddresses = currentUser?.walletsNew?.values
            .expand(
              (e) => e ?? <String>[],
            )
            .toList() ??
        [];
    // final clientConnectedAddress =
    //     context.watch<WalletBloc>().state.activeSession?.address;

    // TODO: FIX WALLET MIGRATION
    final clientConnectedAddress = '';
    final isConnected = clientConnectedAddress != null;
    final isVerified = (isConnected &&
        userVerifiedWalletAddresses.contains(clientConnectedAddress));

    return Container(
      color: LemonColor.atomicBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.center,
            child: BottomSheetGrabber(),
          ),
          LemonAppBar(
            title: t.tokenGating.verifyWallet,
            backgroundColor: LemonColor.atomicBlack,
            padding: EdgeInsets.zero,
          ),
          SizedBox(height: Spacing.xSmall),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<SignWalletBloc, SignWalletState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () => null,
                      success: () async {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEvent.refreshData());
                        Navigator.pop(context, true);
                      },
                    );
                  },
                  builder: (context, state) {
                    if (!isConnected) {
                      return const SafeArea(
                        top: false,
                        child: ConnectWalletButton(),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TokenGatingWalletAddressBox(
                          address: clientConnectedAddress,
                          onTapEdit: () {
                            context
                                .read<WalletBloc>()
                                .add(const WalletEvent.disconnect());
                          },
                        ),
                        SizedBox(height: Spacing.small),
                        Text(
                          isVerified
                              ? t.tokenGating.verifiedWalletDescription
                              : t.tokenGating.verifyWalletDescription,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        if (!isVerified) ...[
                          SizedBox(height: Spacing.small),
                          Text(
                            t.tokenGating.verifyWalletMessage,
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                        SizedBox(height: Spacing.medium),
                        SafeArea(
                          top: false,
                          child: LinearGradientButton.primaryButton(
                            label: isVerified
                                ? t.common.next
                                : t.tokenGating.signMessage,
                            onTap: () {
                              if (isVerified) {
                                Navigator.pop(context, true);
                                return;
                              }
                              context.read<SignWalletBloc>().add(
                                    SignWalletEvent.sign(
                                      wallet: clientConnectedAddress,
                                    ),
                                  );
                            },
                            loadingWhen: state.maybeWhen(
                              orElse: () => null,
                              loading: () => true,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
