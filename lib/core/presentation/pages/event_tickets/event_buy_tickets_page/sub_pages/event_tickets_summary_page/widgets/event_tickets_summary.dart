import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTicketsSummary extends StatelessWidget {
  const EventTicketsSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ticketTypes = context.read<GetEventTicketTypesBloc>().state.maybeWhen(
          orElse: () => [] as List<PurchasableTicketType>,
          success: (response) => response.ticketTypes ?? [],
        );
    final selectedTickets =
        context.read<SelectEventTicketTypesBloc>().state.selectedTicketTypes;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: selectedTickets.map((selectedTicket) {
        final selectedTicketType =
            ticketTypes.firstWhere((item) => item.id == selectedTicket.id);
        return TicketSummaryItem(
          ticketType: selectedTicketType,
          count: selectedTicket.count,
        );
      }).toList(),
    );
  }
}

class TicketSummaryItem extends StatelessWidget {
  const TicketSummaryItem({
    super.key,
    required this.count,
    required this.ticketType,
  });

  final PurchasableTicketType ticketType;
  final int count;

  @override
  Widget build(BuildContext context) {
    final selectedCurrency =
        context.read<SelectEventTicketTypesBloc>().state.selectedCurrency;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(bottom: Spacing.xSmall),
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$count x  '),
          Text(ticketType.title ?? ''),
          SizedBox(width: Spacing.extraSmall),
          InkWell(
            onTap: () => context.router.pop(),
            child: Container(
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
          ),
          const Spacer(),
          Text(
            NumberUtils.formatCurrency(
              amount:
                  (ticketType.defaultPrice?.fiatCost?.toDouble() ?? 0) * count,
              // TODO: currency maybe flexible
              currency: selectedCurrency,
            ),
          ),
        ],
      ),
    );
  }
}
