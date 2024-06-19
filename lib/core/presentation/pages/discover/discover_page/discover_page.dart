import 'package:app/core/presentation/pages/discover/discover_page/views/discover_badges_near_you.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_cards.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_communities.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_farcaster_channels.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_upcoming_events.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: HomeAppBar(title: t.discover.discover),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            sliver: const DiscoverCards(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const DiscoverFarcasterChannels(),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const DiscoverCommunities(),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const DiscoverBadgesNearYou(),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const DiscoverUpcomingEvents(),
          SliverToBoxAdapter(
            child: SizedBox(height: 3 * BottomBar.bottomBarHeight),
          ),
        ],
      ),
    );
  }
}
