import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/space/spaces_listing_page/widgets/space_list_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/space/featured_space_item.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeListMySpaces extends StatelessWidget {
  const HomeListMySpaces({
    super.key,
    required this.mySpacesBloc,
    required this.ambassadorSpacesBloc,
    required this.subscribedSpacesBloc,
  });

  final ListSpacesBloc mySpacesBloc;
  final ListSpacesBloc ambassadorSpacesBloc;
  final ListSpacesBloc subscribedSpacesBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListSpacesBloc>.value(value: mySpacesBloc),
        BlocProvider<ListSpacesBloc>.value(value: ambassadorSpacesBloc),
        BlocProvider<ListSpacesBloc>.value(value: subscribedSpacesBloc),
      ],
      child: SpaceListingView(
        mySpacesBloc: mySpacesBloc,
        ambassadorSpacesBloc: ambassadorSpacesBloc,
        subscribedSpacesBloc: subscribedSpacesBloc,
      ),
    );
  }
}

class SpaceListingView extends StatelessWidget {
  final ListSpacesBloc mySpacesBloc;
  final ListSpacesBloc ambassadorSpacesBloc;
  final ListSpacesBloc subscribedSpacesBloc;

  const SpaceListingView({
    super.key,
    required this.mySpacesBloc,
    required this.ambassadorSpacesBloc,
    required this.subscribedSpacesBloc,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = Theme.of(context).appColors;
    final appTextTheme = Theme.of(context).appTextTheme;

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.s4,
            ),
            child: Text(
              t.space.myCommunities,
              style: appTextTheme.lg.copyWith(
                fontWeight: FontWeight.w600,
                color: appColors.textPrimary,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.s4)),
        BlocBuilder<ListSpacesBloc, ListSpacesState>(
          bloc: mySpacesBloc,
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              loading: () => SliverToBoxAdapter(
                child: Center(child: Loading.defaultLoading(context)),
              ),
              failure: (failure) => SliverToBoxAdapter(
                child: EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
              ),
              success: (spaces) => SliverToBoxAdapter(
                child: SizedBox(
                  height: 132.w,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
                    scrollDirection: Axis.horizontal,
                    itemCount: spaces.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(width: Spacing.s3),
                    itemBuilder: (context, index) {
                      final space = spaces[index];
                      return FeaturedSpaceItem(
                        space: space,
                        width: 132.w,
                        height: 132.w,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.s5)),
        SliverToBoxAdapter(
          child: Divider(
            color: appColors.pageDividerInverse,
            thickness: Spacing.s1_5,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.s5)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.s4,
            ),
            child: Text(
              t.space.subscribedCommunities,
              style: appTextTheme.lg.copyWith(
                fontWeight: FontWeight.w600,
                color: appColors.textPrimary,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.s4,
          ),
        ),
        BlocBuilder<ListSpacesBloc, ListSpacesState>(
          bloc: subscribedSpacesBloc,
          builder: (context, state) {
            return state.maybeWhen(
              initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              loading: () => SliverToBoxAdapter(
                child: Center(child: Loading.defaultLoading(context)),
              ),
              success: (spaces) {
                return _SpacesList(
                  spaces: spaces,
                  emptyTitle: t.space.noSubscribedCommunities,
                  emptyDescription: t.space.noSubscribedCommunitiesDescription,
                  layout: SpaceListItemLayout.list,
                );
              },
              failure: (failure) => SliverToBoxAdapter(
                child: EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
              ),
              orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            );
          },
        ),

        // Bottom padding
        SliverToBoxAdapter(
          child: SizedBox(height: 40.w),
        ),
      ],
    );
  }
}

class _SpacesList extends StatelessWidget {
  final List<Space> spaces;
  final String? emptyTitle;
  final String? emptyDescription;
  final SpaceListItemLayout layout;
  const _SpacesList({
    required this.spaces,
    this.emptyTitle,
    this.emptyDescription,
    this.layout = SpaceListItemLayout.list,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = Theme.of(context).appColors;
    if (spaces.isEmpty) {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
        sliver: SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: appColors.cardBg,
              borderRadius: BorderRadius.circular(
                LemonRadius.small,
              ),
              border: Border.all(
                color: appColors.cardBorder,
              ),
            ),
            child: Row(
              children: [
                Assets.icons.icGiftOpen.svg(
                  width: 40.w,
                  height: 40.w,
                ),
                SizedBox(width: Spacing.s4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        emptyTitle ?? '',
                        style:
                            Typo.medium.copyWith(color: colorScheme.onPrimary),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        emptyDescription ?? '',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                          letterSpacing: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (layout == SpaceListItemLayout.grid) {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
        sliver: SliverGrid.builder(
          itemCount: spaces.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Spacing.small,
            mainAxisSpacing: Spacing.small,
            childAspectRatio: (180 / 118),
          ),
          itemBuilder: (context, index) {
            final space = spaces[index];
            return SpaceListItem(
              space: space,
              onTap: () => context.router.navigate(
                SpaceDetailRoute(
                  spaceId: space.id!,
                ),
              ),
              layout: layout,
            );
          },
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.s4),
      sliver: SliverList.separated(
        itemCount: spaces.length,
        itemBuilder: (context, index) {
          final space = spaces[index];
          return SpaceListItem(
            space: space,
            onTap: () => context.router.navigate(
              SpaceDetailRoute(
                spaceId: space.id!,
              ),
            ),
            layout: layout,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: Spacing.s3),
      ),
    );
  }
}
