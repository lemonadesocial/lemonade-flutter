import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class OnboardingUtils {
  static isOnboardingRequired(User user) {
    return user.username == null ||
        user.username?.isEmpty == true ||
        user.termsAcceptedAdult != true ||
        user.termsAcceptedConditions != true;
  }

  static startOnboarding(
    BuildContext context, {
    required User user,
  }) {
    context.router.push(
      OnboardingWrapperRoute(
        children: [
          if (user.termsAcceptedAdult != true) const OnboardingTermAdultRoute(),
          if (user.termsAcceptedAdult == true &&
              user.termsAcceptedConditions != true)
            const OnboardingTermConditionsRoute(),
          if (user.termsAcceptedAdult == true &&
              user.termsAcceptedConditions == true)
            OnboardingUsernameRoute()
        ],
      ),
    );
  }
}
