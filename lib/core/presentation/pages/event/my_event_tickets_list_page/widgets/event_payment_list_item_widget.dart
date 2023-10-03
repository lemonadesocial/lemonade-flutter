import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventPaymentListItemWidget extends StatelessWidget {
  final EventPayment eventPayment;

  const EventPaymentListItemWidget({
    super.key,
    required this.eventPayment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.smMedium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Event pic
          if (eventPayment.eventExpanded != null)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: Sizing.xLarge,
                  height: Sizing.medium,
                  imageUrl: EventUtils.getEventThumbnailUrl(
                    event: eventPayment.eventExpanded!,
                  ),
                  placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                  errorWidget: (_, __, ___) =>
                      ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
            ),
          SizedBox(width: Spacing.small),
          // event name and tickets info
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventPayment.eventExpanded?.title ?? '',
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${eventPayment.ticketCount?.toInt() ?? 0} ${t.event.tickets(n: eventPayment.ticketCount ?? 1)}   •   ${DateFormatUtils.custom(eventPayment.eventExpanded?.start, pattern: 'EEE, dd MMM')}',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: Spacing.small),
          // remaining tickets icon
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.extraSmall,
              vertical: Spacing.superExtraSmall,
            ),
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(LemonRadius.normal),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  color: LemonColor.paleViolet,
                  builder: (filter) => Assets.icons.icTicket.svg(
                    colorFilter: filter,
                    width: Sizing.small / 2,
                    height: Sizing.small / 2,
                  ),
                ),
                SizedBox(width: Spacing.extraSmall / 2),
                Text(
                  '+${eventPayment.ticketCountRemaining?.toInt() ?? 0}',
                  style: Typo.small.copyWith(
                    color: LemonColor.paleViolet,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          // dot horizontal
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) =>
                Assets.icons.icMoreHoriz.svg(colorFilter: filter),
          ),
        ],
      ),
    );
  }
}
