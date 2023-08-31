import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/presentation/pages/onboarding/widgets/gender_chip_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/common/button/linear_gradient_button_widget.dart';

@RoutePage()
class OnboardingAboutPage extends StatelessWidget {
  const OnboardingAboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final bloc = context.read<OnboardingBloc>();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.read<AuthBloc>().add(const AuthEvent.authenticated());
          context.router.replaceAll([const RootRoute()]);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const LemonBackButton(),
            actions: [
              Row(
                children: [
                  InkWell(
                    onTap: () => context.router
                        .push(const RootRoute(children: [HomeRoute()])),
                    child: Text(
                      t.onboarding.skip,
                      style: Typo.medium.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(width: Spacing.smMedium),
                ],
              ),
            ],
          ),
          backgroundColor: theme.colorScheme.primary,
          body: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return Padding(
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
                            t.onboarding.aboutYou,
                            style: Typo.extraLarge.copyWith(
                              fontWeight: FontWeight.w800,
                              color: LemonColor.onboardingTitle,
                              fontFamily: FontFamily.nohemiVariable,
                            ),
                          ),
                          SizedBox(height: Spacing.extraSmall),
                          Text(
                            t.onboarding.aboutYouDesc,
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: Spacing.medium),
                          // Gender picker
                          Row(
                            children: [
                              GenderChipWidget(
                                label: t.onboarding.she,
                                leading: Assets.icons.icGenderFemale,
                                activeColor: LemonColor.femaleActiveColor,
                                inActiveColor: LemonColor.femaleDefault,
                                defaultColor: LemonColor.femaleDefault,
                                onSelect: () =>
                                    bloc.onGenderSelect(OnboardingGender.she),
                                isSelected: state.gender == null
                                    ? null
                                    : state.gender == OnboardingGender.she,
                              ),
                              SizedBox(width: Spacing.superExtraSmall),
                              GenderChipWidget(
                                label: t.onboarding.he,
                                leading: Assets.icons.icGenderFemale,
                                activeColor: LemonColor.maleActiveColor,
                                inActiveColor: LemonColor.maleDefault,
                                defaultColor: LemonColor.maleDefault,
                                onSelect: () =>
                                    bloc.onGenderSelect(OnboardingGender.he),
                                isSelected: state.gender == null
                                    ? null
                                    : state.gender == OnboardingGender.he,
                              ),
                              SizedBox(width: Spacing.superExtraSmall),
                              GenderChipWidget(
                                label: t.onboarding.they,
                                leading: Assets.icons.icGenderAmbiguous,
                                activeColor: LemonColor.ambiguousActiveColor,
                                inActiveColor: LemonColor.ambiguousDefault,
                                defaultColor: LemonColor.ambiguousDefault,
                                onSelect: () =>
                                    bloc.onGenderSelect(OnboardingGender.they),
                                isSelected: state.gender == null
                                    ? null
                                    : state.gender == OnboardingGender.they,
                              ),
                            ],
                          ),
                          SizedBox(height: Spacing.medium),
                          LemonTextField(
                            onChange: bloc.onDisplayNameChange,
                            hintText: t.onboarding.displayName,
                          ),
                          SizedBox(height: Spacing.xSmall),
                          LemonTextField(
                            onChange: bloc.onShortBioChange,
                            hintText: t.onboarding.shortBio,
                            minLines: 3,
                          ),
                        ],
                      ),
                    ),
                    LinearGradientButton(
                      onTap: state.gender == null ? null : bloc.updateProfile,
                      label: t.onboarding.next,
                      textStyle: Typo.medium.copyWith(
                        fontFamily: FontFamily.nohemiVariable,
                        fontWeight: FontWeight.w600,
                      ),
                      radius: BorderRadius.circular(LemonRadius.large),
                      mode: GradientButtonMode.lavenderMode,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
