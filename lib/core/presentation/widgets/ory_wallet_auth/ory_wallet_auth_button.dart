import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/ory_with_wallet_auth/ory_with_wallet_auth.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OryWalletAuthButton extends StatefulWidget {
  const OryWalletAuthButton({super.key});

  @override
  State<OryWalletAuthButton> createState() => _OryWalletAuthButtonState();
}

class _OryWalletAuthButtonState extends State<OryWalletAuthButton> {
  final OryWithWalletAuthService _oryWithWalletAuthService =
      OryWithWalletAuthService();

  void _signUpWithWallet({
    required String walletAddress,
    required String signature,
    required String token,
  }) async {
    try {
      final result = await _oryWithWalletAuthService.signup(
        walletAddress: walletAddress,
        signature: signature,
        token: token,
      );
      result.session?.tokenized;
      // print(result.sessionToken);
    } catch (e) {
      SnackBarUtils.showError(message: e.toString());
    }
  }

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

      final result = await _oryWithWalletAuthService.login(
        walletAddress: walletAddress,
        signature: signature,
        token: userWalletRequest.token,
      );
      if (!result.$1) {
        final loginFlow = result.$2.fold(
          (l) => l,
          (r) => null,
        );
        final accountNotExists =
            loginFlow?.ui.messages?.any((m) => m.id == 4000006);
        if (accountNotExists == true) {
          // try sign up
          _signUpWithWallet(
            walletAddress: walletAddress,
            signature: signature,
            token: userWalletRequest.token,
          );
          return;
        }
      } else {
        final loginFlow = result.$2.fold((l) => null, (r) => r);
        if (loginFlow != null) {
          // print(loginFlow.session.tokenized);
        }
      }
      // login success
    } catch (e) {
      SnackBarUtils.showError(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state.activeSession != null) {
          _loginWithWallet();
        }
      },
      builder: (context, state) {
        final isConnected = state.activeSession != null;
        if (!isConnected) {
          return const ConnectWalletButton();
        }
        return LinearGradientButton.primaryButton(
          label: "Login with Wallet",
          onTap: () async {
            _loginWithWallet();
          },
        );
      },
    );
  }
}
