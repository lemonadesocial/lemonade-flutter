import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_filter_bottomsheet_view/widgets/sub_event_hosts_filter_horizontal_list.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_filter_bottomsheet_view/widgets/sub_events_filter_bottomsheet_expanded_widget.dart';
import 'package:app/core/utils/animation_utils.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class SubEventsFilterBottomSheetView extends StatefulWidget {
  final List<Event> events;
  final List<String> selectedHostIds;
  final List<String> selectedTags;

  const SubEventsFilterBottomSheetView({
    super.key,
    required this.events,
    required this.selectedHostIds,
    required this.selectedTags,
  });

  @override
  State<SubEventsFilterBottomSheetView> createState() =>
      _SubEventsFilterBottomSheetViewState();
}

class _SubEventsFilterBottomSheetViewState
    extends State<SubEventsFilterBottomSheetView>
    with TickerProviderStateMixin {
  static const _snapSizes = <double>[0.25, 0.6, 1];

  final DraggableScrollableController dragController =
      DraggableScrollableController();

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );
  late final animation =
      Tween<double>(begin: 0, end: 1).animate(animationController);

  final Duration _animationDuration = const Duration(milliseconds: 300);

  bool get _visibleWhenExpanded => animation.value > 0.25;

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
      low1: _snapSizes[0],
      high1: _snapSizes[2],
      low2: 0,
      high2: 1,
    );
    animationController.animateTo(interpolatedValue);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snapAnimationDuration: const Duration(milliseconds: 500),
      controller: dragController,
      maxChildSize: _snapSizes[2],
      initialChildSize: _snapSizes[0],
      minChildSize: 0.25,
      // snap: true,
      snapSizes: _snapSizes,
      builder: (context, scrollController) {
        return SafeArea(
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              color: LemonColor.chineseBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(LemonRadius.small * 2),
                topRight: Radius.circular(LemonRadius.small * 2),
              ),
            ),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => AnimatedSwitcher(
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                duration: const Duration(milliseconds: 300),
                child: _visibleWhenExpanded
                    ? SubEventsFilterBottomsheetExpandedWidget(
                        scrollController: scrollController,
                        dragController: dragController,
                      )
                    : SubEventHostsFilterHorizontalList(
                        scrollController: scrollController,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}