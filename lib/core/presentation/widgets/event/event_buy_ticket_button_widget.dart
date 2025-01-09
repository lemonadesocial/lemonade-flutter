import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/input/get_event_ticket_types_input/get_event_ticket_types_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/list_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventBuyTicketButton extends StatelessWidget {
  final Event event;
  const EventBuyTicketButton({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          authenticated: (_) => true,
        );

    return FutureBuilder(
      future: isLoggedIn && event.eventTicketTypes?.isEmpty == true
          ? getIt<EventTicketRepository>().getEventTicketTypes(
              input: GetEventTicketTypesInput(
                event: event.id ?? '',
              ),
            )
          : Future.value(null),
      builder: (context, ticketTypesSnapshot) {
        List<EventTicketType>? ticketTypes =
            ticketTypesSnapshot.data?.fold((l) => [], (r) {
          return r.ticketTypes
              ?.map(
                (item) => EventTicketType(
                  id: item.id,
                  title: item.title,
                  prices: item.prices,
                  isDefault: item.isDefault,
                ),
              )
              .toList();
        });
        final defaultTicketType =
            ListUtils.findWithConditionOrFirst<EventTicketType>(
          items: ticketTypes ?? event.eventTicketTypes ?? [],
          condition: (ticketType) => ticketType.isDefault == true,
        );
        final defaultPrice =
            ListUtils.findWithConditionOrFirst<EventTicketPrice>(
          items: defaultTicketType?.prices ?? [],
          condition: (price) => price.isDefault == true,
        );
        return FutureBuilder(
          future: isLoggedIn
              ? getIt<EventTicketRepository>().getEventCurrencies(
                  input: GetEventCurrenciesInput(id: event.id ?? ''),
                )
              : Future.value(null),
          builder: (context, snapshot) {
            final isLoading = ticketTypesSnapshot.connectionState ==
                    ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.waiting;
            final currencyInfo =
                snapshot.data?.getOrElse(() => []).firstWhereOrNull(
                      (info) => info.currency == defaultPrice?.currency,
                    );
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
                          decimals: currencyInfo?.decimals?.toInt(),
                          price: defaultPrice,
                          isCrypto: currencyInfo?.network?.isNotEmpty == true,
                        ),
                        style:
                            Typo.small.copyWith(color: colorScheme.onPrimary),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
