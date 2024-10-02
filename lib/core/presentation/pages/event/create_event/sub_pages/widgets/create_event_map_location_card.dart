import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/ripple_marker.dart';
import 'package:app/core/utils/map_utils.dart';
import 'package:app/theme/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: MapUtils.createGoogleMapsURL(
                  lat: latitude,
                  lng: longitude,
                  attended: true,
                ),
              ),
            ),
            Center(
              child: RippleMarker(
                size: constraints.maxWidth * 0.3,
                color: LemonColor.rippleMarkerColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
