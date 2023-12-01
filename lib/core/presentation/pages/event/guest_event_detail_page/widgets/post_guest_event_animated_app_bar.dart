import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_animated_appbar_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostGuestEventAnimatedAppBar extends LemonAnimatedAppBar {
  final Event event;

  PostGuestEventAnimatedAppBar({
    required this.event,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final primary = Theme.of(context).colorScheme.primary;
    return AppBar(
      backgroundColor: backgroundColor ?? primary,
      automaticallyImplyLeading: hideLeading ?? true,
      leading: hideLeading ?? false ? null : leading ?? const LemonBackButton(),
      actions: [SizedBox(width: Spacing.smMedium * 3)],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3.r),
            child: SizedBox(
              width: Sizing.small,
              height: Sizing.small,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: EventUtils.getEventThumbnailUrl(event: event),
                errorWidget: (context, url, error) =>
                    ImagePlaceholder.defaultPlaceholder(),
                placeholder: (context, url) =>
                    ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Flexible(
            child: Text(
              event.title ?? '',
              style: Typo.extraMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: preferredSize.height,
    );
  }
}
