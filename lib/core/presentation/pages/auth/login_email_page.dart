import 'dart:async';

import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/ory_wallet_auth/ory_wallet_auth_button.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/ory_auth/ory_auth.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:app/core/utils/platform_infos.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  final oryAuth = getIt<OryAuth>();
  final emailController = TextEditingController();
  bool isEmailValid = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _signupWithEmail() async {
    final email = emailController.text;
    setState(() {
      isLoading = true;
    });
    await oryAuth.trySignupWithCode(
      email: email,
      onSuccess: (signup) {},
      onCodeSent: (signupFlow) {
        setState(() {
          isLoading = false;
        });
        context.router.push(
          LoginOtpRoute(
            email: email,
            flowId: signupFlow.id,
            isSignup: true,
          ),
        );
      },
    );
  }

  Future<void> _loginWithEmail() async {
    final email = emailController.text;
    setState(() {
      isLoading = true;
    });
    await oryAuth.tryLoginWithCode(
      email: email,
      onSuccess: (login) {},
      onAccountNotExists: () {
        _signupWithEmail();
      },
      onCodeSent: (loginFlow) {
        setState(() {
          isLoading = false;
        });
        context.router.push(
          LoginOtpRoute(
            email: email,
            flowId: loginFlow.id,
            isSignup: false,
          ),
        );
      },
    );
  }

  Future<void> _loginWithGoogle() async {
    try {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      final nonce = const Uuid().v4();
      await googleSignIn.initialize(
        nonce: nonce,
      );
      final credential = await googleSignIn.authenticate();
      final idToken = credential.authentication.idToken;
      if (idToken == null) {
        SnackBarUtils.showError(message: 'Failed to sign in with Google');
        return;
      }
      final (success, errorMessage) = await oryAuth.loginWithOidc(
        provider: 'google',
        idToken: idToken,
        idTokenNonce: nonce,
        onAccountNotExists: () {
          _signupWithGoogle(idToken, nonce);
        },
      );
      if (errorMessage != null) {
        SnackBarUtils.showError(message: errorMessage);
      }
    } catch (e) {
      if (e is GoogleSignInException) {
        SnackBarUtils.showError(message: e.description);
        return;
      }
      SnackBarUtils.showError(message: e.toString());
    } finally {
      await GoogleSignIn.instance.signOut();
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _signupWithGoogle(String idToken, String idTokenNonce) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      final (success, errorMessage) = await oryAuth.signupWithOidc(
        provider: 'google',
        idToken: idToken,
        idTokenNonce: idTokenNonce,
      );
      if (errorMessage != null) {
        SnackBarUtils.showError(message: errorMessage);
      }
    } catch (e) {
      SnackBarUtils.showError(message: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _signupWithApple(String idToken, String idTokenNonce) async {
    try {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      final (success, errorMessage) = await oryAuth.signupWithOidc(
        provider: 'apple',
        idToken: idToken,
        idTokenNonce: idTokenNonce,
      );
      if (errorMessage != null) {
        SnackBarUtils.showError(message: errorMessage);
      }
    } catch (e) {
      SnackBarUtils.showError(message: 'Failed to sign up with Apple');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loginWithApple() async {
    try {
      if (PlatformInfos.isAndroid) {
        SnackBarUtils.showComingSoon();
        return;
      }
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      final nonce = const Uuid().v4();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final idToken = credential.identityToken;
      if (idToken == null) {
        SnackBarUtils.showError(message: 'Failed to sign in with Apple');
        return;
      }
      final (success, errorMessage) = await oryAuth.loginWithOidc(
        provider: 'apple',
        idToken: idToken,
        idTokenNonce: nonce,
        onAccountNotExists: () {
          _signupWithApple(idToken, nonce);
        },
      );
      if (errorMessage != null) {
        SnackBarUtils.showError(message: errorMessage);
      }
    } catch (e) {
      SnackBarUtils.showError(message: 'Failed to sign in with Apple');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loginWithWallet() async {
    try {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
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

      final result = await oryAuth.loginWithWallet(
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
          _signupWithWallet(walletAddress, signature, userWalletRequest.token);
          return;
        }
      }
    } catch (e) {
      SnackBarUtils.showError(message: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _signupWithWallet(
    String walletAddress,
    String signature,
    String token,
  ) async {
    FocusScope.of(context).unfocus();
    try {
      setState(() {
        isLoading = false;
      });
      await oryAuth.signupWithWallet(
        walletAddress: walletAddress,
        signature: signature,
        token: token,
      );
    } catch (e) {
      SnackBarUtils.showError(message: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Scaffold(
      backgroundColor: appColors.pageOverlaySecondary,
      appBar: const LemonAppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to\nLemonade",
              style: appText.xxl,
            ),
            Text(
              "Please sign in or sign up below.",
              style: appText.sm.copyWith(
                color: appColors.textSecondary,
              ),
            ),
            SizedBox(height: Spacing.s5),
            LemonTextField(
              textInputType: TextInputType.emailAddress,
              autofocus: true,
              hintText: 'Email Address',
              focusedBorderColor: appColors.textPrimary,
              controller: emailController,
              onChange: (value) {
                setState(() {
                  isEmailValid = EmailValidator.validate(value);
                });
              },
              fillColor: appColors.pageBg,
              filled: true,
              borderColor: appColors.inputBorder,
            ),
            const Spacer(),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: _Button(
                          onTap: () {
                            _loginWithGoogle();
                          },
                          icon: ThemeSvgIcon(
                            color: appColors.buttonTertiary,
                            builder: (filter) => Assets.icons.icGoogle.svg(
                              colorFilter: filter,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Spacing.s2),
                      Expanded(
                        child: _Button(
                          onTap: () {
                            _loginWithApple();
                          },
                          icon: ThemeSvgIcon(
                            color: appColors.buttonTertiary,
                            builder: (filter) => Assets.icons.icApple.svg(
                              colorFilter: filter,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Spacing.s2),
                      Expanded(
                        child: OryWalletAuthButton(
                          onStartLogin: () {
                            _loginWithWallet();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.s2),
                  Opacity(
                    opacity: isEmailValid ? 1 : 0.5,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isAuthProcessing = state.maybeWhen(
                          processing: () => true,
                          orElse: () => false,
                        );
                        return LinearGradientButton.primaryButton(
                          radius: BorderRadius.circular(LemonRadius.full),
                          loadingWhen: isLoading || isAuthProcessing,
                          label: 'Continue with Email',
                          onTap: () {
                            if (isAuthProcessing) return;
                            if (isEmailValid) {
                              _loginWithEmail();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  if (MediaQuery.of(context).viewInsets.bottom > 0)
                    SizedBox(height: Spacing.s2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onTap,
    required this.icon,
  });
  final VoidCallback onTap;
  final Widget icon;

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
          child: icon,
        ),
      ),
    );
  }
}
