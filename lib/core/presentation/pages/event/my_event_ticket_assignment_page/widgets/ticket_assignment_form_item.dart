import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class TicketAssignmentFormItem extends StatelessWidget {
  final EventTicket eventTicket;
  final PurchasableTicketType? ticketType;
  final Function(String email) onChangeEmail;

  const TicketAssignmentFormItem({
    super.key,
    required this.eventTicket,
    required this.ticketType,
    required this.onChangeEmail,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          ticketType?.title ?? '',
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        LemonTextField(
          filled: true,
          fillColor: LemonColor.atomicBlack,
          hintText: t.common.email,
          onChange: (value) {
            onChangeEmail(value);
          },
        ),
      ],
    );
  }
}
