import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/onboarding/onboarding_bloc/onboarding_bloc.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
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
            AutoRouter.of(context).replace(
              const OnboardingConnectWalletRoute(),
            );
          } else {
            authBloc.add(const AuthEvent.authenticated());
            context.router.replaceAll([const RootRoute()]);
          }
        }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: appColors.pageBg,
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
                              style: appText.xl,
                            ),
                            SizedBox(height: Spacing.smMedium),
                            Text(
                              t.onboarding.termConditions.description,
                              style: appText.md.copyWith(
                                color: appColors.textTertiary,
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
                      child: LinearGradientButton.primaryButton(
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.s3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        color: appColors.cardBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: appText.md,
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            description,
            style: appText.sm.copyWith(
              color: appColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
