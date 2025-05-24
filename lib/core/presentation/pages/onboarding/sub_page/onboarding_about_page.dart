import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/presentation/pages/onboarding/widgets/gender_chip_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class OnboardingAboutPage extends StatelessWidget {
  const OnboardingAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final bloc = context.read<OnboardingBloc>();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          context.read<AuthBloc>().add(const AuthEvent.authenticated());
          context.router.replaceAll([const RootRoute()]);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: LemonAppBar(
              actions: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEvent.authenticated());
                        context.router.replaceAll([const RootRoute()]);
                      },
                      child: Text(
                        t.onboarding.skip,
                        style:
                            Typo.medium.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(width: Spacing.smMedium),
                  ],
                ),
              ],
            ),
            backgroundColor: appColors.pageBg,
            body: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              t.onboarding.aboutYou,
                              style: appText.xl,
                            ),
                            SizedBox(height: Spacing.extraSmall),
                            Text(
                              t.onboarding.aboutYouDesc,
                              style: appText.md.copyWith(
                                color: appColors.textTertiary,
                              ),
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
                                      bloc.onGenderSelect(LemonPronoun.she),
                                  isSelected: state.gender == null
                                      ? null
                                      : state.gender == LemonPronoun.she,
                                ),
                                SizedBox(width: Spacing.superExtraSmall),
                                GenderChipWidget(
                                  label: t.onboarding.he,
                                  leading: Assets.icons.icGenderFemale,
                                  activeColor: LemonColor.maleActiveColor,
                                  inActiveColor: LemonColor.maleDefault,
                                  defaultColor: LemonColor.maleDefault,
                                  onSelect: () =>
                                      bloc.onGenderSelect(LemonPronoun.he),
                                  isSelected: state.gender == null
                                      ? null
                                      : state.gender == LemonPronoun.he,
                                ),
                                SizedBox(width: Spacing.superExtraSmall),
                                GenderChipWidget(
                                  label: t.onboarding.they,
                                  leading: Assets.icons.icGenderAmbiguous,
                                  activeColor: LemonColor.ambiguousActiveColor,
                                  inActiveColor: LemonColor.ambiguousDefault,
                                  defaultColor: LemonColor.ambiguousDefault,
                                  onSelect: () =>
                                      bloc.onGenderSelect(LemonPronoun.they),
                                  isSelected: state.gender == null
                                      ? null
                                      : state.gender == LemonPronoun.they,
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
                      SafeArea(
                        child: LinearGradientButton.primaryButton(
                          onTap:
                              state.gender == null ? null : bloc.updateProfile,
                          label: t.onboarding.next,
                          loadingWhen: state.status == OnboardingStatus.loading,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
