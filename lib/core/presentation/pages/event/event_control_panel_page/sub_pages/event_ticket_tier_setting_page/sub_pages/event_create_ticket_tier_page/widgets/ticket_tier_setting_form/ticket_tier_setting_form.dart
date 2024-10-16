import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/activate_ticket_setting.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/ticket_limit_per_setting.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/limited_ticket_setting.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/private_ticket_setting.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class TicketTierSettingForm extends StatelessWidget {
  final EventTicketType? ticketType;
  const TicketTierSettingForm({
    super.key,
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.ticketTierSetting.guests,
          style: Typo.medium.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: Spacing.small),
        const TicketLimitPerSetting(),
        SizedBox(height: Spacing.smMedium),
        const ActivateTicketSetting(),
        SizedBox(height: Spacing.smMedium),
        const PrivateTicketSetting(),
        SizedBox(height: Spacing.smMedium),
        LimitedTicketSetting(
          ticketType: ticketType,
        ),
      ],
    );
  }
}
