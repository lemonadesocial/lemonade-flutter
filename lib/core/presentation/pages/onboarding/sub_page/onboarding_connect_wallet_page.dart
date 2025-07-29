import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Scaffold(
      backgroundColor: appColors.pageOverlaySecondary,
      appBar: LemonAppBar(
        backgroundColor: Colors.transparent,
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
              style: appText.md.copyWith(
                color: appColors.textTertiary,
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
            Container(
              width: 231,
              height: 231,
              decoration: BoxDecoration(
                color: appColors.buttonTertiaryBg,
                borderRadius: BorderRadius.circular(LemonRadius.full),
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) =>
                      Assets.icons.icAccountBalanceWalletOutlineSharp.svg(
                    colorFilter: filter,
                    width: 85,
                    height: 85,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              t.common.actions.connectWallet,
              style: appText.xl,
            ),
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              t.lens.onboardingConnectDescription,
              style: appText.md.copyWith(
                color: appColors.textTertiary,
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
                        radius: BorderRadius.circular(LemonRadius.full),
                        label: "Connect Wallet",
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
