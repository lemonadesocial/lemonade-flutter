import 'package:app/core/domain/event/entities/event.dart';
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

class SelectTicketItem extends StatefulWidget {
  const SelectTicketItem({
    super.key,
    required this.ticketType,
    required this.event,
    required this.onCountChange,
  });

  final PurchasableTicketType ticketType;
  final Event event;
  final ValueChanged<int> onCountChange;

  @override
  State<SelectTicketItem> createState() => _SelectTicketItemState();
}

class _SelectTicketItemState extends State<SelectTicketItem> {
  var count = 1;

  void add() {
    if (count < (widget.ticketType.limit ?? 0)) {
      setState(() {
        count++;
      });
      widget.onCountChange(count);
    }
  }

  void minus() {
    if (count == 1) return;
    setState(() {
      count--;
    });
    widget.onCountChange(count);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final costText = NumberUtils.formatCurrency(
      amount: (widget.ticketType.cost?.toDouble() ?? 0),
      currency: widget.event.currency,
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
                  "${widget.ticketType.title}  •  $costText",
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.ticketType.description != null &&
                    widget.ticketType.description!.isNotEmpty) ...[
                  SizedBox(height: 2.w),
                  Text(
                    widget.ticketType.description ?? '',
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
                color: count > 0
                    ? colorScheme.onPrimary.withOpacity(0.05)
                    : Colors.transparent,
                border: Border.all(
                  color: count > 0
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
                    onPressed: () => minus(),
                    icon: Icon(
                      Icons.remove,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${count.toInt()}",
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
                    onPressed: () => add(),
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
