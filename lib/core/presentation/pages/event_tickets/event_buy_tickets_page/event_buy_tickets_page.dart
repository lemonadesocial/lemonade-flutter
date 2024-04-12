import 'package:app/core/application/event/event_buy_additional_tickets_bloc/event_buy_additonal_tickets_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/get_payment_cards_bloc/get_payment_cards_bloc.dart';
import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/domain/event/entities/event.dart' as event_entity;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart';

@RoutePage()
class EventBuyTicketsPage extends StatelessWidget implements AutoRouteWrapper {
  const EventBuyTicketsPage({
    super.key,
    required this.event,
    this.isBuyMore = false,
  });

  final event_entity.Event event;
  final bool isBuyMore;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventProviderBloc(event: event),
        ),
        BlocProvider(
          create: (context) => GetEventTicketTypesBloc(event: event)
            ..add(
              GetEventTicketTypesEvent.fetch(),
            ),
        ),
        BlocProvider(
          create: (context) => SelectEventTicketsBloc(),
        ),
        BlocProvider(
          create: (context) => RedeemTicketsBloc(event: event),
        ),
        BlocProvider(
          create: (context) => GetPaymentCardsBloc(),
        ),
        BlocProvider(
          create: (context) => SelectPaymentCardCubit(),
        ),
        BlocProvider(
          create: (context) => EventBuyAdditionalTicketsBloc(
            isBuyMore: isBuyMore,
          ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var currentTopRoute = AutoRouter.of(context).topRoute;
        bool? isPopBlocked = currentTopRoute.meta.tryGet('popBlocked');
        return isPopBlocked != null ? !isPopBlocked : true;
      },
      child: const AutoRouter(),
    );
  }
}
