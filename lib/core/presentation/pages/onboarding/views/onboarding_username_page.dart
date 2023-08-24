import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../i18n/i18n.g.dart';
import '../../../../../theme/color.dart';
import '../../../widgets/back_button_widget.dart';

@RoutePage()
class OnboardingUsernamePage extends StatefulWidget {
  const OnboardingUsernamePage({Key? key}) : super(key: key);

  @override
  State<OnboardingUsernamePage> createState() => _OnboardingUsernamePageState();
}

class _OnboardingUsernamePageState extends State<OnboardingUsernamePage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final bloc = context.read<OnboardingBloc>();
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const LemonBackButton(),
          ),
          backgroundColor: theme.colorScheme.primary,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.onboarding.pickUsername,
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w800,
                          color: LemonColor.onboardingTitle,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                      ),
                      SizedBox(height: Spacing.extraSmall),
                      Text(
                        t.onboarding.pickUsernameDesc,
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: Spacing.medium),
                      LemonTextField(
                        onChange: bloc.onUsernameChange,
                        hintText: t.onboarding.username,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1.sw,
                  child: ElevatedButton(
                    onPressed: bloc.state.username?.isEmpty ?? true
                        ? null
                        : () => context.router.push(
                              const OnboardingProfilePhotoRoute(),
                            ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 18.w,
                      ),
                      backgroundColor: theme.colorScheme.onTertiary,
                      disabledBackgroundColor: theme.colorScheme.onSecondaryContainer,
                    ),
                    child: Text(
                      t.onboarding.claim,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontFamily.nohemiVariable,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
