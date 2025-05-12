import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/space/spaces_listing_page/widgets/space_list_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
            ),
            child: Text(
              t.space.myCommunities.toUpperCase(),
              style: Typo.small.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.small)),
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
              success: (spaces) => _SpacesList(
                spaces: spaces,
                layout: SpaceListItemLayout.grid,
              ),
            );
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.large)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
            ),
            child: Text(
              t.space.ambassadorCommunities.toUpperCase(),
              style: Typo.small.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.small)),
        BlocBuilder<ListSpacesBloc, ListSpacesState>(
          bloc: ambassadorSpacesBloc,
          builder: (context, state) {
            return state.maybeWhen(
              initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              failure: (failure) => SliverToBoxAdapter(
                child: EmptyList(
                  emptyText: t.common.somethingWrong,
                ),
              ),
              loading: () => SliverToBoxAdapter(
                child: Center(child: Loading.defaultLoading(context)),
              ),
              success: (spaces) => _SpacesList(
                spaces: spaces,
                emptyTitle: t.space.noAmbassadorCommunities,
                emptyDescription: t.space.noAmbassadorCommunitiesDescription,
              ),
            );
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: Spacing.large)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
            ),
            child: Text(
              t.space.subscribedCommunities.toUpperCase(),
              style: Typo.small.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.small,
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
    if (spaces.isEmpty) {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        sliver: SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(
                LemonRadius.small,
              ),
              border: Border.all(
                color: colorScheme.outline,
              ),
            ),
            child: Row(
              children: [
                Assets.icons.icGiftOpen.svg(),
                SizedBox(width: Spacing.small),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        emptyTitle ?? '',
                        style: Typo.mediumPlus
                            .copyWith(color: colorScheme.onPrimary),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        emptyDescription ?? '',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
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
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
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
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
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
        separatorBuilder: (context, index) => SizedBox(height: Spacing.xSmall),
      ),
    );
  }
}
