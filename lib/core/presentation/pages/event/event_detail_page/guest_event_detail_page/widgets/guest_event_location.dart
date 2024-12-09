import 'package:app/core/application/auth/auth_bloc.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventLocation extends StatelessWidget {
  const GuestEventLocation({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
    final isAttending = (event.accepted ?? []).contains(userId);

    return InkWell(
      onTap: () => MapUtils.showMapOptionBottomSheet(
        context,
        latitude: event.latitude ?? 0,
        longitude: event.longitude ?? 0,
      ),
      child: SizedBox(
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
                        errorWidget: (_, __, ___) =>
                            ImagePlaceholder.eventCard(),
                        imageUrl: MapUtils.createGoogleMapsURL(
                          lat: event.latitude ?? 0,
                          lng: event.longitude ?? 0,
                          attended: isAttending,
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
                    isAttending
                        ? Assets.icons.icLocationPin.svg()
                        : Assets.icons.icLock.svg(),
                    const Spacer(),
                    Text(
                      event.address?.title ?? t.event.eventLocation,
                      style: Typo.mediumPlus.copyWith(
                        fontFamily: FontFamily.switzerVariable,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    if (isAttending)
                      Text(
                        EventUtils.getAddress(event: event),
                        style: Typo.small.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      )
                    else
                      Text(
                        t.event.rsvpToUnlock,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
