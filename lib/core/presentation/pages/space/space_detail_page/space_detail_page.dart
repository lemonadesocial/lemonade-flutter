import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_header.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_info.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_events_header.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_event_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SpaceDetailPage extends StatefulWidget {
  final String spaceId;
  const SpaceDetailPage({
    super.key,
    required this.spaceId,
  });

  @override
  State<SpaceDetailPage> createState() => _SpaceDetailPageState();
}

class _SpaceDetailPageState extends State<SpaceDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingSubscribe = false;
  bool _showSimpleHeader = false;
  final double _subscribeButtonThreshold = 250;
  final double _headerThreshold = 200;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >= _subscribeButtonThreshold &&
        !_showFloatingSubscribe) {
      setState(() {
        _showFloatingSubscribe = true;
      });
    } else if (_scrollController.offset < _subscribeButtonThreshold &&
        _showFloatingSubscribe) {
      setState(() {
        _showFloatingSubscribe = false;
      });
    }

    if (_scrollController.offset >= _headerThreshold && !_showSimpleHeader) {
      setState(() {
        _showSimpleHeader = true;
      });
    } else if (_scrollController.offset < _headerThreshold &&
        _showSimpleHeader) {
      setState(() {
        _showSimpleHeader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SpaceHeader(),
              const SliverToBoxAdapter(
                child: SpaceInfo(),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  color: colorScheme.outline,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: const SpaceEventsHeader(),
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  return SpaceEventItem(index: index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: 10,
              ),
            ],
          ),
          _FloatingSpaceHeader(showSimpleHeader: _showSimpleHeader),
          _FloatingSubscribeButton(
            showFloatingSubscribe: _showFloatingSubscribe,
          ),
        ],
      ),
    );
  }
}

class _FloatingSpaceHeader extends StatelessWidget {
  const _FloatingSpaceHeader({
    required this.showSimpleHeader,
  });

  final bool showSimpleHeader;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: showSimpleHeader ? 0 : -(LemonAppBar.height + statusBarHeight),
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: const SafeArea(
          bottom: false,
          child: LemonAppBar(
            title: "Culture Fest",
          ),
        ),
      ),
    );
  }
}

class _FloatingSubscribeButton extends StatelessWidget {
  const _FloatingSubscribeButton({
    required this.showFloatingSubscribe,
  });

  final bool showFloatingSubscribe;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: showFloatingSubscribe ? Spacing.large : -2 * Spacing.large,
      left: 0,
      right: 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.small),
          child: SizedBox(
            height: 49.w,
            child: LinearGradientButton.primaryButton(label: "Subscribe"),
          ),
        ),
      ),
    );
  }
}

// Delegate cho SliverPersistentHeader
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
