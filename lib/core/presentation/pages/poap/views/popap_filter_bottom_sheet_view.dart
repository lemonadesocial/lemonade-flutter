import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/searchbar/lemon_search_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/slider/lemon_slider_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_creator_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/animation_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

List<String> get _mockLocations => ["New york", "California", "Washington"];

class PoapFilterBottomSheetView extends StatefulWidget {
  final DraggableScrollableController dragController;
  final List<double> snapSizes;
  PoapFilterBottomSheetView({
    super.key,
    required this.dragController,
    required this.snapSizes,
  });

  @override
  State<PoapFilterBottomSheetView> createState() => _PoapFilterBottomSheetViewState();
}

class _PoapFilterBottomSheetViewState extends State<PoapFilterBottomSheetView> with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );
  late final animation = Tween<double>(begin: 0, end: 1).animate(animationController);

  Duration _animationDuration = const Duration(milliseconds: 300);

  double _searchBarHeight = 42;

  double _poapCreatorItemWidth = 78;

  List<double> get snapSizes => widget.snapSizes; //const [.2, .8, 1];

  bool get _visibleWhenExpanded => animation.value > 0.4;

  List<int> get _mockPoapList => List.generate(12, (index) => index);

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

  Offset _calculateGridRowOffset({required int index, required double maxWidth}) {
    double x = index * (maxWidth - (animation.value * maxWidth));
    double y = -((index + 1) * (1 - animation.value) * 50);

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: LemonSnapBottomSheet(
        controller: widget.dragController,
        minSnapSize: snapSizes[0],
        maxSnapSize: snapSizes[2],
        snapSizes: snapSizes,
        defaultSnapSize: snapSizes[0],
        builder: (scrollController) {
          return Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
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
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: Spacing.medium),
                      Divider(color: colorScheme.outline),
                      SizedBox(height: Spacing.medium)
                    ],
                  ),
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
          child: Container(
            height: animation.value * _searchBarHeight,
            child: LemonSearchBar(),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHorizontalList() {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: 100,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              separatorBuilder: (context, index) => SizedBox(width: Spacing.extraSmall),
              scrollDirection: Axis.horizontal,
              itemCount: _mockPoapList.length,
              itemBuilder: (context, i) => PoapCreatorItem(),
            ),
          );
        },
      ),
    );
  }

  SliverPadding _buildGridList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.crossAxisExtent;
          final isLargeDevice = maxWidth >= 500;
          final numOfItems = AnimationUtils.calculateMaxItemsInRow(
            rowWidth: maxWidth - 2 * Spacing.smMedium,
            itemWidth: _poapCreatorItemWidth,
            separatorWidth: Spacing.small,
          );
          final chunkListResult = AnimationUtils.chunkList(
            list: _mockPoapList,
            chunkSize: numOfItems,
          );
          return SliverList.separated(
            separatorBuilder: (context, item) => SizedBox(height: Spacing.xSmall),
            itemCount: chunkListResult.length,
            itemBuilder: (context, index) {
              final chunkPortion = chunkListResult[index];
              final isNotFullRow = chunkPortion.length < numOfItems;
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Transform.translate(
                  offset: index == 0 ? Offset(0, 0) : _calculateGridRowOffset(index: index, maxWidth: maxWidth),
                  child: child,
                ),
                child: Row(
                  mainAxisAlignment: isLargeDevice
                      ? MainAxisAlignment.center
                      : isNotFullRow
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceBetween,
                  children: List.from(chunkPortion)
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.only(
                            right: isLargeDevice || isNotFullRow ? Spacing.extraSmall : 0,
                          ),
                          child: PoapCreatorItem(),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _buildLocationFilter(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SliverToBoxAdapter(
          child: AnimatedOpacity(
            opacity: animation.value,
            duration: _animationDuration,
            child: Transform.translate(
              offset: Offset(0, (1 - animation.value) * 500),
              child: child,
            ),
          ),
        );
      },
      child: LocationFilter(),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return LemonOutlineButton(
                    leading: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icMyLocation.svg(colorFilter: filter),
                    ),
                    label: t.common.nearMe,
                  );
                }
                return LemonOutlineButton(
                  label: _mockLocations[index - 1],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: Spacing.superExtraSmall,
              ),
              itemCount: _mockLocations.length + 1,
            ),
          ),
          SizedBox(height: Spacing.medium),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.common.maximumDistance,
                  style: Typo.medium.copyWith(color: colorScheme.onSurface),
                ),
                SizedBox(height: Spacing.superExtraSmall),
                LemonSlider(min: 1, max: 100),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1${t.common.unit.km}',
                      style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    Text(
                      '100${t.common.unit.km}',
                      style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 2 * Spacing.medium),
        ],
      ),
    );
  }
}
