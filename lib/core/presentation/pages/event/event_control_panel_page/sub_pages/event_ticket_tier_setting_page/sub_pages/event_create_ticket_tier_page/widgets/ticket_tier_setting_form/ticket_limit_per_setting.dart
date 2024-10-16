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

class TicketLimitPerSetting extends StatelessWidget {
  const TicketLimitPerSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final modifyTicketTypeBloc = context.watch<ModifyTicketTypeBloc>();
    final limitFieldVisible = modifyTicketTypeBloc.state.ticketLimitPer != 1;
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(LemonRadius.normal),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Spacing.smMedium),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.event.ticketTierSetting.groupRegistration,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.87),
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          t.event.ticketTierSetting
                              .groupRegistrationDescription,
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
                      value: limitFieldVisible,
                      onToggle: (value) {
                        context.read<ModifyTicketTypeBloc>().add(
                              ModifyTicketTypeEvent.onTicketLimitPerChanged(
                                ticketLimitPer: value ? 2 : 1,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
              if (limitFieldVisible) ...[
                Container(
                  decoration: BoxDecoration(
                    color: LemonColor.chineseBlack,
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.outline,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(LemonRadius.normal),
                      bottomRight: Radius.circular(LemonRadius.normal),
                    ),
                  ),
                  child: LemonTextField(
                    filled: true,
                    fillColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    initialText: modifyTicketTypeBloc.state.ticketLimitPer
                        ?.toInt()
                        .toString(),
                    placeholderStyle: Typo.medium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChange: (value) {
                      context.read<ModifyTicketTypeBloc>().add(
                            ModifyTicketTypeEvent.onTicketLimitPerChanged(
                              ticketLimitPer:
                                  value.isNotEmpty ? double.parse(value) : 2,
                            ),
                          );
                    },
                    textInputType: TextInputType.number,
                    hintText: t.event.ticketTierSetting.limitOfGuestsAllowed,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
