import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/wallet/connect_wallet_profile_button.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class ProfilePageHeader extends StatelessWidget {
  final User user;
  const ProfilePageHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Spacing.xSmall),
        _ProfileAvatarAndFollow(user: user),
        SizedBox(height: Spacing.xSmall),
        _ProfileUserNameAndTitle(user: user),
        SizedBox(height: Spacing.medium),
        _ActionButtons(user: user),
        Container(height: Spacing.xSmall)
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final User user;

  _ActionButtons({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: LemonButton(
              label: t.common.actions.edit,
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icEdit.svg(colorFilter: filter),
              ),
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          Expanded(
            child: LemonButton(
              label: t.common.ticket(n: 0),
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icTicket.svg(colorFilter: filter),
              ),
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          Expanded(
            child: ConnectWalletProfileButton(user: user),
          ),
          SizedBox(width: Spacing.superExtraSmall),
        ],
      ),
    );
  }
}

class _ProfileAvatarAndFollow extends StatelessWidget {
  final User user;
  _ProfileAvatarAndFollow({required this.user});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          LemonCircleAvatar(
            url: user.imageAvatar ?? '',
            size: 80,
          ),
          SizedBox(width: Spacing.medium * 1.5),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      NumberUtils.formatCompact(amount: user.following),
                      style: Typo.extraMedium,
                    ),
                    Text(
                      StringUtils.capitalize(t.common.following),
                      style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      NumberUtils.formatCompact(amount: user.followers),
                      style: Typo.extraMedium,
                    ),
                    Text(
                      StringUtils.capitalize(t.common.follower(n: user.followers ?? 0)),
                      style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      NumberUtils.formatCompact(amount: user.friends),
                      style: Typo.extraMedium,
                    ),
                    Text(
                      StringUtils.capitalize(t.common.friends(n: user.friends ?? 0)),
                      style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ProfileUserNameAndTitle extends StatelessWidget {
  final User user;
  _ProfileUserNameAndTitle({
    required this.user,
  });

  String? get displayName {
    return user.displayName ?? user.username ?? null;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(displayName ?? t.common.anonymous, style: Typo.large),
              SizedBox(width: Spacing.extraSmall),
              Assets.icons.icBadge.svg(
                colorFilter: ColorFilter.mode(LemonColor.lavender, BlendMode.srcIn),
              ),
            ],
          ),
          Text(
            user.jobTitle ?? user.tagline ?? '...',
            style: Typo.medium.copyWith(color: colorScheme.onSecondary),
          )
        ],
      ),
    );
  }
}
