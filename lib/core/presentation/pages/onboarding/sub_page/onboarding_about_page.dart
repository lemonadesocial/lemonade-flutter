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
            appBar: const LemonAppBar(
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: appColors.pageOverlaySecondary,
            body: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                final invalid = state.gender == null ||
                    state.aboutDisplayName?.isNotEmpty != true;
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
                              style: appText.xxl,
                            ),
                            SizedBox(height: Spacing.extraSmall),
                            Text(
                              t.onboarding.aboutYouDesc,
                              style: appText.sm.copyWith(
                                color: appColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: Spacing.medium),
                            // Gender picker
                            Row(
                              children: [
                                GenderChipWidget(
                                  label: t.onboarding.she,
                                  leading: Assets.icons.icGenderFemale,
                                  activeColor: LemonColor.femaleDefault,
                                  inActiveColor: LemonColor.femaleDefault,
                                  defaultColor: LemonColor.femaleDefault
                                      .withOpacity(0.16),
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
                                  activeColor: appColors.chipAlert,
                                  inActiveColor: appColors.chipAlert,
                                  defaultColor:
                                      appColors.chipAlert.withOpacity(0.16),
                                  onSelect: () =>
                                      bloc.onGenderSelect(LemonPronoun.he),
                                  isSelected: state.gender == null
                                      ? null
                                      : state.gender == LemonPronoun.he,
                                ),
                                SizedBox(width: Spacing.superExtraSmall),
                                GenderChipWidget(
                                  label: t.onboarding.they,
                                  leading: Assets.icons.icGroupOutline,
                                  activeColor: appColors.chipWarning,
                                  inActiveColor: appColors.chipWarning,
                                  defaultColor:
                                      appColors.chipWarning.withOpacity(0.16),
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
                              label: "Name",
                              hintText: "Your Name",
                              showRequired: true,
                              onChange: bloc.onDisplayNameChange,
                              filled: true,
                              fillColor: appColors.pageBg,
                              borderColor: appColors.inputBorder,
                              focusedBorderColor: appColors.textPrimary,
                            ),
                            SizedBox(height: Spacing.xSmall),
                            LemonTextField(
                              inputHeight: 100,
                              label: "Bio",
                              onChange: bloc.onShortBioChange,
                              hintText:
                                  "Share a little about your background and interests.",
                              minLines: 3,
                              fillColor: appColors.pageBg,
                              filled: true,
                              borderColor: appColors.inputBorder,
                              focusedBorderColor: appColors.textPrimary,
                            ),
                          ],
                        ),
                      ),
                      SafeArea(
                        child: Opacity(
                          opacity: invalid ? 0.5 : 1,
                          child: LinearGradientButton.primaryButton(
                            radius: BorderRadius.circular(LemonRadius.full),
                            onTap: () {
                              if (invalid) {
                                return;
                              }
                              bloc.updateProfile();
                            },
                            label: t.onboarding.next,
                            loadingWhen:
                                state.status == OnboardingStatus.loading,
                          ),
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
