import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/ory_wallet_auth/ory_wallet_auth_button.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/ory_auth/ory_auth.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final oryAuth = getIt<OryAuth>();
  final emailController = TextEditingController();
  final focusNode = FocusNode();

  bool hasFocus = false;
  bool isEmailValid = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
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

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Scaffold(
      appBar: const LemonAppBar(),
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
              autofocus: true,
              focusNode: focusNode,
              hintText: 'Email Address',
              borderColor: hasFocus ? appColors.textPrimary : null,
              controller: emailController,
              onChange: (value) {
                setState(() {
                  isEmailValid = EmailValidator.validate(value);
                });
              },
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
                            SnackBarUtils.showComingSoon();
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
                            SnackBarUtils.showComingSoon();
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
                      const Expanded(
                        child: OryWalletAuthButton(),
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
