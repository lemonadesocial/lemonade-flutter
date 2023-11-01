import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTicketItem extends StatelessWidget {
  const SelectTicketItem({
    super.key,
    required this.ticketType,
    required this.onCountChange,
  });

  final PurchasableTicketType ticketType;
  final ValueChanged<int> onCountChange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final costText = NumberUtils.formatCurrency(
      amount: (ticketType.price?.toDouble() ?? 0),
      currency: ticketType.priceCurrency,
      freeText: t.event.free,
    );
    return Padding(
      padding: EdgeInsets.all(Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              child: CachedNetworkImage(
                // TODO: api does not support yet
                imageUrl: "",
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                errorWidget: (_, __, ___) =>
                    ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          // ticket type name and description
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${ticketType.title}  •  $costText",
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (ticketType.description != null &&
                    ticketType.description!.isNotEmpty) ...[
                  SizedBox(height: 2.w),
                  Text(
                    ticketType.description ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          // quantity selection
          InkWell(
            child: Container(
              width: 120.w,
              height: Sizing.medium,
              decoration: BoxDecoration(
                color: ticketType.count > 0
                    ? colorScheme.onPrimary.withOpacity(0.05)
                    : Colors.transparent,
                border: Border.all(
                  color: ticketType.count > 0
                      ? colorScheme.onPrimary.withOpacity(0.005)
                      : colorScheme.onPrimary.withOpacity(0.09),
                  // color:  colorScheme.onPrimary.withOpacity(0.005),
                ),
                borderRadius: BorderRadius.circular(LemonRadius.xSmall),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (ticketType.count == 0) return;
                      onCountChange(ticketType.count - 1);
                    },
                    icon: Icon(
                      Icons.remove,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        ticketType.count.toString(),
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                          // TODO:switch between no quantity and has quantity
                          // color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => onCountChange(ticketType.count + 1),
                    icon: Icon(
                      Icons.add,
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
