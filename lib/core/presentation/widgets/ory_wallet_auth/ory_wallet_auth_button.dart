import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

class OryWalletAuthButton extends StatefulWidget {
  const OryWalletAuthButton({
    super.key,
  });

  @override
  State<OryWalletAuthButton> createState() => _OryWalletAuthButtonState();
}

class _OryWalletAuthButtonState extends State<OryWalletAuthButton> {
  bool _walletButtonTapped = false;

  void _loginWithWallet() async {
    try {
      final walletAddress =
          context.read<WalletBloc>().state.activeSession?.address;
      if (walletAddress == null) {
        throw Exception('Wallet address not found');
      }
      final walletRequest =
          await getIt<WalletRepository>().getUserWalletRequest(
        wallet: walletAddress,
      );
      if (walletRequest.isLeft()) {
        throw Exception('Failed to get wallet request');
      }
      final userWalletRequest = walletRequest.getOrElse(() => null);
      if (userWalletRequest == null) {
        throw Exception('User wallet request not found');
      }
      final signedMessage = Web3Utils.toHex(userWalletRequest.message);
      final signature = await getIt<WalletConnectService>().personalSign(
        message: signedMessage,
        wallet: walletAddress,
      );
      if (signature == null ||
          signature.isEmpty ||
          !signature.startsWith('0x')) {
        throw Exception('Failed to sign message');
      }

      context.read<AuthBloc>().add(
            AuthEvent.loginWithWallet(
              walletAddress: walletAddress,
              signature: signature,
              token: userWalletRequest.token,
            ),
          );
    } catch (e) {
      SnackBarUtils.showError(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state.activeSession != null && _walletButtonTapped) {
          _loginWithWallet();
          _walletButtonTapped = false;
        }
      },
      builder: (context, state) {
        final isConnected = state.activeSession != null;
        if (!isConnected) {
          return ConnectWalletButton(
            builder: (onConnectPressed, connectButtonState) {
              return _Button(
                onTap: () async {
                  _walletButtonTapped = true;
                  onConnectPressed(context);
                },
              );
            },
          );
        }
        return _Button(
          onTap: () async {
            _loginWithWallet();
          },
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Spacing.s3),
        decoration: BoxDecoration(
          color: appColors.buttonTertiaryBg,
          borderRadius: BorderRadius.circular(LemonRadius.full),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              return ThemeSvgIcon(
                color: appColors.buttonTertiary,
                builder: (filter) =>
                    Assets.icons.icAccountBalanceWalletOutlineSharp.svg(
                  width: 24,
                  height: 24,
                  colorFilter: filter,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
