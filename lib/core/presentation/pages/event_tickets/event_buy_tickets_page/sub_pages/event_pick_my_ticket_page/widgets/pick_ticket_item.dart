import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickTicketItem extends StatelessWidget {
  const PickTicketItem({
    super.key,
    this.selected = false,
    this.ticketType,
    this.total = 1,
    this.currency,
    this.onPressed,
  });

  final bool selected;
  final PurchasableTicketType? ticketType;
  final double total;
  final String? currency;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final displayedTotal = (selected ? total - 1 : total).toInt();

    return InkWell(
      onTap: () => onPressed?.call(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              ),
              child: CachedNetworkImage(
                width: Sizing.medium,
                height: Sizing.medium,
                // TODO: ticketType.photosExpanded.first
                imageUrl: "",
                errorWidget: (_, __, ___) =>
                    ImagePlaceholder.defaultPlaceholder(),
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${ticketType?.title}   •   ${NumberUtils.formatCurrency(
                    amount: ticketType?.defaultPrice?.fiatCost?.toDouble() ?? 0,
                    currency: ticketType?.defaultCurrency,
                    freeText: t.event.free,
                  )}",
                  style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary.withOpacity(0.87),
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  selected
                      ? '$displayedTotal ${t.event.remaining} ${t.event.tickets(n: displayedTotal)}'
                      : '$displayedTotal ${t.event.tickets(n: displayedTotal)}',
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (selected)
              Assets.icons.icInvitedFilled.svg()
            else
              ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) =>
                    Assets.icons.icCircleEmpty.svg(colorFilter: filter),
              ),
          ],
        ),
      ),
    );
  }
}
