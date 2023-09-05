import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GuestEventLocation extends StatefulWidget {
  const GuestEventLocation({
    super.key,
    required this.event,
  });

  final Event event;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.809382096561233, 106.61644131717077),
    zoom: 14.4746,
  );

  @override
  State<GuestEventLocation> createState() => _GuestEventLocationState();
}

class _GuestEventLocationState extends State<GuestEventLocation> {
  // TODO:
  // late final String _mapStyle = Assets.googleMap.googleMapCustomStyle;
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    // TODO:
    // DefaultAssetBundle.of(context).loadString(
    //   Assets.googleMap.googleMapCustomStyle,
    //   ).then((value) {
    //   _mapStyle = value;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SizedBox(
      width: double.infinity,
      height: 144.w,
      child: Row(
        children: [
          SizedBox(
            width: 144.w,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.sp),
                bottomLeft: Radius.circular(15.sp),
              ),
              child: Assets.images.fakeEventLocation.image(),
              // TODO:
              // child: GoogleMap(
              //   initialCameraPosition: GuestEventLocation._kGooglePlex,
              //   onMapCreated: (controller) async {
              //     _mapController = controller;
              //     _mapController.setMapStyle(_mapStyle);
              //   },
              //   myLocationButtonEnabled: false,
              // ),
            ),
          ),
          Flexible(
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
                  Assets.icons.icLock.svg(),
                  const Spacer(),
                  Text(
                    t.event.eventLocation,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontFamily.switzerVariable,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.rsvpToUnlock,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
