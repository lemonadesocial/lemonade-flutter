import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class OnboardingTermAdultPage extends StatelessWidget {
  const OnboardingTermAdultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

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
          backgroundColor: appColors.pageOverlaySecondary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 230.w,
                height: 230.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(230.w),
                  color: appColors.buttonTertiaryBg,
                ),
                child: Center(
                  child: Text(
                    '18+',
                    style: appText.xxxl.copyWith(
                      fontSize: 72.sp,
                      color: appColors.textTertiary,
                      fontFamily: FontFamily.generalSans,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // SizedBox(
              //   height: Spacing.xLarge * 1.5,
              // ),
              Text(
                t.onboarding.termAdult.title,
                style: appText.xxl,
              ),
              SizedBox(height: Spacing.superExtraSmall),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                child: Text(
                  t.onboarding.termAdult.description,
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: LinearGradientButton.primaryButton(
                    radius: BorderRadius.circular(LemonRadius.full),
                    onTap: () {
                      onboardingBloc.acceptTerm(
                        UpdateUserProfileInput(
                          termsAcceptedAdult: true,
                          dob: DateTime(2000, 1, 1).toUtc(),
                        ),
                      );
                    },
                    label: t.onboarding.termAdult.action,
                    loadingWhen:
                        onboardingBloc.state.status == OnboardingStatus.loading,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
