import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_application_form/rsvp_application_questions_form.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_application_form/rsvp_profle_fields_form.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/rsvp_verify_wallet_form/rsvp_verify_wallet_form.dart';
import 'package:flutter/material.dart';

class RSVPApplicationForm extends StatelessWidget {
  const RSVPApplicationForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RSVPProfileFieldsForm(),
        RSVPApplicationQuestionsForm(),
        RSVPVerifyWalletForm(),
      ],
    );
  }
}
