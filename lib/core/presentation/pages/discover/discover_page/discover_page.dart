import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_badges_near_you.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_cards.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_communities.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_upcoming_events.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: LemonAppBar(
        title: t.discover.discover,
        leading: InkWell(
          onTap: () => DrawerUtils.openDrawer(),
          child: Icon(
            Icons.menu_outlined,
            color: colorScheme.onPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.xSmall),
            child: InkWell(
              onTap: () {
                context.read<AuthBloc>().state.maybeWhen(
                      authenticated: (session) => AutoRouter.of(context)
                          .navigate(const ChatListRoute()),
                      orElse: () =>
                          AutoRouter.of(context).navigate(const LoginRoute()),
                    );
              },
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            sliver: const DiscoverCards(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const DiscoverCommunities(),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const DiscoverBadgesNearYou(),
          const DiscoverUpcomingEvents(),
          SliverToBoxAdapter(
            child: SizedBox(height: 2 * BottomBar.bottomBarHeight),
          ),
        ],
      ),
    );
  }
}
