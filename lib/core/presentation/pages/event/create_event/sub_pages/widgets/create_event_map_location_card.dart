import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/ripple_marker.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/event_utils.dart';
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

class CreateEventMapLocationCard extends StatelessWidget {
  const CreateEventMapLocationCard({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (_, __) => ImagePlaceholder.eventCard(),
                errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
                imageUrl: MapUtils.createGoogleMapsURL(
                  lat: latitude,
                  lng: longitude,
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
    );
  }
}
