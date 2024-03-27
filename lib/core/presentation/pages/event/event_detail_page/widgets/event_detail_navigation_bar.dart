import 'dart:math';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/helper/event_detail_navigation_bar_helper.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/utils/animation_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<double> _snapSizes = [.16, .5];

class EventDetailNavigationBar extends StatefulWidget {
  final Event event;
  const EventDetailNavigationBar({super.key, required this.event});

  @override
  State<EventDetailNavigationBar> createState() =>
      _EventDetailNavigationBarState();
}

class _EventDetailNavigationBarState extends State<EventDetailNavigationBar>
    with TickerProviderStateMixin {
  final DraggableScrollableController dragController =
      DraggableScrollableController();
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );
  late final animation =
      Tween<double>(begin: 0, end: 1).animate(animationController);

  final Duration _animationDuration = const Duration(milliseconds: 300);

  final double _cardItemWidth = 75.w;

  List<double> get snapSizes => _snapSizes;

  bool get _visibleWhenExpanded => animation.value > 0.4;

  @override
  void initState() {
    super.initState();
    dragController.addListener(_onSnap);
  }

  @override
  void dispose() {
    dragController.removeListener(_onSnap);
    super.dispose();
  }

  _onSnap() {
    final interpolatedValue = AnimationUtils.interpolate(
      value: dragController.size,
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
        controller: dragController,
        minSnapSize: snapSizes[0],
        maxSnapSize: snapSizes[1],
        snapSizes: snapSizes,
        defaultSnapSize: snapSizes[0],
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(33, 33, 33, 1),
              Color.fromRGBO(23, 23, 23, 1),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(LemonRadius.normal),
            topRight: Radius.circular(LemonRadius.normal),
          ),
        ),
        builder: (scrollController) {
          return Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.extraSmall,
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter _buildHorizontalList() {
    late List features = [];
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );
    final isCohost = EventUtils.isCohost(event: widget.event, userId: userId);
    final isAttending =
        EventUtils.isAttending(event: widget.event, userId: userId);
    final isOwnEvent =
        EventUtils.isOwnEvent(event: widget.event, userId: userId);
    if (isOwnEvent || isCohost) {
      features = EventDetailNavigationBarHelper.getEventFeaturesForHost(
        context: context,
        event: widget.event,
        isSmallIcon: true,
      );
    } else if (isAttending) {
      features = EventDetailNavigationBarHelper.getEventFeaturesForGuest(
        context: context,
        event: widget.event,
        isSmallIcon: true,
      );
    }
    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(maxHeight: 150.w),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              separatorBuilder: (context, index) =>
                  SizedBox(width: Spacing.extraSmall),
              scrollDirection: Axis.horizontal,
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return EventDetailNavigationBarItem(
                  feature: feature,
                  isCardMode: false,
                );
              },
            ),
          );
        },
      ),
    );
  }

  SliverPadding _buildGridList() {
    final userId = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (session) => session.userId,
        );
    List features = [];
    final isCohost = EventUtils.isCohost(event: widget.event, userId: userId);
    final isAttending =
        EventUtils.isAttending(event: widget.event, userId: userId);
    final isOwnEvent =
        EventUtils.isOwnEvent(event: widget.event, userId: userId);

    if (isOwnEvent || isCohost) {
      features = EventDetailNavigationBarHelper.getEventFeaturesForHost(
        context: context,
        event: widget.event,
        isSmallIcon: false,
      );
    } else if (isAttending) {
      features = EventDetailNavigationBarHelper.getEventFeaturesForGuest(
        context: context,
        event: widget.event,
        isSmallIcon: false,
      );
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          var maxWidth = constraints.crossAxisExtent;
          final fourItemInRowWidth = _cardItemWidth * 4 + (4 * Spacing.small);
          final isLargeDevice = maxWidth >= 500;
          if (isLargeDevice) {
            maxWidth = min(maxWidth, fourItemInRowWidth);
          }
          final numOfItems = AnimationUtils.calculateMaxItemsInRow(
            rowWidth: maxWidth.w - 2 * Spacing.smMedium,
            itemWidth: _cardItemWidth,
            separatorWidth: Spacing.small,
          );
          final chunkListResult = AnimationUtils.chunkList(
            list: features,
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
                  return const SizedBox();
                }
                var chunkPortion = chunkListResult[index];
                final isNotFullRow = chunkPortion.length < numOfItems;
                if (isNotFullRow && !isLargeDevice) {
                  chunkPortion = [
                    ...chunkPortion,
                    ...List.filled(
                      numOfItems - chunkPortion.length,
                      FeatureItem.empty(),
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
                    children: List<FeatureItem>.from(chunkPortion).map(
                      (collection) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: isLargeDevice ? Spacing.extraSmall : 0,
                          ),
                          child: EventDetailNavigationBarItem(
                            feature: collection,
                            isCardMode: true,
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
      ),
    );
  }
}

class EventDetailNavigationBarItem extends StatelessWidget {
  const EventDetailNavigationBarItem({
    super.key,
    required this.feature,
    required this.isCardMode,
  });
  final FeatureItem feature;
  final bool isCardMode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = isCardMode ? 75.w : 54.w;
    final height = isCardMode ? 75.w : 42.w;
    return InkWell(
      onTap: () {
        feature.onTap();
      },
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: feature.backgroundColor ??
                  colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(21.r),
            ),
            child: Center(child: feature.iconData),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            feature.label,
            style: Typo.xSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: feature.textColor ?? colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
