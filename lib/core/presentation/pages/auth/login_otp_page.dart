import 'dart:async';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/ory_auth/ory_auth.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginOtpPage extends StatefulWidget {
  final String email;
  final String flowId;
  final bool isSignup;
  const LoginOtpPage({
    super.key,
    required this.email,
    required this.flowId,
    required this.isSignup,
  });

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  final oryAuth = getIt<OryAuth>();
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  String? errorText;
  Timer? resendCodeTimer;
  bool canResendCode = true;
  int resendCodeTimerCount = 60;
  bool isResendingCode = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    setState(() {
      isLoading = true;
    });
    String? message;
    if (widget.isSignup) {
      final (signupResult, errorMessage) = await oryAuth.signupWithCode(
        email: widget.email,
        flowId: widget.flowId,
        code: otpController.text.trim(),
      );
      message = errorMessage;
    } else {
      final (loginResult, errorMessage) = await oryAuth.loginWithCode(
        email: widget.email,
        flowId: widget.flowId,
        code: otpController.text.trim(),
      );
      message = errorMessage;
    }

    setState(() {
      isLoading = false;
      errorText = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Scaffold(
      appBar: const LemonAppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: appColors.pageOverlaySecondary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Code",
              style: appText.xxl,
            ),
            SizedBox(height: Spacing.s1_5),
            Text(
              "Please enter 6 digit code we sent to",
              style: appText.sm.copyWith(
                color: appColors.textSecondary,
              ),
            ),
            Text(
              widget.email,
              style: appText.sm,
            ),
            SizedBox(height: Spacing.s5),
            Pinput(
              autofocus: true,
              length: 6,
              controller: otpController,
              onCompleted: (pin) => _verifyOtp(),
              defaultPinTheme: PinTheme(
                width: 50.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: appColors.pageBg,
                  border: Border.all(
                    color: appColors.inputBorder,
                  ),
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 50.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: appColors.pageBg,
                  border: Border.all(
                    color: appColors.textPrimary,
                  ),
                  // color: appColors.inputBg,
                  borderRadius: BorderRadius.circular(LemonRadius.md),
                ),
              ),
            ),
            SizedBox(height: Spacing.s5),
            if (!canResendCode)
              Text(
                'Code sent! Resend in ${resendCodeTimerCount}s',
                style: appText.sm.copyWith(
                  color: appColors.textPrimary,
                ),
              )
            else
              InkWell(
                onTap: () {
                  if (isResendingCode) return;
                  oryAuth.resendCode(
                    email: widget.email,
                    flowId: widget.flowId,
                    isSignup: widget.isSignup,
                    onCodeSentSuccess: () {
                      setState(() {
                        isResendingCode = false;
                        resendCodeTimerCount = 60;
                        canResendCode = false;
                      });
                      resendCodeTimer =
                          Timer.periodic(const Duration(seconds: 1), (timer) {
                        if (resendCodeTimerCount == 0) {
                          setState(() {
                            canResendCode = true;
                            resendCodeTimerCount = 60;
                          });
                        } else {
                          setState(() {
                            resendCodeTimerCount--;
                          });
                        }
                      });
                    },
                  );
                  setState(() {
                    isResendingCode = true;
                  });
                },
                child: isResendingCode
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Loading.defaultLoading(context),
                        ],
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Didn\'t receive code? ',
                              style: appText.sm.copyWith(
                                color: appColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: 'Resend',
                              style: appText.sm.copyWith(
                                color: appColors.textAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            if (errorText != null) ...[
              SizedBox(height: Spacing.s5),
              Text(
                errorText ?? "",
                style: appText.sm.copyWith(
                  color: appColors.textError,
                ),
              ),
            ],
            const Spacer(),
            SafeArea(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) => LinearGradientButton.primaryButton(
                  radius: BorderRadius.circular(LemonRadius.full),
                  loadingWhen: isLoading ||
                      state.maybeWhen(
                        orElse: () => false,
                        processing: () => true,
                      ),
                  label: 'Next',
                  onTap: _verifyOtp,
                ),
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom > 0)
              SizedBox(height: Spacing.s2),
          ],
        ),
      ),
    );
  }
}
