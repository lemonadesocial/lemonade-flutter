import 'package:app/core/application/event_tickets/get_ticket_bloc/get_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanQrTicketActionButton extends StatelessWidget {
  const ScanQrTicketActionButton({super.key, required this.ticket});

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool allCheckedIn = ticket.checkin?.active == true &&
        (ticket.acquiredTickets?.every((t) => t.checkin?.active == true) ??
            true);
    if (allCheckedIn) {
      return Container(
        height: Sizing.large,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: LemonColor.white06,
            width: 1,
            style: BorderStyle.none,
          ),
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          color: LemonColor.white06,
          child: Center(
            child: Text(
              t.event.scanQR.checkedInAll,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return LinearGradientButton.primaryButton(
      label: t.event.scanQR.checkInAll,
      onTap: () async {
        final response = await showFutureLoadingDialog(
          context: context,
          future: () {
            final shortIds = [
              ticket.shortId ?? '',
              ...(ticket.acquiredTickets ?? []).map((e) => e.shortId ?? ''),
            ];
            return getIt<AppGQL>().client.mutate$UpdateEventCheckins(
                  Options$Mutation$UpdateEventCheckins(
                    variables: Variables$Mutation$UpdateEventCheckins(
                      input: Input$UpdateEventCheckinInput(
                        active: true,
                        shortids: shortIds,
                      ),
                    ),
                  ),
                );
          },
        );
        if (response.result?.parsedData?.updateEventCheckins != null) {
          SnackBarUtils.showSuccess(
            message: t.event.scanQR.checkedInAllSuccessfully,
          );
          context.read<GetTicketBloc>().add(
                GetTicketEventFetch(
                  shortId: ticket.shortId ?? "",
                  showLoading: false,
                ),
              );
        }
      },
    );
  }
}
