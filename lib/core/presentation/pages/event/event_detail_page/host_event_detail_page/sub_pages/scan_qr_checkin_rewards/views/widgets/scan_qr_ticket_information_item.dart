import 'package:app/core/application/event_tickets/get_ticket_bloc/get_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:dropdown_button2/dropdown_button2.dart';

class ScanQrTicketInformationItem extends StatelessWidget {
  const ScanQrTicketInformationItem({
    super.key,
    required this.ticket,
    required this.originalTicket,
  });

  final EventTicket ticket;
  final EventTicket originalTicket;

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
          _TicketStatusButton(
            ticket: ticket,
            originalTicket: originalTicket,
            isCheckedIn: alreadyCheckedIn,
          ),
        ],
      ),
    );
  }
}

class _TicketStatusButton extends StatelessWidget {
  const _TicketStatusButton({
    required this.ticket,
    required this.originalTicket,
    required this.isCheckedIn,
  });

  final EventTicket ticket;
  final EventTicket? originalTicket;
  final bool isCheckedIn;

  Future<void> _handleCheckin(BuildContext context) async {
    final t = Translations.of(context);
    final response = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<AppGQL>().client.mutate$UpdateEventCheckins(
            Options$Mutation$UpdateEventCheckins(
              variables: Variables$Mutation$UpdateEventCheckins(
                input: Input$UpdateEventCheckinInput(
                  active: !isCheckedIn,
                  shortids: [ticket.shortId ?? ''],
                ),
              ),
            ),
          ),
    );
    if (response.result?.parsedData?.updateEventCheckins != null) {
      context.read<GetTicketBloc>().add(
            GetTicketEventFetch(
              shortId: originalTicket?.shortId ?? "",
              showLoading: false,
            ),
          );
      SnackBarUtils.showSuccess(
        message: isCheckedIn
            ? t.event.scanQR.undoCheckInSuccessfully
            : t.event.scanQR.checkedinSuccessfully,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (!isCheckedIn) {
      return InkWell(
        onTap: () => _handleCheckin(context),
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

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.xSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                  color: LemonColor.white23,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            customButton: Icon(
              Icons.more_vert,
              color: colorScheme.onSecondary,
              size: Sizing.mSmall,
            ),
            items: [
              DropdownMenuItem<String>(
                value: 'undo',
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icRemoveUser.svg(
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                        colorFilter: filter,
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Text(
                      t.event.scanQR.undoCheckIn,
                      style: Typo.small.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onChanged: (_) => _handleCheckin(context),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.normal),
                color: LemonColor.atomicBlack,
              ),
              offset: Offset(0, -Spacing.superExtraSmall),
            ),
            menuItemStyleData: const MenuItemStyleData(
              overlayColor: MaterialStatePropertyAll(LemonColor.darkBackground),
            ),
          ),
        ),
      ],
    );
  }
}
