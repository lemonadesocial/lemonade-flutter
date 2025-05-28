import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/widgets/lemon_drawer_profile_info.dart';
import 'package:app/core/presentation/widgets/common/drawer/widgets/lemon_drawer_tile_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/widgets/complete_profile_bottomsheet.dart';
import 'package:app/core/utils/onboarding_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LemonDrawer extends StatelessWidget {
  const LemonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final backIcon = ThemeSvgIcon(
      color: appColors.textTertiary,
      builder: (filter) => Assets.icons.icArrowBack.svg(
        colorFilter: filter,
        width: Sizing.s5,
        height: Sizing.s5,
      ),
    );

    final user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final walletState = context.watch<WalletBloc>().state;

    final stepsRemaining = OnboardingUtils.getStepsRemainingToCompleteProfile(
      user: user,
      walletState: walletState,
    );

    final listTitleWidgets = [
      LemonDrawerTileWidget(
        title: t.home.drawer.communities,
        subtitle: t.home.drawer.communitiesDesc,
        leading: ThemeSvgIcon(
          color: appColors.textTertiary,
          builder: (filter) {
            return Assets.icons.icWorkspacesOutline.svg(
              colorFilter: filter,
              width: Sizing.s6,
              height: Sizing.s6,
            );
          },
        ),
        featureAvailable: true,
        trailing: backIcon,
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          context.read<AuthBloc>().state.maybeWhen(
                authenticated: (authSession) => context.router.push(
                  const SpacesListingRoute(),
                ),
                orElse: () => context.router.navigate(
                  LoginRoute(),
                ),
              );
        },
        radius: BorderRadius.only(
          topLeft: Radius.circular(LemonRadius.md),
          topRight: Radius.circular(LemonRadius.md),
        ),
      ),
      Divider(
        height: 1.w,
        thickness: 1.w,
        color: appColors.pageDivider,
      ),
      LemonDrawerTileWidget(
        title: t.home.drawer.events,
        leading: ThemeSvgIcon(
          color: appColors.textTertiary,
          builder: (filter) {
            return Assets.icons.icCelebrationOutline.svg(
              colorFilter: filter,
              width: Sizing.s6,
              height: Sizing.s6,
            );
          },
        ),
        featureAvailable: true,
        trailing: backIcon,
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          context.read<AuthBloc>().state.maybeWhen(
                authenticated: (authSession) =>
                    context.router.push(MyEventsRoute()),
                orElse: () => context.router.navigate(
                  LoginRoute(),
                ),
              );
        },
      ),
      Divider(
        height: 1.w,
        thickness: 1.w,
        color: appColors.pageDivider,
      ),
      LemonDrawerTileWidget(
        title: t.home.drawer.tickets,
        subtitle: t.home.drawer.ticketsDesc,
        leading: ThemeSvgIcon(
          color: appColors.textTertiary,
          builder: (filter) {
            return Assets.icons.icConfirmationNumberOutlineSharp.svg(
              colorFilter: filter,
              width: Sizing.s6,
              height: Sizing.s6,
            );
          },
        ),
        trailing: backIcon,
        featureAvailable: true,
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          context.read<AuthBloc>().state.maybeWhen(
                authenticated: (authSession) => context.router.push(
                  MyEventTicketsListRoute(),
                ),
                orElse: () => context.router.navigate(
                  LoginRoute(),
                ),
              );
        },
      ),
      Divider(
        height: 1.w,
        thickness: 1.w,
        color: appColors.pageDivider,
      ),
      LemonDrawerTileWidget(
        title: t.home.drawer.payoutAccounts,
        subtitle: t.home.drawer.payoutAccountsDesc,
        leading: ThemeSvgIcon(
          color: appColors.textTertiary,
          builder: (filter) {
            return Assets.icons.icBank.svg(
              colorFilter: filter,
              width: Sizing.s6,
              height: Sizing.s6,
            );
          },
        ),
        trailing: backIcon,
        featureAvailable: true,
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          context.read<AuthBloc>().state.maybeWhen(
                authenticated: (authSession) => context.router.push(
                  const VaultRootRoute(),
                ),
                orElse: () => context.router.navigate(
                  LoginRoute(),
                ),
              );
        },
        radius: BorderRadius.only(
          bottomLeft: Radius.circular(LemonRadius.md),
          bottomRight: Radius.circular(LemonRadius.md),
        ),
      ),
    ];

    return Container(
      color: appColors.pageBg,
      child: SafeArea(
        child: Drawer(
          backgroundColor: appColors.pageBg,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            backgroundColor: appColors.pageBg,
            appBar: LemonAppBar(
              leading: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      AutoRouter.of(context).navigate(const SettingRoute());
                    },
                    child: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icSettings.svg(
                        colorFilter: filter,
                        width: Sizing.s6,
                        height: Sizing.s6,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: appColors.pageBg,
              title: '',
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: Spacing.s4),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) =>
                          Assets.icons.icKeyboardDoubleArrowLeft.svg(
                        width: Sizing.s6,
                        height: Sizing.s6,
                        colorFilter: filter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: LemonDrawerProfileInfo(),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    height: Spacing.s5 * 2 + 6.w,
                    thickness: 6.w,
                    color: appColors.pageDividerInverse,
                  ),
                ),
                if (stepsRemaining > 0) ...[
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.s4,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: LemonDrawerTileWidget(
                        title: t.home.drawer.completeProfile,
                        subtitle:
                            t.home.drawer.stepRemaining(n: stepsRemaining),
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            backgroundColor: appColors.pageBg,
                            barrierColor: Colors.black.withOpacity(0.5),
                            builder: (mContext) =>
                                const CompleteProfileBottomSheet(),
                          );
                        },
                        radius: BorderRadius.circular(LemonRadius.md),
                        leading: Transform.scale(
                          scale: 1.5,
                          child: Assets.icons.icLoaderFinite.svg(
                            width: Sizing.s6,
                            height: Sizing.s6,
                          ),
                        ),
                        leadingBackgroundColor: Colors.transparent,
                        trailing: backIcon,
                        border: Border.all(
                          color: appColors.cardBorder,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.s4),
                  ),
                ],
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.s4,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: LemonDrawerTileWidget(
                      title: t.home.drawer.earnPoint,
                      subtitle: t.home.drawer.earnPointDesc,
                      onTap: () {
                        context.router.push(const QuestRoute());
                      },
                      radius: BorderRadius.circular(LemonRadius.md),
                      leading: Assets.icons.icQuestLemonadeGradient.svg(
                        width: Sizing.s6,
                        height: Sizing.s6,
                      ),
                      leadingBackgroundColor: appColors.chipWarningBg,
                      trailing: backIcon,
                      border: Border.all(
                        color: appColors.cardBorder,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.s4),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.s4,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appColors.pageDivider,
                        ),
                        borderRadius: BorderRadius.circular(LemonRadius.md),
                      ),
                      child: Column(
                        children: listTitleWidgets,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
