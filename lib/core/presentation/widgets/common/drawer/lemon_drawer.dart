import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItem {
  DrawerItem({
    required this.icon,
    required this.label,
    this.featureAvailable = true,
  });

  final SvgGenImage icon;
  final String label;
  final bool featureAvailable;
}

class LemonDrawer extends StatelessWidget {
  const LemonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SafeArea(
      child: Drawer(
        width: 270.w,
        backgroundColor: colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Spacing.superExtraSmall),
            ...[
              DrawerItem(
                icon: Assets.icons.icBank,
                label: t.common.vault,
                featureAvailable: false,
              ),
              DrawerItem(
                icon: Assets.icons.icPeopleAlt,
                label: t.common.community,
              ),
              DrawerItem(
                icon: Assets.icons.icTicket,
                label: t.common.ticket(n: 2),
              ),
              DrawerItem(
                icon: Assets.icons.icInsights,
                label: t.common.dashboard,
                featureAvailable: false,
              ),
              DrawerItem(icon: Assets.icons.icQr, label: t.common.qrCode),
            ].map((item) => _buildDrawerItem(context, item: item)),
            SizedBox(height: Spacing.xSmall),
            Divider(color: colorScheme.outline, height: 2),
            SizedBox(height: Spacing.xSmall),
            _buildDrawerItem(
              context,
              item: DrawerItem(
                icon: Assets.icons.icEdit,
                label: t.profile.editProfile,
              ),
            ),
            SizedBox(height: Spacing.xSmall),
            _buildDrawerItem(
              context,
              item: DrawerItem(
                icon: Assets.icons.icSettings,
                label: t.common.setting,
              ),
            ),
            const Spacer(),
            _buildUser(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required DrawerItem item,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.small,
          horizontal: Spacing.smMedium,
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) => item.icon.svg(
                colorFilter: filter,
                height: 18.w,
                width: 18.w,
              ),
            ),
            SizedBox(width: Spacing.small),
            Text(
              StringUtils.capitalize(item.label),
              style: Typo.medium.copyWith(color: colorScheme.onSurface),
            ),
            if (!item.featureAvailable) ...[
              SizedBox(width: Spacing.small),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.w),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                ),
                child: Text(
                  t.common.comingSoon,
                  style: Typo.extraSmall.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.36),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUser(
    context,
  ) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.when(
          authenticated: (authSession) => authedUser(context, authSession),
          onBoardingRequired: (authSession) => authedUser(context, authSession),
          processing: SizedBox.shrink,
          unknown: SizedBox.shrink,
          unauthenticated: (_) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget authedUser(BuildContext context, User authSession) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.small,
        horizontal: Spacing.smMedium,
      ),
      child: Row(
        children: [
          LemonCircleAvatar(
            url: authSession.imageAvatar ?? '',
            size: 42,
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(authSession.displayName ?? ''),
              Text(
                '@${authSession.username ?? ''}',
                style: Typo.small.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
