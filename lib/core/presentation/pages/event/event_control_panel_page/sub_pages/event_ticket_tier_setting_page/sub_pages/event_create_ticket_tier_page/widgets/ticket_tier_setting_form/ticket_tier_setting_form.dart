import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/widgets/activate_ticket_setting.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/widgets/ticket_limit_per_setting.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/widgets/limited_ticket_setting.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/widgets/private_ticket_setting.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/widgets/ticket_total_limit_setting.dart';
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
          t.event.ticketTierSetting.registration,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        const TicketTotalLimitSetting(),
        SizedBox(height: Spacing.xSmall),
        const TicketLimitPerSetting(),
        SizedBox(height: Spacing.xSmall),
        const ActivateTicketSetting(),
        SizedBox(height: Spacing.xSmall),
        const PrivateTicketSetting(),
        SizedBox(height: Spacing.xSmall),
        LimitedTicketSetting(
          ticketType: ticketType,
        ),
      ],
    );
  }
}
