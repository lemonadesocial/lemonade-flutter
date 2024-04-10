import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/service/crash_analytics/sentry_crash_analytics_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomError extends StatefulWidget {
  const CustomError({
    super.key,
  });

  @override
  CustomErrorState createState() => CustomErrorState();
}

class CustomErrorState extends State<CustomError> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentUser = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    if (currentUser != null) {
      nameController.text = currentUser.username ?? '';
      emailController.text = currentUser.email ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onSubmitFeedback() async {
    (CrashAnalyticsManager().crashAnalyticsService
            as SentryCrashAnalyticsService)
        .sendFeedback(
      name: nameController.text,
      email: emailController.text,
      comments: commentController.text,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t.common.feedback.feedbackSubmitted),
          content: Text(t.common.feedback.thankForFeedback),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                nameController.text = '';
                emailController.text = '';
                commentController.text = '';
                Navigator.of(context).pop();
              },
              child: Text(t.common.actions.ok),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isValid = commentController.text.isNotEmpty;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Assets.images.icComingSoon.provider(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(height: 25.h),
                      Text(
                        t.common.oops,
                        style: Typo.extraLarge.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      Container(height: 10.h),
                      Text(
                        t.common.feedback.feedbackDescription,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: Spacing.medium,
                      ),
                      LemonTextField(
                        key: const ValueKey('sentry_name_textfield'),
                        controller: nameController,
                        hintText: t.common.feedback.name,
                      ),
                      const SizedBox(height: 8),
                      LemonTextField(
                        key: const ValueKey('sentry_email_textfield'),
                        controller: emailController,
                        hintText: t.common.feedback.email,
                      ),
                      const SizedBox(height: 8),
                      LemonTextField(
                        key: const ValueKey('sentry_comment_textfield'),
                        minLines: 5,
                        maxLines: null,
                        hintText: t.common.feedback.whatHappen,
                        controller: commentController,
                      ),
                      Opacity(
                        opacity: isValid ? 1 : 0.5,
                        child: Container(
                          width: 180.w,
                          margin:
                              EdgeInsets.symmetric(vertical: Spacing.medium),
                          child: LinearGradientButton(
                            label: t.common.feedback.submitFeedback,
                            height: 42.h,
                            mode: GradientButtonMode.defaultMode,
                            radius: BorderRadius.circular(24),
                            textStyle: Typo.medium.copyWith(),
                            onTap: () => isValid ? onSubmitFeedback() : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
