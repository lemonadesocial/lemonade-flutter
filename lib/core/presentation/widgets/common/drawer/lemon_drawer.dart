import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/connect_farcaster_button/connect_farcaster_button.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_onboarding_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/widgets/lemon_drawer_profile_info.dart';
import 'package:app/core/presentation/widgets/common/drawer/widgets/lemon_drawer_tile_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LemonDrawer extends StatelessWidget {
  const LemonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.background,
      child: SafeArea(
        child: Drawer(
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            appBar: LemonAppBar(
              title: '',
              leading: const LemonBackButton(),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: Spacing.smMedium),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Vibrate.feedback(FeedbackType.light);
                      AutoRouter.of(context).navigate(const SettingRoute());
                    },
                    child: ThemeSvgIcon(
                      color: colorScheme.onSurface,
                      builder: (filter) => Assets.icons.icSettings.svg(
                        width: 24.h,
                        height: 24.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                minimum: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LemonDrawerProfileInfo(),
                    SizedBox(
                      height: 30.h,
                    ),
                    BlocBuilder<LensAuthBloc, LensAuthState>(
                      builder: (context, lensAuthState) {
                        return FutureBuilder<String?>(
                          future: getIt<WalletConnectService>()
                              .getActiveSession()
                              .then((session) => session?.address),
                          builder: (context, snapshot) {
                            return LemonDrawerTileWidget(
                              title: t.common.wallet,
                              subtitle: lensAuthState.connected
                                  ? Web3Utils.formatIdentifier(
                                      snapshot.data ?? '',
                                    )
                                  : '',
                              disabled: lensAuthState.connected,
                              leading: ThemeSvgIcon(
                                color: colorScheme.onPrimary,
                                builder: (filter) {
                                  return Assets.icons.icFarcaster.svg(
                                    colorFilter: filter,
                                    width: 18.w,
                                    height: 18.w,
                                  );
                                },
                              ),
                              featureAvailable: true,
                              trailing:
                                  BlocBuilder<LensAuthBloc, LensAuthState>(
                                builder: (context, state) {
                                  final isConnected = state.connected;
                                  final isLoggedIn = state.loggedIn;
                                  if (isConnected && isLoggedIn) {
                                    return OutlinedButton(
                                      onPressed: () {
                                        context.read<WalletBloc>().add(
                                              const WalletEvent.disconnect(),
                                            );
                                        context.read<LensAuthBloc>().add(
                                              const LensAuthEvent
                                                  .unauthorized(),
                                            );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Spacing.xSmall,
                                          vertical: Spacing.extraSmall,
                                        ),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        t.common.status.connected,
                                        style: Typo.small.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                    );
                                  }
                                  return LinearGradientButton.secondaryButton(
                                    height: 32.w,
                                    label:
                                        t.common.actions.connect.capitalize(),
                                    radius: BorderRadius.circular(
                                      LemonRadius.large,
                                    ),
                                    textStyle: Typo.small.copyWith(
                                      color: colorScheme.onPrimary,
                                    ),
                                    onTap: () async {
                                      await showCupertinoModalBottomSheet(
                                        backgroundColor: LemonColor.atomicBlack,
                                        context: context,
                                        useRootNavigator: true,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        builder: (newContext) {
                                          return const LensOnboardingBottomSheet();
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              onTap: () {},
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    LemonDrawerTileWidget(
                      title: t.common.vaults,
                      leading: ThemeSvgIcon(
                        color: colorScheme.onPrimary,
                        builder: (filter) {
                          return Assets.icons.icBank
                              .svg(colorFilter: filter, width: 18, height: 18);
                        },
                      ),
                      featureAvailable: true,
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        context.read<AuthBloc>().state.maybeWhen(
                              authenticated: (authSession) =>
                                  context.router.push(
                                const VaultsListingRoute(),
                              ),
                              orElse: () => context.router.navigate(
                                LoginRoute(),
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    LemonDrawerTileWidget(
                      title: t.common.community.capitalize(),
                      leading: ThemeSvgIcon(
                        color: colorScheme.onPrimary,
                        builder: (filter) {
                          return Assets.icons.icPeopleAlt.svg(
                            colorFilter: filter,
                            width: 18.w,
                            height: 18.w,
                          );
                        },
                      ),
                      featureAvailable: true,
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        context.read<AuthBloc>().state.maybeWhen(
                              authenticated: (authSession) =>
                                  context.router.push(const CommunityRoute()),
                              orElse: () => context.router.navigate(
                                LoginRoute(),
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    LemonDrawerTileWidget(
                      title: t.event.events.capitalize(),
                      leading: ThemeSvgIcon(
                        color: colorScheme.onPrimary,
                        builder: (filter) {
                          return Assets.icons.icHouseParty.svg(
                            colorFilter: filter,
                            width: 18.w,
                            height: 18.w,
                          );
                        },
                      ),
                      featureAvailable: true,
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        context.read<AuthBloc>().state.maybeWhen(
                              authenticated: (authSession) =>
                                  AutoRouter.of(context)
                                      .navigate(const MyEventsRoute()),
                              orElse: () => context.router.navigate(
                                LoginRoute(),
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    LemonDrawerTileWidget(
                      title: t.common.ticket(n: 2).capitalize(),
                      leading: ThemeSvgIcon(
                        color: colorScheme.onPrimary,
                        builder: (filter) {
                          return Assets.icons.icTicket.svg(
                            colorFilter: filter,
                            width: 18.h,
                            height: 18.w,
                          );
                        },
                      ),
                      trailing: Assets.icons.icArrowBack.svg(
                        width: 18.w,
                        height: 18.w,
                      ),
                      featureAvailable: true,
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        context.read<AuthBloc>().state.maybeWhen(
                              authenticated: (authSession) =>
                                  context.router.push(
                                MyEventTicketsListRoute(),
                              ),
                              orElse: () => context.router.navigate(
                                LoginRoute(),
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    LemonDrawerTileWidget(
                      title: t.common.dashboard.capitalize(),
                      leading: ThemeSvgIcon(
                        color: colorScheme.onPrimary,
                        builder: (filter) {
                          return Assets.icons.icInsights
                              .svg(colorFilter: filter, width: 18, height: 18);
                        },
                      ),
                      featureAvailable: false,
                      onTap: () {
                        Vibrate.feedback(FeedbackType.light);
                        SnackBarUtils.showComingSoon();
                      },
                    ),
                    SizedBox(
                      height: Spacing.xSmall,
                    ),
                    const ConnectFarcasterButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
