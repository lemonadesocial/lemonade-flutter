import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/space_categories_card.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_posts.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/featured_spaces.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  final refreshController = RefreshController();
  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListSpacesBloc(
        spaceRepository: getIt<SpaceRepository>(),
      )..add(const ListSpacesEvent.fetch(featured: true)),
      child: _DiscoverPageView(refreshController: refreshController),
    );
  }
}

class _DiscoverPageView extends StatelessWidget {
  final RefreshController refreshController;

  const _DiscoverPageView({
    required this.refreshController,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final newsfeedListingBloc = context.read<NewsfeedListingBloc>();
    final featuredSpacesBloc = context.read<ListSpacesBloc>();

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: HomeAppBar(title: t.discover.discover),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () {
          newsfeedListingBloc.add(NewsfeedListingEvent.refresh());
          featuredSpacesBloc.add(const ListSpacesEvent.fetch(featured: true));
          refreshController.refreshCompleted();
        },
        onLoading: () {
          newsfeedListingBloc.add(NewsfeedListingEvent.fetch());
          refreshController.loadComplete();
        },
        footer: const ClassicFooter(
          height: 100,
          loadStyle: LoadStyle.ShowWhenLoading,
        ),
        child: CustomScrollView(
          controller: newsfeedListingBloc.scrollController,
          slivers: [
            // TODO: Airstack no more support farcaster
            // const DiscoverFarcasterChannels(),
            // SliverPadding(
            //   padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
            // ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              sliver: const SpaceCategoriesCard(),
            ),
            SliverToBoxAdapter(child: SizedBox(height: Spacing.medium)),
            const FeaturedSpaces(),
            const DiscoverPosts(),
          ],
        ),
      ),
    );
  }
}
