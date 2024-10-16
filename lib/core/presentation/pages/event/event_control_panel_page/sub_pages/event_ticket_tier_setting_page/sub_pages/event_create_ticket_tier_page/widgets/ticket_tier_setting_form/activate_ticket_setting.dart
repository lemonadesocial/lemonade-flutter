import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ActivateTicketSetting extends StatelessWidget {
  const ActivateTicketSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

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
                t.event.ticketTierSetting.activateTicket,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.87),
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                t.event.ticketTierSetting.visibleToGuests,
                style: Typo.small.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const Spacer(),
          BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
            builder: (context, state) => FlutterSwitch(
              inactiveColor: colorScheme.outline,
              inactiveToggleColor: colorScheme.onSurfaceVariant,
              activeColor: LemonColor.switchActive,
              activeToggleColor: colorScheme.onPrimary,
              height: Sizing.small,
              width: 42.w,
              value: state.active ?? false,
              onToggle: (value) {
                context.read<ModifyTicketTypeBloc>().add(
                      ModifyTicketTypeEvent.onActiveChanged(
                        active: value,
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
