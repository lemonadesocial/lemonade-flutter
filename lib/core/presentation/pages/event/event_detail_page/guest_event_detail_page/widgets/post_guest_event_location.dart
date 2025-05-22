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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class PostGuestEventLocation extends StatelessWidget {
  const PostGuestEventLocation({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.event.eventLocation,
              style: appText.md,
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
                        color: appColors.pageDivider,
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
          style: appText.md,
        ),
        SizedBox(height: 3.w),
        Text(
          EventUtils.getAddress(
            event: event,
            showFullAddress: true,
          ),
          style: appText.sm.copyWith(
            color: appColors.textTertiary,
          ),
        ),
      ],
    );
  }
}
