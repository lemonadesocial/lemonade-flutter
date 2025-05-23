// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_featured_spaces_view/discover_featured_spaces_view.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_space_categories_view/discover_space_categories_view.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  // final refreshController = RefreshController();
  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final t = Translations.of(context);
    // final newsfeedListingBloc = context.read<NewsfeedListingBloc>();

    return Scaffold(
      backgroundColor: appColors.pageBg,
      appBar: HomeAppBar(
        title: t.discover.discover,
        backgroundColor: appColors.pageBg,
      ),
      body: CustomScrollView(
        // controller: newsfeedListingBloc.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: Spacing.s2),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: Spacing.s4,
              right: Spacing.s4,
              bottom: Spacing.s4,
            ),
            sliver: const DiscoverSpaceCategoriesView(),
          ),
          SliverToBoxAdapter(
            child: Divider(
              color: appColors.pageDividerInverse,
              thickness: Spacing.s1_5,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: Spacing.s5,
              left: Spacing.s4,
              right: Spacing.s4,
            ),
            sliver: const DiscoverFeaturedSpacesView(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: Spacing.s10 * 3),
          ),
          // TODO: temporary hide
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(horizontal: Spacing.small),
          //   sliver: const DiscoverSpacesByLocationsView(),
          // ),
          // const DiscoverPosts(),
        ],
      ),
    );
  }
}
