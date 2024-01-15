import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class OnboardingTermConditionsPage extends StatefulWidget {
  const OnboardingTermConditionsPage({super.key});

  @override
  State<OnboardingTermConditionsPage> createState() =>
      _OnboardingTermConditionsPageState();
}

class _OnboardingTermConditionsPageState
    extends State<OnboardingTermConditionsPage> {
  final controller = ScrollController();
  bool termConditionsAccepted = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final onboardingBloc = context.watch<OnboardingBloc>();
    final authBloc = context.watch<AuthBloc>();

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          final username = authBloc.state.maybeWhen(
            onBoardingRequired: (user) => user.username,
            orElse: () => null,
          );
          if (username == null || username.isEmpty == true) {
            AutoRouter.of(context).replace(OnboardingUsernameRoute());
          } else {
            authBloc.add(const AuthEvent.authenticated());
            context.router.replaceAll([const RootRoute()]);
          }
        }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: colorScheme.background,
          body: Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    if (termConditionsAccepted) return true;
                    setState(() {
                      termConditionsAccepted = true;
                    });
                  }
                  return true;
                },
                child: CustomScrollView(
                  controller: controller,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.medium),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: Spacing.xLarge * 3),
                            Text(
                              t.onboarding.termConditions.title,
                              style: Typo.extraLarge.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w800,
                                fontFamily: FontFamily.nohemiVariable,
                              ),
                            ),
                            SizedBox(height: Spacing.smMedium),
                            Text(
                              t.onboarding.termConditions.description,
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onSecondary,
                                fontFamily: FontFamily.switzerVariable,
                              ),
                            ),
                            SizedBox(height: Spacing.smMedium * 2),
                            TermConditionItem(
                              title: t.onboarding.termConditionsStaySafe.title,
                              description: t.onboarding.termConditionsStaySafe
                                  .description,
                            ),
                            SizedBox(height: Spacing.extraSmall),
                            TermConditionItem(
                              title:
                                  t.onboarding.termConditionsPlayItCool.title,
                              description: t.onboarding.termConditionsPlayItCool
                                  .description,
                            ),
                            SizedBox(height: Spacing.extraSmall),
                            TermConditionItem(
                              title:
                                  t.onboarding.termConditionsBeProactive.title,
                              description: t.onboarding
                                  .termConditionsBeProactive.description,
                            ),
                            SizedBox(height: Spacing.medium * 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: colorScheme.background,
                  padding: EdgeInsets.only(
                    top: Spacing.smMedium,
                    left: Spacing.smMedium,
                    right: Spacing.smMedium,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Opacity(
                      opacity: termConditionsAccepted ? 1 : 0.5,
                      child: LinearGradientButton(
                        onTap: () {
                          if (termConditionsAccepted) {
                            onboardingBloc.acceptTerm(
                              UpdateUserProfileInput(
                                termsAcceptedConditions: true,
                              ),
                            );
                          } else {
                            controller.animateTo(
                              controller.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          }
                        },
                        label: t.onboarding.termConditions.action,
                        textStyle: Typo.medium.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.87),
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                        height: Sizing.large,
                        radius: BorderRadius.circular(24.r),
                        mode: GradientButtonMode.lavenderMode,
                        loadingWhen: onboardingBloc.state.status ==
                            OnboardingStatus.loading,
                      ),
                    ),
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

class TermConditionItem extends StatelessWidget {
  final String title;
  final String description;

  const TermConditionItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.medium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        color: LemonColor.atomicBlack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            description,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
