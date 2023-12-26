import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/ripple_marker.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/map_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostEventLocation extends StatelessWidget {
  const HostEventLocation({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SizedBox(
      width: double.infinity,
      height: 144.w,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 144.w,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                bottomLeft: Radius.circular(15.sp),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (_, __) => ImagePlaceholder.eventCard(),
                      errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
                      imageUrl: MapUtils.createGoogleMapsURL(
                        lat: event.latitude ?? 0,
                        lng: event.longitude ?? 0,
                        attended: true,
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.smMedium,
                horizontal: Spacing.small,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.sp),
                  bottomRight: Radius.circular(15.sp),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.icons.icLocationPin.svg(),
                  const Spacer(),
                  Text(
                    t.event.eventLocation,
                    style: Typo.mediumPlus.copyWith(
                      fontFamily: FontFamily.switzerVariable,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    event.address?.street1 ?? '',
                    style: Typo.small.copyWith(
                      fontFamily: FontFamily.switzerVariable,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
