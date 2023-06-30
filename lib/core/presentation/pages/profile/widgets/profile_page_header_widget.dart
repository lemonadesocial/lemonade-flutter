import 'package:app/core/presentation/widgets/lemon_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class ProfilePageHeader extends StatelessWidget {
  const ProfilePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Spacing.xSmall),
        _ProfileAvatarAndFollow(),
        SizedBox(height: Spacing.xSmall),
        _ProfileUserNameAndTitle(),
        SizedBox(height: Spacing.medium),
        _ActionButtons(),
        Container(height: Spacing.xSmall)
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          LemonButton(
              label: t.common.actions.edit,
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icEdit.svg(colorFilter: filter),
              )),
          LemonButton(
              label: t.common.ticket(n: 0),
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icTicket.svg(colorFilter: filter),
              )),
          LemonButton(
              label: t.common.actions.connect,
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icWallet.svg(colorFilter: filter),
              ))
        ],
      ),
    );
  }
}

class _ProfileAvatarAndFollow extends StatelessWidget {
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
            url:
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
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
                    Text('2,543', style: Typo.extraMedium),
                    Text(
                      StringUtils.capitalize(t.common.following),
                      style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('786', style: Typo.extraMedium),
                    Text(
                      StringUtils.capitalize(t.common.follower(n: 786)),
                      style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('273', style: Typo.extraMedium),
                    Text(
                      StringUtils.capitalize(t.common.friends(n: 273)),
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
              Text('Cooper Torff', style: Typo.large),
              SizedBox(width: Spacing.extraSmall),
              Assets.icons.icBadge.svg(
                colorFilter: ColorFilter.mode(LemonColor.lavender, BlendMode.srcIn),
              ),
            ],
          ),
          Text(
            'Product manager, Meta',
            style: Typo.medium.copyWith(color: colorScheme.onSecondary),
          )
        ],
      ),
    );
  }
}
