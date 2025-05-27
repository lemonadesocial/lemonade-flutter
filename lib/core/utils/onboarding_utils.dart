import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class OnboardingUtils {
  static isOnboardingRequired(User user) {
    return user.termsAcceptedAdult != true ||
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
            const OnboardingConnectWalletRoute(),
        ],
      ),
    );
  }

  static showRedDotCompleteProfile({
    required User? user,
    required WalletState walletState,
  }) {
    final filledUsername = (user?.username ?? '').isNotEmpty;
    final filledAvatar = (user?.imageAvatar ?? '').isNotEmpty;
    final connectedFarcaster =
        user?.farcasterUserInfo?.accountKeyRequest?.accepted == true;
    final connectedWallet = walletState.activeSession != null;
    if (filledUsername &&
        filledAvatar &&
        connectedWallet &&
        connectedFarcaster) {
      return false;
    }
    return true;
  }

  static int getStepsRemainingToCompleteProfile({
    required User? user,
    required WalletState walletState,
  }) {
    int stepsRemaining = 0;
    final filledUsername = (user?.username ?? '').isNotEmpty;
    final filledAvatar = (user?.imageAvatar ?? '').isNotEmpty;
    final connectedFarcaster =
        user?.farcasterUserInfo?.accountKeyRequest?.accepted == true;
    final connectedWallet = walletState.activeSession != null;
    if (!filledUsername) stepsRemaining++;
    if (!filledAvatar) stepsRemaining++;
    if (!connectedWallet) stepsRemaining++;
    if (!connectedFarcaster) stepsRemaining++;
    return stepsRemaining;
  }
}
