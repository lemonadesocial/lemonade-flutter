import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/redeem_tickets_response.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/accept_event_input/accept_event_input.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// This widget handle case where event
/// - Only has 1 ticket type - ticket is free
/// - Ticket limit per guest is 1 (Group registration is OFF)
/// - No application form required, no profile fields required
class GuestEventDetailOneClickRedeemButton extends StatelessWidget {
  final Event event;
  final Function()? refetch;

  const GuestEventDetailOneClickRedeemButton({
    super.key,
    required this.event,
    this.refetch,
  });

  @override
  Widget build(BuildContext context) {
    return _GuestEventDetailOneClickRedeemButtonView(
      event: event,
      refetch: refetch,
    );
  }
}

class _GuestEventDetailOneClickRedeemButtonView extends StatefulWidget {
  const _GuestEventDetailOneClickRedeemButtonView({
    required this.event,
    this.refetch,
  });

  final Event event;
  final Function()? refetch;

  @override
  State<_GuestEventDetailOneClickRedeemButtonView> createState() =>
      _GuestEventDetailOneClickRedeemButtonViewState();
}

class _GuestEventDetailOneClickRedeemButtonViewState
    extends State<_GuestEventDetailOneClickRedeemButtonView> {
  EventTicketType? get eventTicketType =>
      widget.event.eventTicketTypes?.firstOrNull;
  bool isLoading = false;

  Future<void> _oneClickRegister() async {
    // Redeem
    final result = await getIt<EventTicketRepository>().redeemTickets(
      input: Input$RedeemTicketsInput(
        event: widget.event.id ?? '',
        items: [
          Input$PurchasableItem(
            count: 1,
            id: eventTicketType?.id ?? '',
          ),
        ],
      ),
    );
    if (result.isLeft()) {
      throw Exception(result.fold((l) => l, (r) => null));
    }

    RedeemTicketsResponse? redeemResponse = result.fold((l) => null, (r) => r);

    if (redeemResponse?.joinRequest != null) {
      widget.refetch?.call();
      return;
    }

    final assignResult = await getIt<EventTicketRepository>().assignTickets(
      input: AssignTicketsInput(
        event: widget.event.id ?? '',
        assignees: [
          TicketAssignee(
            ticket: redeemResponse?.tickets?.firstOrNull?.id ?? '',
            user: AuthUtils.getUserId(context),
          ),
        ],
      ),
    );

    if (assignResult.isLeft()) {
      throw Exception(assignResult.fold((l) => l, (r) => null));
    }

    final acceptResult = await getIt<EventRepository>().acceptEvent(
      input: AcceptEventInput(id: widget.event.id ?? ''),
    );

    if (acceptResult.isLeft()) {
      throw Exception(acceptResult.fold((l) => l, (r) => null));
    }
    final eventRsvp = acceptResult.fold((l) => null, (r) => r);
    AutoRouter.of(context).replace(
      RSVPEventSuccessPopupRoute(
        event: widget.event,
        eventRsvp: eventRsvp,
        onPressed: (newContext) {
          AutoRouter.of(newContext).replace(
            EventDetailRoute(
              eventId: widget.event.id ?? '',
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          border: Border(
            top: BorderSide(
              color: colorScheme.outline,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Spacing.smMedium,
          horizontal: Spacing.smMedium,
        ),
        child: LinearGradientButton.primaryButton(
          loadingWhen: isLoading,
          label: widget.event.approvalRequired == true
              ? t.event.rsvpStatus.requestToJoin
              : t.event.rsvpStatus.oneClickRegister,
          onTap: () async {
            if (isLoading) {
              return;
            }
            try {
              setState(() {
                isLoading = true;
              });
              await _oneClickRegister();
            } catch (e) {
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      ),
    );
  }
}
