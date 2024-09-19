import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_expand_button.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/ripple_marker.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/map_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostGuestEventLocation extends StatelessWidget {
  const PostGuestEventLocation({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.event.eventLocation,
              style: Typo.extraMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary,
              ),
            ),
            GuestEventDetailExpandButton(
              onTap: () => MapUtils.showMapOptionBottomSheet(
                context,
                latitude: event.latitude ?? 0,
                longitude: event.longitude ?? 0,
              ),
            ),
          ],
        ),
        SizedBox(height: Spacing.smMedium),
        InkWell(
          onTap: () => MapUtils.showMapOptionBottomSheet(
            context,
            latitude: event.latitude ?? 0,
            longitude: event.longitude ?? 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                LemonRadius.medium,
              ),
            ),
            width: double.infinity,
            height: 140.w,
            child: Stack(
              children: [
                Positioned.fill(
                  child: LemonNetworkImage(
                    placeholder: ImagePlaceholder.eventCard(),
                    imageUrl: MapUtils.createGoogleMapsURL(
                      lat: event.latitude ?? 0,
                      lng: event.longitude ?? 0,
                      attended: true,
                    ),
                    borderRadius: BorderRadius.circular(
                      LemonRadius.medium,
                    ),
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.outline,
                        width: 0.5.w,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: RippleMarker(
                    size: 90.w,
                    color: LemonColor.rippleMarkerColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: Spacing.smMedium),
        Text(
          event.address?.title ?? t.event.eventLocation,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 3.w),
        Text(
          EventUtils.getAddress(event),
          style: Typo.small.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
