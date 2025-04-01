import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/connect_farcaster_button/connect_farcaster_button.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:reown_appkit/reown_appkit.dart';

@RoutePage()
class OnboardingSocialOnChainPage extends StatelessWidget {
  const OnboardingSocialOnChainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final farcasterConnected =
        loggedInUser?.farcasterUserInfo?.accountKeyRequest?.accepted == true;

    return Scaffold(
      appBar: LemonAppBar(
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () => context.router.push(const OnboardingAboutRoute()),
                child: Text(
                  t.onboarding.skip,
                  style: Typo.medium.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(width: Spacing.smMedium),
            ],
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Spacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.onboarding.getSocialOnChain,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800,
                      color: LemonColor.onboardingTitle,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.extraSmall),
                  Text(
                    t.onboarding.getSocialOnChainDescription,
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: Spacing.medium),
                  const ConnectFarcasterButton(
                    variant: ConnectFarcasterButtonVariant.home,
                  ),
                  SizedBox(height: Spacing.medium),
                  ConnectWalletButton(
                    builder: (onPressConnect, connectButtonState) {
                      final w3mService =
                          getIt<WalletConnectService>().w3mService;
                      // final userWalletAddress =
                      //     connectButtonState == ConnectButtonState.connected
                      //         ? w3mService.session?.address
                      //         : null;
                      // TODO: FIX WALLET MIGRATION
                      final userWalletAddress = '';
                      return SettingTileWidget(
                        radius: LemonRadius.medium,
                        leadingRadius: LemonRadius.xSmall,
                        title: t.common.actions.connectWallet,
                        subTitle: userWalletAddress != null
                            ? Web3Utils.formatIdentifier(userWalletAddress)
                            : t.common.status.notConnected,
                        leading: ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => Assets.icons.icWallet.svg(
                            colorFilter: filter,
                          ),
                        ),
                        trailing: Assets.icons.icArrowBack.svg(
                          width: 18.w,
                          height: 18.w,
                        ),
                        onTap: () {
                          try {
                            onPressConnect(context);
                          } catch (e) {
                            CrashAnalyticsManager()
                                .crashAnalyticsService
                                ?.captureError(
                                  e,
                                  StackTrace.current,
                                );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                final isConnectedWallet = state.activeSession != null;
                final isEnabledNextButton =
                    farcasterConnected == true || isConnectedWallet == true;
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.xSmall,
                    ),
                    child: Opacity(
                      opacity: isEnabledNextButton == true ? 1 : 0.5,
                      child: LinearGradientButton(
                        onTap: () async {
                          if (isEnabledNextButton == false) {
                            return;
                          }
                          context.router.push(const OnboardingAboutRoute());
                        },
                        label: t.onboarding.next,
                        textStyle: Typo.medium.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimary,
                        ),
                        height: Sizing.large,
                        radius: BorderRadius.circular(LemonRadius.large),
                        mode: GradientButtonMode.lavenderMode,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
