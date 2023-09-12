import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';

@RoutePage()
class OnboardingUsernamePage extends StatelessWidget {
  const OnboardingUsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final bloc = context.read<OnboardingBloc>();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.router.push(const OnboardingProfilePhotoRoute());
        }
      },
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
                SizedBox(height: Spacing.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.onboarding.pickUsername,
                        style: Typo.extraLarge.copyWith(
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
                        borderColor: state.usernameExisted ?? false
                            ? LemonColor.errorRedBg
                            : null,
                        statusWidget: state.usernameExisted == null
                            ? null
                            : statusWidget(context, state.usernameExisted!),
                      ),
                    ],
                  ),
                ),
                LinearGradientButton(
                  onTap: (bloc.state.username?.isEmpty ?? true) ||
                          (bloc.state.usernameExisted ?? true)
                      ? null
                      : bloc.updateProfile,
                  label: t.onboarding.claim,
                  textStyle: Typo.medium.copyWith(
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w600,
                  ),
                  radius: BorderRadius.circular(LemonRadius.large),
                  mode: (bloc.state.username?.isEmpty ?? true) ||
                          (bloc.state.usernameExisted ?? true)
                      ? GradientButtonMode.defaultMode
                      : GradientButtonMode.lavenderMode,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget statusWidget(BuildContext context, bool usernameExisted) {
    final color =
        usernameExisted ? LemonColor.errorRedBg : LemonColor.usernameApproved;
    final t = Translations.of(context);
    return Row(
      children: [
        Icon(
          usernameExisted ? Icons.info_outline : Icons.check_circle,
          color: color,
        ),
        SizedBox(width: Spacing.superExtraSmall),
        Text(
          usernameExisted
              ? t.onboarding.usernameTaken
              : t.onboarding.usernameAvailable,
          style: TextStyle(
            color: color,
          ),
        ),
      ],
    );
  }
}
