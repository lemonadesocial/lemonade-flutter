import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class GuestLimitTicketSetting extends StatefulWidget {
  const GuestLimitTicketSetting({super.key});

  @override
  State<GuestLimitTicketSetting> createState() =>
      _GuestLimitTicketSettingState();
}

class _GuestLimitTicketSettingState extends State<GuestLimitTicketSetting> {
  bool limitFieldVisible = false;

  @override
  initState() {
    super.initState();
    final modifyTicketTypeBloc = context.read<ModifyTicketTypeBloc>();
    setState(() {
      limitFieldVisible =
          modifyTicketTypeBloc.initialTicketType?.ticketLimit != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final modifyTicketTypeBloc = context.read<ModifyTicketTypeBloc>();
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                    t.event.ticketTierSetting.guestLimit,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.87),
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    t.event.ticketTierSetting.unlimitedOfGuestsAllowed,
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
                activeColor: LemonColor.paleViolet,
                activeToggleColor: colorScheme.onPrimary,
                height: Sizing.small,
                width: 42.w,
                value: limitFieldVisible,
                onToggle: (value) {
                  setState(() {
                    limitFieldVisible = value;
                  });
                  context.read<ModifyTicketTypeBloc>().add(
                        ModifyTicketTypeEvent.onGuestsLimitChanged(
                          limit: null,
                        ),
                      );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: Spacing.smMedium),
        if (limitFieldVisible)
          LemonTextField(
            initialText: modifyTicketTypeBloc.initialTicketType?.ticketLimit
                ?.toInt()
                .toString(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {
              context.read<ModifyTicketTypeBloc>().add(
                    ModifyTicketTypeEvent.onGuestsLimitChanged(
                      limit: value.isNotEmpty ? double.parse(value) : 0,
                    ),
                  );
            },
            textInputType: TextInputType.number,
            hintText: t.event.ticketTierSetting.limitOfGuestsAllowed,
          ),
      ],
    );
  }
}
