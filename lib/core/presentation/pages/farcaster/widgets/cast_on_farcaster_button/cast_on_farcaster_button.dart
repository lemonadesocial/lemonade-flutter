import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/connect_farcaster_bottomsheet/connect_farcaster_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CastOnFarcasterButton extends StatelessWidget {
  final Event event;
  const CastOnFarcasterButton({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final farcasterConnected =
        loggedInUser?.farcasterUserInfo?.accountKeyRequest?.accepted == true;

    return InkWell(
      onTap: () async {
        if (loggedInUser == null) {
          AutoRouter.of(context).push(const LoginRoute());
          return;
        }
        if (farcasterConnected) {
          AutoRouter.of(context).push(
            CreateFarcasterCastRoute(
              event: event,
            ),
          );
        } else {
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
                AutoRouter.of(context).push(
                  CreateFarcasterCastRoute(
                    event: event,
                  ),
                );
              },
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          color: LemonColor.atomicBlack,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThemeSvgIcon(
                  color: LemonColor.paleViolet,
                  builder: (filter) => Assets.icons.icFarcaster.svg(
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.extraSmall),
                Text(
                  t.farcaster.shareOnFarcaster,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
