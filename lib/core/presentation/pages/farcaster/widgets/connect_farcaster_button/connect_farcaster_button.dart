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

class ConnectFarcasterButton extends StatelessWidget {
  const ConnectFarcasterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final farcasterConnected =
        loggedInUser?.farcasterUserInfo?.accountKeyRequest?.accepted == true;

    return InkWell(
      onTap: () {
        if (loggedInUser == null) {
          AutoRouter.of(context).push(const LoginRoute());
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
      child: Container(
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
      ),
    );
  }
}
