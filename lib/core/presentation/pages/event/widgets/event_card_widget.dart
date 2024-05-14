import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/event/event_default_price_badge.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/typo.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function()? onTap;

  const EventCard({
    super.key,
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCardHeader(context),
            _buildCardBody(),
            _buildCardFooter(context, colorScheme),
          ],
        ),
      ),
    );
  }

  _buildCardHeader(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context)
            .navigate(ProfileRoute(userId: event.hostExpanded?.userId ?? ''));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.xSmall,
          vertical: Spacing.xSmall,
        ),
        child: LemonCircleAvatar(
          url: ImageUtils.generateUrl(
            file: event.hostExpanded?.newPhotosExpanded?.isNotEmpty == true
                ? event.hostExpanded?.newPhotosExpanded?.first
                : null,
            imageConfig: ImageConfig.profile,
          ),
          label: event.hostExpanded?.name ?? '',
        ),
      ),
    );
  }

  _buildCardBody() => event.newNewPhotosExpanded?.isNotEmpty == true
      ? Container(
          constraints: const BoxConstraints(maxHeight: 300),
          width: double.infinity,
          height: 200,
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, __) => ImagePlaceholder.eventCard(),
            errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
            imageUrl: ImageUtils.generateUrl(
              file: event.newNewPhotosExpanded?.firstOrNull,
              imageConfig: ImageConfig.eventPhoto,
            ),
          ),
        )
      : ImagePlaceholder.eventCard();

  _buildCardFooter(BuildContext context, ColorScheme colorScheme) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.small,
          vertical: Spacing.small,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    DateFormatUtils.fullDateWithTime(event.start),
                    style: Typo.small.copyWith(color: colorScheme.onSecondary),
                  ),
                ],
              ),
            ),
            const Spacer(),
            EventDefaultPriceBadge(event: event),
          ],
        ),
      );
}
