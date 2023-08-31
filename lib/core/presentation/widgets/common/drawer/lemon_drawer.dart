import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/auth/entities/auth_session.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerItem {
  DrawerItem({
    required this.icon,
    required this.label,
  });

  final SvgGenImage icon;
  final String label;
}

class LemonDrawer extends StatelessWidget {
  const LemonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SafeArea(
      child: Drawer(
        width: 270,
        backgroundColor: colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: DrawerUtils.closeDrawer,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.small,
                  horizontal: Spacing.smMedium,
                ),
                child: Row(
                  children: [
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icBack.svg(colorFilter: filter),
                    )
                  ],
                ),
              ),
            ),
            ...[
              DrawerItem(icon: Assets.icons.icPeopleAlt, label: t.common.community),
              DrawerItem(icon: Assets.icons.icTicket, label: t.common.ticket(n: 2)),
              DrawerItem(icon: Assets.icons.icInsights, label: t.common.dashboard),
              DrawerItem(icon: Assets.icons.icQr, label: t.common.qrCode),
            ].map((item) => _buildDrawerItem(context, item: item)),
            SizedBox(height: Spacing.xSmall),
            Divider(color: colorScheme.outline, height: 2),
            SizedBox(height: Spacing.xSmall),
            _buildDrawerItem(
              context,
              item: DrawerItem(icon: Assets.icons.icSupport, label: t.common.support),
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
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
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
            ),
          ),
          SizedBox(width: Spacing.small),
          Text(
            StringUtils.capitalize(item.label),
            style: Typo.medium.copyWith(color: colorScheme.onSurface),
          )
        ],
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

  Widget authedUser(BuildContext context, AuthSession authSession) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.small,
        horizontal: Spacing.smMedium,
      ),
      child: Row(
        children: [
          LemonCircleAvatar(
            url: authSession.userAvatar ?? '',
            size: 42,
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            children: [
              Text(authSession.userDisplayName ?? ''),
              Text(
                '@${authSession.username ?? ''}',
                style: Typo.small.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
          const Spacer(),
          FloatingFrostedGlassDropdown(
            items: [
              DropdownItemDpo(
                label: t.auth.logout,
              ),
            ],
            onItemPressed: (item) {
              context.read<AuthBloc>().add(const AuthEvent.logout());
            },
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icMoreHoriz.svg(colorFilter: filter),
            ),
          ),
        ],
      ),
    );
  }
}
