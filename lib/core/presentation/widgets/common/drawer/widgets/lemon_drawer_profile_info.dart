import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/quest/quest_listing_page/widgets/quest_list.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
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

class LemonDrawerProfileInfo extends StatelessWidget {
  const LemonDrawerProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authSession = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );

    final questPoints = authSession?.questPoints;
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
            LemonOutlineButton(
              onTap: () => _onPressQuest(context),
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              leading: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icTargetLine.svg(
                  colorFilter: filter,
                  width: 15.w,
                  height: 15.w,
                ),
              ),
              label: t.quest
                  .pointsCount(n: questPoints ?? 0, count: questPoints ?? 0),
              textStyle:
                  Typo.small.copyWith(color: colorScheme.onPrimary, height: 0),
              radius: BorderRadius.circular(LemonRadius.button),
            ),
            SizedBox(
              width: 9.w,
            ),
            LemonOutlineButton(
              onTap: () => _onPressEditProfile(context, authSession),
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              leading: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: 15.w,
                  height: 15.w,
                ),
              ),
              label: t.common.actions.edit.capitalize(),
              textStyle:
                  Typo.small.copyWith(color: colorScheme.onPrimary, height: 0),
              radius: BorderRadius.circular(LemonRadius.button),
            ),
            SizedBox(
              width: 9.w,
            ),
            LemonOutlineButton(
              onTap: () => _onPressQRCode(context),
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              leading: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icQr.svg(
                  colorFilter: filter,
                  width: 15.w,
                  height: 15.w,
                ),
              ),
              label: t.common.qrCode,
              textStyle:
                  Typo.small.copyWith(color: colorScheme.onPrimary, height: 0),
              radius: BorderRadius.circular(LemonRadius.button),
            ),
          ],
        ),
      ],
    );
  }

  _onPressEditProfile(BuildContext context, User authSession) {
    Vibrate.feedback(FeedbackType.light);
    AutoRouter.of(context).navigate(const EditProfileRoute());
  }

  _onPressQRCode(BuildContext context) {
    Vibrate.feedback(FeedbackType.light);
    AutoRouter.of(context).navigate(const QrCodeRoute());
  }

  _onPressQuest(BuildContext context) {
    Vibrate.feedback(FeedbackType.light);
    AutoRouter.of(context).navigate(const QuestRoute());
  }
}
