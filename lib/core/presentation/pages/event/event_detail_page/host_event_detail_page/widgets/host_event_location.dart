import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/ripple_marker.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/map_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class HostEventLocation extends StatelessWidget {
  const HostEventLocation({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    final t = Translations.of(context);
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
                  topLeft: Radius.circular(LemonRadius.medium),
                  bottomLeft: Radius.circular(LemonRadius.medium),
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
                  color: appColors.cardBg,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.sp),
                    bottomRight: Radius.circular(15.sp),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThemeSvgIcon(
                      color: appColors.textPrimary,
                      builder: (filter) => Assets.icons.icLocationPin.svg(
                        colorFilter: filter,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      event.address?.title ?? t.event.eventLocation,
                      style: appText.md.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: Spacing.superExtraSmall),
                    Text(
                      EventUtils.getAddress(
                        event: event,
                        showFullAddress: true,
                      ),
                      style: appText.xs.copyWith(
                        color: appColors.textSecondary,
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
