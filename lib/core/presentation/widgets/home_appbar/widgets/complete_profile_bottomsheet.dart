import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/connect_farcaster_bottomsheet/connect_farcaster_bottomsheet.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
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
import 'package:web3modal_flutter/widgets/buttons/connect_button.dart';

class CompleteProfileBottomSheet extends StatelessWidget {
  const CompleteProfileBottomSheet({
    super.key,
  });

  double getPercentage({
    required User? user,
    required WalletState walletState,
  }) {
    if (user == null) return 0.0;

    double percentage = 0.0;
    if ((user.username ?? '').isNotEmpty) percentage += 0.25;
    if ((user.imageAvatar ?? '').isNotEmpty) percentage += 0.25;
    if (user.farcasterUserInfo?.accountKeyRequest?.accepted ?? false) {
      percentage += 0.25;
    }
    if (walletState.activeSession != null) percentage += 0.25;

    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final walletState = context.watch<WalletBloc>().state;
    final farcasterConnected =
        loggedInUser?.farcasterUserInfo?.accountKeyRequest?.accepted == true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: BottomSheetGrabber()),
        LemonAppBar(
          backgroundColor: LemonColor.atomicBlack,
        ),
        LinearProgressIndicator(
          value: getPercentage(user: loggedInUser, walletState: walletState),
          color: LemonColor.paleViolet,
          minHeight: 3.w,
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.profile.completeProfile.label,
                  style: Typo.extraLarge.copyWith(
                    fontFamily: FontFamily.nohemiVariable,
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: Spacing.superExtraSmall,
                ),
                Text(
                  t.profile.completeProfile.description,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: Spacing.medium,
                ),
                _RowItem(
                  title: t.profile.completeProfile.pickUsername,
                  subtitle: t.profile.completeProfile.pickUsernameDesc,
                  icon: ThemeSvgIcon(
                    color: LemonColor.coralReef,
                    builder: (filter) => Assets.icons.icEmailAt.svg(
                      colorFilter: filter,
                      width: Sizing.mSmall,
                      height: Sizing.mSmall,
                    ),
                  ),
                  backgroundColor: LemonColor.coralReef.withOpacity(0.18),
                  iconColor: Colors.white,
                  checked: loggedInUser?.username?.isNotEmpty,
                  onTap: () => AutoRouter.of(context).push(
                    OnboardingUsernameRoute(onboardingFlow: false),
                  ),
                ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
                _RowItem(
                  title: t.profile.completeProfile.pickYourProfilePhoto,
                  subtitle: t.profile.completeProfile.pickYourProfilePhotoDesc,
                  icon: ThemeSvgIcon(
                    color: LemonColor.jordyBlue,
                    builder: (filter) => Assets.icons.icProfile.svg(
                      colorFilter: filter,
                      width: Sizing.mSmall,
                      height: Sizing.mSmall,
                    ),
                  ),
                  backgroundColor: LemonColor.jordyBlue.withOpacity(0.18),
                  iconColor: Colors.white,
                  checked: (loggedInUser?.imageAvatar ?? '').isNotEmpty,
                  onTap: () => AutoRouter.of(context).push(
                    const OnboardingProfilePhotoRoute(),
                  ),
                ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
                BlocBuilder<WalletBloc, WalletState>(
                  builder: (context, walletState) {
                    final connectButtonState = walletState.state;
                    final isConnecting =
                        connectButtonState == ConnectButtonState.connecting;
                    final isConnected = walletState.activeSession != null;
                    return _RowItem(
                      title: t.profile.completeProfile.connectYourWallet,
                      subtitle: t.profile.completeProfile.connectYourWalletDesc,
                      icon: ThemeSvgIcon(
                        color: LemonColor.topaz,
                        builder: (filter) => Assets.icons.icWallet.svg(
                          colorFilter: filter,
                          width: Sizing.mSmall,
                          height: Sizing.mSmall,
                        ),
                      ),
                      backgroundColor: LemonColor.topaz.withOpacity(0.18),
                      iconColor: Colors.white,
                      checked: isConnected,
                      onTap: () {
                        final w3mService =
                            getIt<WalletConnectService>().w3mService;
                        w3mService.openModal(context);
                      },
                      loading: isConnecting,
                    );
                  },
                ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
                _RowItem(
                  title: t.profile.completeProfile.connectFarcaster,
                  subtitle: t.profile.completeProfile.connectFarcasterDesc,
                  icon: ThemeSvgIcon(
                    color: LemonColor.lavender,
                    builder: (filter) => Assets.icons.icFarcaster.svg(
                      colorFilter: filter,
                      width: Sizing.mSmall,
                      height: Sizing.mSmall,
                    ),
                  ),
                  backgroundColor: LemonColor.lavender.withOpacity(0.18),
                  iconColor: Colors.white,
                  checked: farcasterConnected,
                  onTap: () {
                    if (farcasterConnected) {
                      return;
                    }
                    showCupertinoModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      backgroundColor: LemonColor.atomicBlack,
                      barrierColor: LemonColor.black87,
                      builder: (mContext) => ConnectFarcasterBottomsheet(
                        onConnected: () {
                          context
                              .read<AuthBloc>()
                              .add(const AuthEvent.refreshData());
                          SnackBarUtils.showSuccess(
                            message: t.farcaster.farcasterConnectedSuccess,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool? checked;
  final Function()? onTap;
  final bool? loading;

  const _RowItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    this.checked,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        if (onTap != null && checked == false) {
          onTap!.call();
        }
      },
      child: Opacity(
        opacity: checked == true ? 0.4 : 1,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
              child: Center(
                child: icon,
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        title,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        subtitle,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            loading == true
                ? Loading.defaultLoading(context)
                : checked == true
                    ? ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icDone.svg(
                          colorFilter: filter,
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                        ),
                      )
                    : ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icArrowRight.svg(
                          colorFilter: filter,
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
