import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slang/builder/utils/string_extensions.dart';

class LeftPanelProfileInfo extends StatelessWidget {
  const LeftPanelProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authSession = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LemonCircleAvatar(
              url: authSession!.imageAvatar ?? '',
              size: 60.r,
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authSession.displayName ?? '',
                    style:
                        Typo.extraMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    '@${authSession.username ?? ''}',
                    style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 18.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              onPressed: () => _onPressEditProfile(context, authSession),
              icon: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: 15.w,
                  height: 15.h,
                ),
              ),
              label: Text(
                t.common.actions.edit.capitalize(),
                style: Typo.small.copyWith(color: colorScheme.onPrimary),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 9.w,
            ),
            OutlinedButton.icon(
              onPressed: () => _onPressQRCode(context),
              icon: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icQr.svg(
                  colorFilter: filter,
                  width: 15.w,
                  height: 15.h,
                ),
              ),
              label: Text(
                t.common.qrCode,
                style: Typo.small.copyWith(color: colorScheme.onPrimary),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 9.w,
            ),
            OutlinedButton.icon(
              onPressed: () => _onPressShare(context, authSession),
              icon: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icShare.svg(
                  colorFilter: filter,
                  width: 15.w,
                  height: 15.h,
                ),
              ),
              label: Text(
                t.common.actions.share.capitalize(),
                style: Typo.small.copyWith(color: colorScheme.onPrimary),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onPressEditProfile(BuildContext context, User authSession) {
    Vibrate.feedback(FeedbackType.light);
    AutoRouter.of(context).navigate(EditProfileRoute(userProfile: authSession));
  }

  _onPressQRCode(BuildContext context) {
    Vibrate.feedback(FeedbackType.light);
    AutoRouter.of(context).navigate(const QrCodeRoute());
  }

  _onPressShare(BuildContext context, User authSession) async {
    Vibrate.feedback(FeedbackType.light);
    try {
      final box = context.findRenderObject() as RenderBox?;
      await Share.share(
        '${AppConfig.webUrl}/${authSession.username}',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error _shareProfileLink $e");
      }
    }
  }
}
