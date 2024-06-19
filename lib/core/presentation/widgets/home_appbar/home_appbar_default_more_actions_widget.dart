import 'dart:io';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/enums/common_more_actions_enum.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/widgets/complete_profile_bottomsheet.dart';
import 'package:app/core/presentation/widgets/report_issue_bottom_sheet/report_issue_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/onboarding_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeAppBarDefaultMoreActionsWidget extends StatelessWidget {
  const HomeAppBarDefaultMoreActionsWidget({super.key});

  Widget getThemeIcon(BuildContext context, {required SvgGenImage icon}) {
    final colorScheme = Theme.of(context).colorScheme;
    return ThemeSvgIcon(
      color: colorScheme.onPrimary,
      builder: (filter) => icon.svg(
        colorFilter: filter,
        width: Sizing.mSmall,
        height: Sizing.mSmall,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final isLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          authenticated: (_) => true,
        );
    final walletState = context.watch<WalletBloc>().state;
    const showRedDot = true;
    return FloatingFrostedGlassDropdown(
      items: [
        DropdownItemDpo(
          value: CommonMoreActions.viewProfile,
          label: t.home.appBar.moreActions.myProfile,
          leadingIcon: getThemeIcon(context, icon: Assets.icons.icProfile),
          customColor: colorScheme.onPrimary,
        ),
        DropdownItemDpo(
          value: CommonMoreActions.completeProfile,
          label: t.home.appBar.moreActions.completeProfile,
          leadingIcon:
              getThemeIcon(context, icon: Assets.icons.icPersonCelebrate),
          customColor: colorScheme.onPrimary,
          showRedDot: OnboardingUtils.showRedDotCompleteProfile(
            user: loggedInUser,
            walletState: walletState,
          ),
        ),
        DropdownItemDpo(
          value: CommonMoreActions.viewSettings,
          label: t.home.appBar.moreActions.setting,
          leadingIcon: getThemeIcon(context, icon: Assets.icons.icSettings),
          customColor: colorScheme.onPrimary,
        ),
        DropdownItemDpo(
          value: CommonMoreActions.reportIssue,
          label: t.home.appBar.moreActions.reportIssue,
          leadingIcon: getThemeIcon(context, icon: Assets.icons.icReport),
          customColor: colorScheme.onPrimary,
        ),
        DropdownItemDpo(
          value: CommonMoreActions.rateApp,
          label: t.home.appBar.moreActions.rateApp,
          leadingIcon: getThemeIcon(context, icon: Assets.icons.icStar),
          customColor: colorScheme.onPrimary,
        ),
        DropdownItemDpo(
          value: CommonMoreActions.followLemonde,
          label: t.home.appBar.moreActions.followLemonade,
          leadingIcon: getThemeIcon(context, icon: Assets.icons.icAddGuest),
          customColor: colorScheme.onPrimary,
        ),
        if (isLoggedIn)
          DropdownItemDpo(
            value: CommonMoreActions.signOut,
            label: t.home.appBar.moreActions.signOut,
            leadingIcon: ThemeSvgIcon(
              color: LemonColor.coralReef,
              builder: (filter) => Assets.icons.icLogout.svg(
                colorFilter: filter,
              ),
            ),
            customColor: LemonColor.coralReef,
          ),
      ],
      onItemPressed: (item) {
        if (item?.value == CommonMoreActions.rateApp) {
          launchUrl(
            Uri.parse(
              Platform.isIOS
                  ? AppConfig.lemonadeIosDownloadUrl
                  : AppConfig.lemonadeAndroidDownloadUrl,
            ),
          );
          return;
        }

        if (item?.value == CommonMoreActions.followLemonde) {
          launchUrl(
            Uri.parse(AppConfig.lemonadeTwitterUrl),
          );
          return;
        }

        if (!isLoggedIn) {
          AutoRouter.of(context).push(const LoginRoute());
          return;
        }

        if (item?.value == CommonMoreActions.completeProfile) {
          showCupertinoModalBottomSheet(
            context: context,
            useRootNavigator: true,
            backgroundColor: LemonColor.atomicBlack,
            barrierColor: LemonColor.black87,
            builder: (mContext) => const CompleteProfileBottomSheet(),
          );
          return;
        }

        if (item?.value == CommonMoreActions.viewProfile) {
          AutoRouter.of(context).push(const MyProfileRoute());
          return;
        }

        if (item?.value == CommonMoreActions.viewSettings) {
          AutoRouter.of(context).push(const SettingRoute());
          return;
        }

        if (item?.value == CommonMoreActions.reportIssue) {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (mContext) => const ReportIssueBottomSheet(),
          );
          return;
        }

        if (item?.value == CommonMoreActions.signOut) {
          context.read<AuthBloc>().add(const AuthEvent.logout());
          return;
        }
      },
      child: Stack(
        children: [
          Assets.icons.icMoreVertical.svg(
            width: Sizing.small,
            height: Sizing.small,
          ),
          if (showRedDot == true) ...[
            Positioned(
              bottom: 0,
              right: 3.w,
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: const ShapeDecoration(
                  color: LemonColor.coralReef,
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
