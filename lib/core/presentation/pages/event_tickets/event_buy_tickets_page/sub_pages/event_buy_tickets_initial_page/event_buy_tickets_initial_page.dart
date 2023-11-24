import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventBuyTicketsInitialPage extends StatelessWidget {
  const EventBuyTicketsInitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    final userId = AuthUtils.getUserId(context);

    return BlocProvider(
      create: (context) => GetMyTicketsBloc(
        input: GetTicketsInput(
          skip: 0,
          limit: 100,
          user: userId,
          event: event.id ?? '',
        ),
      )..add(
          GetMyTicketsEvent.fetch(),
        ),
      child: const EventBuyTicketsInitialPageView(),
    );
  }
}

class EventBuyTicketsInitialPageView extends StatelessWidget {
  const EventBuyTicketsInitialPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<GetMyTicketsBloc, GetMyTicketsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          failure: () {
            AutoRouter.of(context).replace(
              const SelectTicketsRoute(),
            );
          },
          success: (eventTickets) {
            if (eventTickets.isEmpty) {
              AutoRouter.of(context).replace(
                const SelectTicketsRoute(),
              );
            } else {
              AutoRouter.of(context).replace(
                const EventPickMyTicketRoute(),
              );
            }
          },
        );
      },
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Center(
          child: Loading.defaultLoading(context),
        ),
      ),
    );
  }
}
