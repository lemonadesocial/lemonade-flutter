import 'dart:ui';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_more_actions.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class GuestEventDetailAppBar extends StatefulWidget {
  const GuestEventDetailAppBar({
    super.key,
    required this.event,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final Event event;

  @override
  State<GuestEventDetailAppBar> createState() => _GuestEventDetailAppBarState();
}

class _GuestEventDetailAppBarState extends State<GuestEventDetailAppBar> {
  bool _isSliverAppBarCollapsed = false;

  double get bannerHeight {
    final isIpad = DeviceUtils.isIpad();
    return isIpad ? 200.h : 325.w;
  }

  DbFile? get cover {
    if (widget.event.newNewPhotosExpanded == null ||
        widget.event.newNewPhotosExpanded!.isEmpty) {
      return null;
    }
    return widget.event.newNewPhotosExpanded!.first;
  }

  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(() {
      final mIsSliverAppBarCollapsed = widget.scrollController.hasClients &&
          widget.scrollController.offset > 150.w;
      if (_isSliverAppBarCollapsed == mIsSliverAppBarCollapsed) return;
      setState(() {
        _isSliverAppBarCollapsed = mIsSliverAppBarCollapsed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    if (cover == null) {
      return SliverToBoxAdapter(
        child: LemonAppBar(
          title: '',
          actions: [
            GuestEventMoreActions(event: widget.event, isAppBarCollapsed: true),
            SizedBox(width: Spacing.xSmall),
          ],
        ),
      );
    }

    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: appColors.pageBg,
      leading: const SizedBox.shrink(),
      collapsedHeight: kToolbarHeight,
      expandedHeight: bannerHeight,
      centerTitle: true,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _isSliverAppBarCollapsed ? 1 : 0,
        child: Text(
          widget.event.title ?? '',
          style: appText.md,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        collapseMode: CollapseMode.pin,
        background: _EventDetailCover(
          height: bannerHeight,
          event: widget.event,
        ),
      ),
    );
  }
}

class _EventDetailCover extends StatelessWidget {
  final Event event;
  final double height;
  const _EventDetailCover({
    required this.event,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => ImagePlaceholder.eventCard(),
              errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
              imageUrl: EventUtils.getEventThumbnailUrl(event: event),
            ),
          ),
        ],
      ),
    );
  }
}

class BlurCircle extends StatelessWidget {
  const BlurCircle({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(42.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.72),
            borderRadius: BorderRadius.circular(42.w),
          ),
          width: 42.w,
          height: 42.w,
          child: child,
        ),
      ),
    );
  }
}
