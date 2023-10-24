import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class OnboardingTermAdultPage extends StatelessWidget {
  const OnboardingTermAdultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final onboardingBloc = context.watch<OnboardingBloc>();
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          AutoRouter.of(context).replace(const OnboardingTermConditionsRoute());
        }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: colorScheme.background,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 180.w,
                height: 180.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180.w),
                  color: colorScheme.secondaryContainer,
                ),
                child: Center(
                  child: Text(
                    '18+',
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontFamily: FontFamily.nohemiVariable,
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Spacing.xLarge * 1.5,
              ),
              Text(
                t.onboarding.termAdult.title,
                style: Typo.extraLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  fontFamily: FontFamily.nohemiVariable,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                child: Text(
                  t.onboarding.termAdult.description,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                    fontFamily: FontFamily.switzerVariable,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: LinearGradientButton(
                    onTap: () {
                      onboardingBloc.acceptTerm(
                        UpdateUserProfileInput(
                          termsAcceptedAdult: true,
                        ),
                      );
                    },
                    label: t.onboarding.termAdult.action,
                    textStyle: Typo.medium.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.87),
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                    height: Sizing.large,
                    radius: BorderRadius.circular(24.r),
                    mode: GradientButtonMode.lavenderMode,
                    loadingWhen:
                        onboardingBloc.state.status == OnboardingStatus.loading,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
