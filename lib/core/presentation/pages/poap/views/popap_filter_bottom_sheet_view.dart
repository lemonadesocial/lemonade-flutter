import 'dart:math';

import 'package:app/core/application/badge/badge_collections_bloc/badge_collections_bloc.dart';
import 'package:app/core/application/badge/badge_location_listing_bloc/badge_locations_listing_bloc.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_filled_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/searchbar/lemon_search_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/slider/lemon_slider_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_collection_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/badge/badge_service.dart';
import 'package:app/core/utils/animation_utils.dart';
import 'package:app/core/utils/location_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapFilterBottomSheetView extends StatefulWidget {
  const PoapFilterBottomSheetView({
    super.key,
    required this.dragController,
    required this.snapSizes,
  });
  final DraggableScrollableController dragController;
  final List<double> snapSizes;

  @override
  State<PoapFilterBottomSheetView> createState() =>
      _PoapFilterBottomSheetViewState();
}

class _PoapFilterBottomSheetViewState extends State<PoapFilterBottomSheetView>
    with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );
  late final animation =
      Tween<double>(begin: 0, end: 1).animate(animationController);

  final Duration _animationDuration = const Duration(milliseconds: 300);

  final double _searchBarHeight = 42.w;

  final double _poapCreatorItemWidth = 78.w;

  List<double> get snapSizes => widget.snapSizes; //const [.2, .8, 1];

  bool get _visibleWhenExpanded => animation.value > 0.4;

  @override
  void initState() {
    super.initState();
    widget.dragController.addListener(_onSnap);
  }

  @override
  void dispose() {
    widget.dragController.removeListener(_onSnap);
    super.dispose();
  }

  _onSnap() {
    final interpolatedValue = AnimationUtils.interpolate(
      value: widget.dragController.size,
      low1: snapSizes[0],
      high1: snapSizes[1],
      low2: 0,
      high2: 1,
    );
    animationController.animateTo(interpolatedValue);
  }

  Offset _calculateGridRowOffset({
    required int index,
    required double maxWidth,
  }) {
    final x = index * (maxWidth - (animation.value * maxWidth));
    final y = -((index + 1) * (1 - animation.value) * 50);

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: LemonSnapBottomSheet(
        resizeToAvoidBottomInset: false,
        controller: widget.dragController,
        minSnapSize: snapSizes[0],
        maxSnapSize: snapSizes[2],
        snapSizes: snapSizes,
        defaultSnapSize: snapSizes[0],
        builder: (scrollController) {
          return Expanded(
            child: Stack(
              children: [
                CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                      sliver: AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return SliverVisibility(
                            visible: _visibleWhenExpanded,
                            replacementSliver: _buildSearchBarReplacement(),
                            sliver: _buildSearchBar(),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: Spacing.xSmall),
                    ),
                    AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) => SliverVisibility(
                        visible: _visibleWhenExpanded,
                        replacementSliver: _buildHorizontalList(),
                        sliver: _buildGridList(),
                      ),
                    ),
                  ],
                ),
                _buildLocationFilter(context)
              ],
            ),
          );
        },
      ),
    );
  }

  TweenAnimationBuilder<double> _buildSearchBarReplacement() {
    return TweenAnimationBuilder(
      duration: _animationDuration,
      tween: Tween<double>(begin: _searchBarHeight, end: 0),
      builder: (context, value, child) => SliverToBoxAdapter(
        child: SizedBox(height: value),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: AnimatedOpacity(
        opacity: animation.value,
        duration: _animationDuration,
        child: Transform.translate(
          offset: Offset(0, (1 - animation.value) * _searchBarHeight),
          child: SizedBox(
            height: animation.value * _searchBarHeight,
            child: const LemonSearchBar(),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHorizontalList() {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(maxHeight: 150.w),
            child: BlocBuilder<BadgeCollectionsBloc, BadgeCollectionsState>(
              builder: (context, state) => state.when(
                initial: () => SafeArea(
                  child: Center(
                    child: Loading.defaultLoading(context),
                  ),
                ),
                fetched: (collections, selectedCollections) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: Spacing.extraSmall),
                    scrollDirection: Axis.horizontal,
                    itemCount: collections.length,
                    itemBuilder: (context, i) {
                      final collection = collections[i];
                      final selected = selectedCollections
                          .any((element) => element.id == collection.id);
                      return PoapCollectionItem(
                        badgeCollection: collections[i],
                        selected: selected,
                        onTap: (collection) {
                          final selected = selectedCollections
                              .any((element) => element.id == collection.id);
                          if (selected) {
                            context.read<BadgeCollectionsBloc>().add(
                                  BadgeCollectionsEvent.deselect(
                                    collection: collection,
                                  ),
                                );
                          } else {
                            context.read<BadgeCollectionsBloc>().add(
                                  BadgeCollectionsEvent.select(
                                    collection: collection,
                                  ),
                                );
                          }
                        },
                      );
                    },
                  );
                },
                failure: SizedBox.shrink,
              ),
            ),
          );
        },
      ),
    );
  }

  SliverPadding _buildGridList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      sliver: BlocBuilder<BadgeCollectionsBloc, BadgeCollectionsState>(
        builder: (context, state) => state.when(
          initial: () => SliverToBoxAdapter(
            child: Loading.defaultLoading(context),
          ),
          failure: SliverToBoxAdapter.new,
          fetched: (collections, selectedCollections) {
            return SliverLayoutBuilder(
              builder: (context, constraints) {
                var maxWidth = constraints.crossAxisExtent;
                final fourItemInRowWidth =
                    _poapCreatorItemWidth * 4 + (4 * Spacing.small);
                final isLargeDevice = maxWidth >= 500;
                if (isLargeDevice) {
                  maxWidth = min(maxWidth, fourItemInRowWidth);
                }
                final numOfItems = AnimationUtils.calculateMaxItemsInRow(
                  rowWidth: maxWidth.w - 2 * Spacing.smMedium,
                  itemWidth: _poapCreatorItemWidth,
                  separatorWidth: Spacing.small,
                );
                final chunkListResult = AnimationUtils.chunkList(
                  list: collections,
                  chunkSize: numOfItems,
                );
                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeDevice ? fourItemInRowWidth / 4 : 0,
                  ),
                  sliver: SliverList.separated(
                    separatorBuilder: (context, item) =>
                        SizedBox(height: Spacing.xSmall),
                    itemCount: chunkListResult.length + 1,
                    itemBuilder: (context, index) {
                      // Render bottom space for list
                      if (index == chunkListResult.length) {
                        return Container(
                          height: 220.w,
                          color: Colors.transparent,
                        );
                      }
                      var chunkPortion = chunkListResult[index];
                      final isNotFullRow = chunkPortion.length < numOfItems;
                      if (isNotFullRow && !isLargeDevice) {
                        chunkPortion = [
                          ...chunkPortion,
                          ...List.filled(
                            numOfItems - chunkPortion.length,
                            BadgeList.empty(),
                          ),
                        ];
                      }
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) => Transform.translate(
                          offset: index == 0
                              ? Offset.zero
                              : _calculateGridRowOffset(
                                  index: index,
                                  maxWidth: maxWidth,
                                ),
                          child: child,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List<BadgeList>.from(chunkPortion).map(
                            (collection) {
                              final selected = selectedCollections.any(
                                (element) => element.id == collection.id,
                              );
                              return Container(
                                margin: EdgeInsets.only(
                                  right: isLargeDevice ? Spacing.extraSmall : 0,
                                ),
                                child: PoapCollectionItem(
                                  badgeCollection: collection,
                                  selected: selected,
                                  visible: collection.id != null &&
                                      collection.id!.isNotEmpty,
                                  onTap: (collection) {
                                    if (selected) {
                                      context.read<BadgeCollectionsBloc>().add(
                                            BadgeCollectionsEvent.deselect(
                                              collection: collection,
                                            ),
                                          );
                                    } else {
                                      context.read<BadgeCollectionsBloc>().add(
                                            BadgeCollectionsEvent.select(
                                              collection: collection,
                                            ),
                                          );
                                    }
                                  },
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  AnimatedBuilder _buildLocationFilter(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: LocationFilter(),
      ),
      builder: (context, child) => Transform.translate(
        offset: Offset(
          0,
          (1 - animation.value) * 200,
        ),
        child: child,
      ),
    );
  }
}

class LocationFilter extends StatelessWidget {
  const LocationFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      color: colorScheme.secondary,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: colorScheme.outline, height: 1),
            SizedBox(height: Spacing.medium),
            SizedBox(
              height: Sizing.medium,
              child: BlocBuilder<BadgeLocationsListingBloc,
                  BadgeLocationsListingState>(
                builder: (context, state) => state.when(
                  initial: (_, __) => Loading.defaultLoading(context),
                  failure: () => const Center(child: Text('error')),
                  fetched: (locations, selectedLocation, _) {
                    return ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var isSelected = false;
                        if (index == 0) {
                          isSelected = selectedLocation?.isMyLocation != null &&
                              selectedLocation!.isMyLocation == true;
                          return isSelected
                              ? LemonFilledButton(
                                  onTap: () {
                                    context
                                        .read<BadgeLocationsListingBloc>()
                                        .add(
                                          BadgeLocationsListingEvent.select(),
                                        );
                                  },
                                  leading: ThemeSvgIcon(
                                    color: isSelected
                                        ? colorScheme.primary
                                        : colorScheme.onSecondary,
                                    builder: (filter) => Assets
                                        .icons.icMyLocation
                                        .svg(colorFilter: filter),
                                  ),
                                  label: t.common.nearMe,
                                )
                              : LemonOutlineButton(
                                  onTap: () async {
                                    try {
                                      final isGranted = await LocationUtils
                                          .requestLocationPermissionWithPopup(
                                        context,
                                        shouldGoToSettings: true,
                                      );
                                      if (!isGranted) return;
                                      final position =
                                          await getIt<LocationUtils>()
                                              .getCurrentLocation(
                                        onPermissionDeniedForever: () {
                                          LocationUtils.goToSetting(context);
                                        },
                                      );
                                      context
                                          .read<BadgeLocationsListingBloc>()
                                          .add(
                                            BadgeLocationsListingEvent.select(
                                              location:
                                                  BadgeLocation.myLocation(
                                                geoPoint: GeoPoint(
                                                  lat: position.latitude,
                                                  lng: position.longitude,
                                                ),
                                              ),
                                            ),
                                          );
                                    } catch (error) {
                                      if (kDebugMode) {
                                        print(error);
                                      }
                                    }
                                  },
                                  leading: ThemeSvgIcon(
                                    color: colorScheme.onSecondary,
                                    builder: (filter) => Assets
                                        .icons.icMyLocation
                                        .svg(colorFilter: filter),
                                  ),
                                  label: t.common.nearMe,
                                );
                        }
                        final location = locations[index - 1];
                        isSelected = selectedLocation?.badgeCity?.city ==
                            location.badgeCity?.city;
                        return isSelected
                            ? LemonFilledButton(
                                onTap: () {
                                  context.read<BadgeLocationsListingBloc>().add(
                                        BadgeLocationsListingEvent.select(),
                                      );
                                },
                                label: location.badgeCity?.city ??
                                    location.badgeCity?.country,
                              )
                            : LemonOutlineButton(
                                onTap: () {
                                  context.read<BadgeLocationsListingBloc>().add(
                                        BadgeLocationsListingEvent.select(
                                          location: location,
                                        ),
                                      );
                                },
                                label: location.badgeCity?.city ??
                                    location.badgeCity?.country,
                              );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: Spacing.superExtraSmall,
                      ),
                      itemCount: locations.length + 1,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: Spacing.medium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.common.maximumDistance,
                        style:
                            Typo.medium.copyWith(color: colorScheme.onSurface),
                      ),
                      BlocBuilder<BadgeLocationsListingBloc,
                          BadgeLocationsListingState>(
                        builder: (context, state) => Text(
                          state.maybeWhen(
                            fetched: (_, __, distance) => '${distance.toInt()}',
                            orElse: () => '1',
                          ),
                          style: Typo.medium
                              .copyWith(color: colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  LemonSlider(
                    min: 1,
                    max: 100,
                    onChange: (value) {
                      context.read<BadgeLocationsListingBloc>().add(
                            BadgeLocationsListingEvent.updateDistance(
                              distance: value,
                            ),
                          );
                    },
                    defaultValue: getIt<BadgeService>().distance,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1${t.common.unit.km}',
                        style: Typo.small
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                      Text(
                        '100${t.common.unit.km}',
                        style: Typo.small
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 2 * Spacing.medium),
          ],
        ),
      ),
    );
  }
}
