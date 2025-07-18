import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/widgets/common/set_limit_bottomsheet/set_limit_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
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
    final appColors = context.theme.appColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: appColors.cardBg,
            borderRadius: BorderRadius.circular(LemonRadius.normal),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Spacing.smMedium),
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (filter) => Assets.icons.icAddGuest.svg(
                            width: 18.w,
                            height: 18.w,
                            colorFilter: filter,
                          ),
                        ),
                        SizedBox(width: Spacing.xSmall),
                        Text(
                          t.event.ticketTierSetting.groupRegistration,
                          style: Typo.medium.copyWith(
                            color: appColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FlutterSwitch(
                      inactiveColor: appColors.pageDivider,
                      inactiveToggleColor: appColors.textTertiary,
                      activeColor: appColors.textAccent,
                      activeToggleColor: appColors.textPrimary,
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
                InkWell(
                  onTap: () async {
                    final value = await SetLimitBottomSheet.show(
                      context,
                      title: t.event.ticketTierSetting.groupRegistration,
                      description:
                          t.event.ticketTierSetting.maxTicketsPerGuests,
                      initialValue:
                          modifyTicketTypeBloc.state.ticketLimitPer?.toInt() ??
                              2,
                    );
                    if (value != null) {
                      context.read<ModifyTicketTypeBloc>().add(
                            ModifyTicketTypeEvent.onTicketLimitPerChanged(
                              ticketLimitPer:
                                  value == -1 ? 1 : value.toDouble(),
                            ),
                          );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(Spacing.small),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: appColors.pageDivider,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(LemonRadius.normal),
                        bottomRight: Radius.circular(LemonRadius.normal),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.event.ticketTierSetting.maxTicketsPerGuests,
                          style: Typo.medium.copyWith(
                            color: appColors.textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              modifyTicketTypeBloc.state.ticketLimitPer
                                      ?.toInt()
                                      .toString() ??
                                  '0',
                              style: Typo.medium.copyWith(
                                color: appColors.textTertiary,
                              ),
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            ThemeSvgIcon(
                              color: appColors.textTertiary,
                              builder: (filter) => Assets.icons.icEdit.svg(
                                width: 18.w,
                                height: 18.w,
                                colorFilter: filter,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
