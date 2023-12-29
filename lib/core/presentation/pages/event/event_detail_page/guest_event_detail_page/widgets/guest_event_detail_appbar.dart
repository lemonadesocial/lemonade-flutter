import 'dart:ui';

import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailAppBar extends StatelessWidget {
  const GuestEventDetailAppBar({
    super.key,
    required this.event,
    required this.isCollapsed,
  });

  final Event event;
  final bool isCollapsed;
  @override
  Widget build(BuildContext context) {
    final isIpad = DeviceUtils.isIpad();
    return SliverAppBar(
      pinned: true,
      stretch: true,
      floating: true,
      leading: const SizedBox.shrink(),
      collapsedHeight: kToolbarHeight,
      expandedHeight: isIpad ? 280.h : 188.h,
      centerTitle: true,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isCollapsed ? 1 : 0,
        child: Text(
          event.title ?? '',
          style: Typo.extraMedium.copyWith(
            fontFamily: FontFamily.switzerVariable,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        collapseMode: CollapseMode.pin,
        background: _EventDetailCover(event: event),
      ),
    );
  }
}

class _EventDetailCover extends StatelessWidget {
  const _EventDetailCover({required this.event});

  final Event event;

  DbFile? get cover {
    if (event.newNewPhotosExpanded == null ||
        event.newNewPhotosExpanded!.isEmpty) {
      return null;
    }
    return event.newNewPhotosExpanded!.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188.w,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => ImagePlaceholder.eventCard(),
              errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
              imageUrl: ImageUtils.generateUrl(
                file: cover,
                imageConfig: ImageConfig.eventPoster,
              ),
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
