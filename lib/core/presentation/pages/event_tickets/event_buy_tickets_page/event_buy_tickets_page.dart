import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_buy_additional_tickets_bloc/event_buy_additonal_tickets_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/calculate_event_tickets_pricing_bloc/calculate_event_tickets_pricing_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/get_payment_cards_bloc/get_payment_cards_bloc.dart';
import 'package:app/core/application/payment/select_payment_card_cubit/select_payment_card_cubit.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event.dart' as event_entity;
import 'package:app/core/domain/event/entities/event_application_profile_field.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart' as matrix;

@RoutePage()
class EventBuyTicketsPage extends StatelessWidget implements AutoRouteWrapper {
  const EventBuyTicketsPage({
    super.key,
    required this.event,
    this.isBuyMore = false,
  });

  final event_entity.Event event;
  final bool isBuyMore;

  event_entity.Event _preModifyEvent(event_entity.Event event, User? user) {
    // manually add displayName field to applicationProfileFields if it is not present
    return event.copyWith(
      applicationProfileFields: [
        if (user?.displayName == null || user?.displayName?.isEmpty == true)
          EventApplicationProfileField(
            field: ProfileFieldKey.displayName.fieldKey,
            required: true,
          ),
        ...(event.applicationProfileFields ?? []),
      ],
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final user = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (user) => user,
          orElse: () => null,
        );
    final modifiedEvent = _preModifyEvent(event, user);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventProviderBloc(event: modifiedEvent),
        ),
        BlocProvider(
          create: (context) => GetEventTicketTypesBloc(event: modifiedEvent)
            ..add(
              GetEventTicketTypesEvent.fetch(),
            ),
        ),
        BlocProvider(
          create: (context) => SelectEventTicketsBloc(),
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
        BlocProvider(
          create: (context) => CalculateEventTicketPricingBloc(),
        ),
        BlocProvider(
          create: (context) => EventApplicationFormBloc()
            ..add(
              EventApplicationFormBlocEvent.initFieldState(
                event: modifiedEvent,
                user: user,
              ),
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
