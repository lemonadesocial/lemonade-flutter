import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketTierItem extends StatelessWidget {
  final EventTicketType eventTicketType;
  const TicketTierItem({
    super.key,
    required this.eventTicketType,
  });

  @override
  Widget build(BuildContext context) {
    final isFree =
        eventTicketType.prices?.any((element) => element.fiatCost == 0) ??
            false;
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              border: Border.all(
                color: LemonColor.chineseBlack,
              ),
            ),
            child: eventTicketType.photosExpanded?.isNotEmpty == true
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                    child: CachedNetworkImage(
                      imageUrl: ImageUtils.generateUrl(
                        file: eventTicketType.photosExpanded?.first,
                      ),
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Center(
                        child: ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => Assets.icons.icTicket.svg(
                            colorFilter: filter,
                            width: Sizing.xSmall,
                            height: Sizing.xSmall,
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icTicket.svg(
                        colorFilter: filter,
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: Spacing.xSmall),
          // Ticket tier description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventTicketType.title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                  ),
                ),
                SizedBox(height: 2.w),
                RichText(
                  text: TextSpan(
                    text: eventTicketType.isDefault == true
                        ? t.event.ticketTierSetting.defaultTicket
                        : eventTicketType.active == true
                            ? t.event.ticketTierSetting.active
                            : t.event.ticketTierSetting.disabled,
                    style: Typo.small.copyWith(
                      color: eventTicketType.active == true
                          ? colorScheme.onSecondary
                          : LemonColor.errorRedBg,
                    ),
                    children: [
                      WidgetSpan(
                        child: SizedBox(
                          width: Spacing.superExtraSmall,
                        ),
                      ),
                      TextSpan(
                        text:
                            "• ${isFree ? t.event.free : t.event.ticketTierSetting.method(
                                n: eventTicketType.prices?.length ?? 1,
                                count: eventTicketType.prices?.length ?? 1,
                              )}",
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: Spacing.superExtraSmall,
                        ),
                      ),
                      TextSpan(
                        text:
                            "• ${eventTicketType.ticketLimit == null ? t.event.ticketTierSetting.unlimitedGuests : t.event.ticketTierSetting.guestsCount(
                                n: (eventTicketType.ticketLimit ?? 0).toInt(),
                              )}",
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Edit icon
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.onPrimary.withOpacity(0.1),
              ),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icEdit.svg(
                  colorFilter: colorFilter,
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
