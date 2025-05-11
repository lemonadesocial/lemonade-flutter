import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/connect_farcaster_bottomsheet/connect_farcaster_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum ConnectFarcasterButtonVariant {
  home,
  drawer,
}

class ConnectFarcasterButton extends StatelessWidget {
  final ConnectFarcasterButtonVariant variant;
  const ConnectFarcasterButton({
    super.key,
    this.variant = ConnectFarcasterButtonVariant.drawer,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
          onBoardingRequired: (user) => user,
        );
    final farcasterConnected =
        loggedInUser?.farcasterUserInfo?.accountKeyRequest?.accepted == true;

    return InkWell(
      onTap: () {
        if (loggedInUser == null) {
          AutoRouter.of(context).push(LoginRoute());
        } else {
          if (farcasterConnected) {
            return;
          }
          showCupertinoModalBottomSheet(
            backgroundColor: LemonColor.atomicBlack,
            context: context,
            useRootNavigator: true,
            builder: (mContext) => ConnectFarcasterBottomsheet(
              onConnected: () {
                context.read<AuthBloc>().add(const AuthEvent.refreshData());
                Navigator.of(context, rootNavigator: true).pop();
                SnackBarUtils.showSuccess(
                  message: t.farcaster.farcasterConnectedSuccess,
                );
              },
            ),
          );
        }
      },
      child: variant == ConnectFarcasterButtonVariant.drawer
          ? _DrawerButton(farcasterConnected: farcasterConnected)
          : const _HomeButton(),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    required this.farcasterConnected,
  });

  final bool farcasterConnected;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      padding: EdgeInsets.only(
        top: Spacing.superExtraSmall,
        bottom: Spacing.superExtraSmall,
        left: Spacing.superExtraSmall,
        right: Spacing.smMedium,
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.large,
            height: Sizing.large,
            decoration: BoxDecoration(
              color: LemonColor.farcasterViolet,
              borderRadius: BorderRadius.circular(LemonRadius.xSmall),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icFarcaster.svg(
                  colorFilter: filter,
                  width: Sizing.small,
                  height: Sizing.small,
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.profile.socials.farcaster,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  t.farcaster.shareYourEvents,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.small),
          if (!farcasterConnected)
            SizedBox(
              height: 32.w,
              child: LinearGradientButton.secondaryButton(
                label: StringUtils.capitalize(t.common.actions.connect),
                textStyle: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          if (farcasterConnected)
            LemonOutlineButton(
              height: 32.w,
              label: t.common.status.connected,
              radius: BorderRadius.circular(LemonRadius.button),
              textStyle: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      padding: EdgeInsets.all(Spacing.smMedium),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.03),
              borderRadius: BorderRadius.circular(LemonRadius.xSmall),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: LemonColor.farcasterViolet,
                builder: (filter) => Assets.icons.icFarcaster.svg(
                  colorFilter: filter,
                  width: Sizing.small,
                  height: Sizing.small,
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.farcaster.connectFarcaster,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icArrowRight.svg(
                        colorFilter: filter,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.w),
                Text(
                  t.farcaster.connectFarcasterHomepageDescription,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
