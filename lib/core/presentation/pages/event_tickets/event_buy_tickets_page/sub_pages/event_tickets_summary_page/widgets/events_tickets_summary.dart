import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsTicketSummary extends StatelessWidget {
  const EventsTicketSummary({
    super.key,
    required this.listTicket,
  });

  final List<PurchasableTicketType> listTicket;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: listTicket
          .map(
            (item) => TicketSummaryItem(ticket: item),
          )
          .toList(),
    );
  }
}

class TicketSummaryItem extends StatelessWidget {
  const TicketSummaryItem({
    super.key,
    required this.ticket,
  });

  final PurchasableTicketType ticket;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(bottom: Spacing.xSmall),
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(ticket.title ?? ''),
          SizedBox(width: Spacing.extraSmall),
          Container(
            width: 21.w,
            height: 21.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              color: colorScheme.outline,
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icEdit.svg(
                  colorFilter: filter,
                  width: Sizing.small / 2,
                  height: Sizing.small / 2,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            NumberUtils.formatCurrency(
              amount: ticket.cost?.toDouble() ?? 0,
              currency: Currency.USD,
            ),
          )
        ],
      ),
    );
  }
}
