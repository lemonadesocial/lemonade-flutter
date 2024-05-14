import 'package:app/core/application/common/get_all_currencies_bloc/get_all_currencies_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/list_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDefaultPriceBadge extends StatelessWidget {
  final Event event;
  const EventDefaultPriceBadge({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultTicketType =
        ListUtils.findWithConditionOrFirst<EventTicketType>(
      items: event.eventTicketTypes ?? [],
      condition: (ticketType) => ticketType.isDefault == true,
    );
    final defaultPrice = ListUtils.findWithConditionOrFirst<EventTicketPrice>(
      items: defaultTicketType?.prices ?? [],
      condition: (price) => price.isDefault == true,
    );
    return BlocBuilder<GetAllCurrenciesBloc, GetAllCurrenciesState>(
      builder: (context, state) {
        final isLoading = state.isLoading;
        final currency = context
            .read<GetAllCurrenciesBloc>()
            .getCurrencyByCode(defaultPrice?.currency ?? '');
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
              vertical: Spacing.extraSmall,
            ),
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, -1.00),
                end: const Alignment(0, 1),
                colors: [LemonColor.arsenic, LemonColor.charlestonGreen],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LemonRadius.normal),
              ),
              shadows: [
                BoxShadow(
                  color: LemonColor.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icTicket.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
                SizedBox(width: Spacing.superExtraSmall),
                if (isLoading)
                  Loading.defaultLoading(context)
                else
                  Text(
                    EventTicketUtils.getDisplayedTicketPrice(
                      decimals: currency?.decimals?.toInt(),
                      price: defaultPrice,
                    ),
                    style: Typo.small.copyWith(color: colorScheme.onPrimary),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
