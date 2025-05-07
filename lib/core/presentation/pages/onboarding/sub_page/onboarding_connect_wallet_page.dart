import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/animation/circular_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/utils/string_utils.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class OnboardingConnectWalletPage extends StatelessWidget {
  const OnboardingConnectWalletPage({super.key});

  void submit(BuildContext context) async {
    final isAuthorized = await showCupertinoModalBottomSheet(
      backgroundColor: LemonColor.atomicBlack,
      context: context,
      useRootNavigator: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (newContext) {
        return const LensOnboardingBottomSheet();
      },
    );
    if (isAuthorized == true) {
      AutoRouter.of(context).replaceAll(
        [
          const OnboardingProfilePhotoRoute(),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        leading: const SizedBox.shrink(),
        actions: [
          InkWell(
            onTap: () => context.router.replaceAll(
              [
                const OnboardingProfilePhotoRoute(),
              ],
            ),
            child: Text(
              t.onboarding.skip,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ),
          SizedBox(width: Spacing.medium),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            CircularAnimationWidget(
              icon: Assets.icons.icWalletDarkGradient.svg(),
            ),
            const Spacer(),
            Text(
              t.common.actions.connectWallet,
              style: Typo.extraLarge.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              t.lens.onboardingConnectDescription,
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Spacing.smMedium * 2,
            ),
            SafeArea(
              child: BlocConsumer<WalletBloc, WalletState>(
                listener: (context, state) {
                  final isConnected = state.activeSession != null;
                  if (isConnected) {
                    submit(context);
                    return;
                  }
                },
                builder: (context, state) {
                  final isConnected = state.activeSession != null;
                  return ConnectWalletButton(
                    builder: (onConnectPressed, state) {
                      return LinearGradientButton.primaryButton(
                        textStyle: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                        label: StringUtils.capitalize(t.common.actions.connect),
                        onTap: () async {
                          if (isConnected) {
                            submit(context);
                            return;
                          }
                          onConnectPressed(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
