import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_featured_spaces_view/discover_featured_spaces_view.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_space_categories_view/discover_space_categories_view.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_collaborators.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  final refreshController = RefreshController();
  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final newsfeedListingBloc = context.read<NewsfeedListingBloc>();

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: HomeAppBar(title: t.discover.discover),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        onRefresh: () {
          newsfeedListingBloc.add(NewsfeedListingEvent.refresh());
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
            const SliverToBoxAdapter(
              child: HomeCollaborators(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 30.w),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              sliver: const DiscoverSpaceCategoriesView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.medium),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              sliver: const DiscoverFeaturedSpacesView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: Spacing.xLarge * 4),
            ),
            // TODO: temporary hide
            // SliverPadding(
            //   padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            //   sliver: const DiscoverSpacesByLocationsView(),
            // ),
            // const DiscoverPosts(),
          ],
        ),
      ),
    );
  }
}
