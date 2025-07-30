import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/service/ory_auth/ory_auth.dart';
import 'package:app/core/utils/email_validator.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/service/ory_auth/ory_verify_email_extension.dart';

@RoutePage()
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final oryAuth = getIt<OryAuth>();
  final emailController = TextEditingController();

  bool isEmailValid = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _verifyEmail() async {
    final email = emailController.text;
    setState(() {
      isLoading = true;
    });
    final (flowId, errorMessage) = await oryAuth.verifyEmail(
      email,
    );

    if (flowId != null) {
      setState(() {
        isLoading = false;
      });
      context.router.push(
        VerifyEmailOtpRoute(
          email: email,
          flowId: flowId,
        ),
      );
      return;
    }

    setState(() {
      isLoading = false;
    });
    if (errorMessage != null) {
      SnackBarUtils.showError(message: errorMessage);
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
              "Verify Email",
              style: appText.xxl,
            ),
            Text(
              "If you have attended Lemonade events in the past, enter the same email you used to register.",
              style: appText.sm.copyWith(
                color: appColors.textSecondary,
              ),
            ),
            SizedBox(height: Spacing.s5),
            LemonTextField(
              autofocus: true,
              hintText: 'Email Address',
              textInputType: TextInputType.emailAddress,
              focusedBorderColor: appColors.textPrimary,
              controller: emailController,
              onChange: (value) {
                setState(() {
                  isEmailValid = EmailValidator.validate(value);
                });
              },
            ),
            const Spacer(),
            SafeArea(
              child: Opacity(
                opacity: isEmailValid ? 1 : 0.5,
                child: LinearGradientButton.primaryButton(
                  radius: BorderRadius.circular(LemonRadius.full),
                  loadingWhen: isLoading,
                  label: 'Continue',
                  onTap: () {
                    if (isEmailValid) {
                      _verifyEmail();
                    }
                  },
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
