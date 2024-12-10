import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/update_event_checkin.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:slang/builder/utils/string_extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

class ScanQrTicketInformationItem extends StatelessWidget {
  const ScanQrTicketInformationItem({super.key, required this.ticket});

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final ticketType = ticket.typeExpanded;
    final ticketTypeTitle = ticketType?.title ?? "";
    final assignedToLabel = ticket.assignedEmail ??
        ticket.assignedToExpanded?.name ??
        t.common.notAssigned;
    final alreadyCheckedIn = ticket.checkin?.active ?? false;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
        vertical: Spacing.xSmall,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        children: [
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icTicket.svg(
              width: Sizing.mSmall,
              height: Sizing.mSmall,
              colorFilter: filter,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticketTypeTitle,
                  style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onPrimary,
                  ),
                ),
                Text(
                  assignedToLabel,
                  style: Typo.small.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          if (alreadyCheckedIn)
            _CheckedInView(ticket: ticket)
          else
            _CheckinButton(ticket: ticket),
        ],
      ),
    );
  }
}

class _CheckinButton extends StatelessWidget {
  const _CheckinButton({super.key, required this.ticket});

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () async {
        final response = await showFutureLoadingDialog(
          context: context,
          future: () => getIt<AppGQL>().client.mutate$UpdateEventCheckin(
                Options$Mutation$UpdateEventCheckin(
                  variables: Variables$Mutation$UpdateEventCheckin(
                    input: Input$UpdateEventCheckinInput(
                      active: true,
                      shortid: ticket.shortId,
                    ),
                  ),
                ),
              ),
        );
        if (response.result?.parsedData?.updateEventCheckin != null) {
          SnackBarUtils.showSuccess(
            message: t.event.scanQR.checkedinSuccessfully,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.xSmall),
        decoration: BoxDecoration(
          color: LemonColor.white06,
          borderRadius: BorderRadius.circular(LemonRadius.xSmall),
        ),
        child: Text(
          t.event.scanQR.checkin,
          style: Typo.small.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

class _CheckedInView extends StatelessWidget {
  const _CheckedInView({required this.ticket});

  final EventTicket ticket;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.event.scanQR.checkedIn.capitalize(),
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSecondary,
                ),
              ),
              Text(
                timeago.format(
                  ticket.checkin?.createdAt ?? DateTime.now(),
                ),
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
