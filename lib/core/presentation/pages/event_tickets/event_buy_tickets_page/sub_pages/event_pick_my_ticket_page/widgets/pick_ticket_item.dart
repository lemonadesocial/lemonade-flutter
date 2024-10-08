import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickTicketItem extends StatelessWidget {
  const PickTicketItem({
    super.key,
    required this.event,
    this.selected = false,
    this.ticketType,
    this.total = 1,
    this.currency,
    this.onPressed,
  });

  final Event event;
  final bool selected;
  final PurchasableTicketType? ticketType;
  final double total;
  final String? currency;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final displayedTotal = (selected ? total - 1 : total).toInt();
    final price = ticketType?.prices?.firstOrNull;
    final currency = price?.currency;
    final decimals = EventTicketUtils.getCurrencyDecimalsWithPaymentAccounts(
      currency: currency ?? '',
      paymentAccounts: event.paymentAccountsExpanded ?? [],
    );
    final displayedPrice = EventTicketUtils.getDisplayedTicketPrice(
      decimals: decimals,
      price: price,
    );

    return InkWell(
      onTap: () => onPressed?.call(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Spacing.small),
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? colorScheme.onPrimary : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.small),
          color: LemonColor.atomicBlack,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticketType?.title ?? '',
                      style: Typo.medium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      displayedPrice,
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: Sizing.regular,
                  height: Sizing.regular,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.outline,
                      width: 0.5.w,
                    ),
                    color: LemonColor.chineseBlack,
                    borderRadius: BorderRadius.circular(Sizing.regular),
                  ),
                  child: Center(
                    child: Text(
                      displayedTotal.toString(),
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (ticketType?.description?.isNotEmpty == true) ...[
              SizedBox(height: Spacing.xSmall),
              Text(
                ticketType?.description ?? '',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
