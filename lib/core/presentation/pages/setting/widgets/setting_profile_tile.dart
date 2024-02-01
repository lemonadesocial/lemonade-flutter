import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/config.dart';
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
import 'package:share_plus/share_plus.dart';

class SettingProfileTile extends StatelessWidget {
  const SettingProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authSession = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        border: Border.all(
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LemonCircleAvatar(
            url: authSession!.imageAvatar ?? '',
            size: 42.r,
          ),
          SizedBox(width: Spacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(authSession.displayName ?? ''),
                Text(
                  '@${authSession.username ?? ''}',
                  style: Typo.small.copyWith(color: colorScheme.onSecondary),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.small),
          FloatingFrostedGlassDropdown(
            items: [
              DropdownItemDpo(
                label: t.common.actions.editProfile,
                leadingIcon: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icEdit.svg(
                    colorFilter: filter,
                    width: 15.w,
                    height: 15.w,
                  ),
                ),
              ),
              DropdownItemDpo(
                label: t.common.actions.shareProfile,
                leadingIcon: Assets.icons.icShare.svg(
                  width: 15.w,
                  height: 15.w,
                ),
              ),
            ],
            onItemPressed: (item) async {
              if (item?.label == t.common.actions.editProfile) {
                context.router.push(EditProfileRoute(userProfile: authSession));
              }
              if (item?.label == t.common.actions.shareProfile) {
                try {
                  final box = context.findRenderObject() as RenderBox?;
                  await Share.share(
                    '${AppConfig.webUrl}/${authSession.username}',
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size,
                  );
                } catch (e) {
                  if (kDebugMode) {
                    print("Error _shareProfileLink $e");
                  }
                }
              }
            },
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) =>
                  Assets.icons.icMoreHoriz.svg(colorFilter: filter),
            ),
          ),
        ],
      ),
    );
  }
}
