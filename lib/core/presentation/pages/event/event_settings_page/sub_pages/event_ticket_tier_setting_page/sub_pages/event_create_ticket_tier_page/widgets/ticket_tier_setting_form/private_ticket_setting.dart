import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/ticket_setting_locked_item.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PrivateTicketSetting extends StatelessWidget {
  const PrivateTicketSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
      builder: (context, state) {
        if (state.active == false) {
          return TicketSettingLockedItem(
            label: t.event.ticketTierSetting.listTicket,
          );
        }
        return Container(
          padding: EdgeInsets.all(Spacing.smMedium),
          decoration: BoxDecoration(
            color: colorScheme.onPrimary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(LemonRadius.normal),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.event.ticketTierSetting.listTicket,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.87),
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    state.private == true
                        ? t.event.ticketTierSetting.canOnlyAssigned
                        : t.event.ticketTierSetting.openPublicPurchase,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FlutterSwitch(
                inactiveColor: colorScheme.outline,
                inactiveToggleColor: colorScheme.onSurfaceVariant,
                activeColor: LemonColor.switchActive,
                activeToggleColor: colorScheme.onPrimary,
                height: Sizing.small,
                width: 42.w,
                value: !(state.private ?? false),
                onToggle: (value) {
                  context.read<ModifyTicketTypeBloc>().add(
                        ModifyTicketTypeEvent.onPrivateChanged(
                          private: !value,
                        ),
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
