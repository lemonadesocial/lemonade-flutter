import 'package:app/core/presentation/guard/auth_guard.dart';
import 'package:app/core/presentation/pages/auth/login_page.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_tabbar_delegate_widget.dart';
import 'package:app/core/presentation/pages/profile/widgets/tabs/profile_photos_tab_view.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      unauthenticatedBuilder: (context) => const LoginPage(),
      authenticatedBuilder: (context) => const ProfilePageView(),
    );
  }
}

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(title: '@coop.er', leading: BurgerMenu(), actions: [
            ThemeSvgIcon(
                color: colorScheme.onSurface, builder: (filter) => Assets.icons.icShare.svg(colorFilter: filter)),
            ThemeSvgIcon(
                color: colorScheme.onSurface, builder: (filter) => Assets.icons.icMoreHoriz.svg(colorFilter: filter)),
          ]),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverAppBar(
                        expandedHeight: 242,
                        collapsedHeight: 242,
                        floating: true,
                        pinned: false,
                        flexibleSpace: _header(colorScheme),
                        forceElevated: innerBoxIsScrolled,
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: false,
                      delegate: ProfileTabBarDelegate()
                    ),
                  ],
              body: TabBarView(
                children: [1, 2, 3, 4, 5, 6]
                    .map(
                      (item) => ProfilePhotosTabView(),
                    )
                    .toList(),
              )),
        ));
  }

  Column _header(ColorScheme colorScheme) {
    return Column(
      children: [
        SizedBox(height: Spacing.xSmall),
        _userAvatarAndFollows(colorScheme),
        SizedBox(height: Spacing.xSmall),
        _userNameAndTitle(colorScheme),
        SizedBox(height: Spacing.medium),
        _buttons(colorScheme),
        SizedBox(height: Spacing.medium),
      ],
    );
  }

  Widget _userAvatarAndFollows(ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          LemonCircleAvatar(
            url: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
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
                    Text('Following', style: Typo.medium.copyWith(color: colorScheme.onSecondary)),
                  ],
                ),
                Column(
                  children: [
                    Text('786', style: Typo.extraMedium),
                    Text('Followers', style: Typo.medium.copyWith(color: colorScheme.onSecondary)),
                  ],
                ),
                Column(
                  children: [
                    Text('273', style: Typo.extraMedium),
                    Text('Friends', style: Typo.medium.copyWith(color: colorScheme.onSecondary)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _userNameAndTitle(ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Cooper Torff', style: Typo.large),
              SizedBox(width: Spacing.extraSmall),
              Assets.icons.icBadge.svg(colorFilter: ColorFilter.mode(LemonColor.lavender, BlendMode.srcIn)),
            ],
          ),
          Text('Product manager, Meta', style: Typo.medium.copyWith(color: colorScheme.onSecondary))
        ],
      ),
    );
  }

  Widget _buttons(ColorScheme colorScheme) {
    final onSurfaceColor = colorScheme.onSurface;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          LemonButton(
              label: "edit",
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icEdit.svg(colorFilter: filter),
              )),
          LemonButton(
              label: "tickets",
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icTicket.svg(colorFilter: filter),
              )),
          LemonButton(
              label: "connect",
              icon: ThemeSvgIcon(
                color: onSurfaceColor,
                builder: (filter) => Assets.icons.icWallet.svg(colorFilter: filter),
              ))
        ],
      ),
    );
  }
}

