import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/ticket_setting_locked_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class LimitedTicketSetting extends StatelessWidget {
  final EventTicketType? ticketType;
  const LimitedTicketSetting({
    super.key,
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
      builder: (context, state) {
        if (state.active == false || state.private == true) {
          return TicketSettingLockedItem(
            label: t.event.ticketTierSetting.lockTicket,
          );
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.06),
                borderRadius: BorderRadius.only(
                  bottomRight: state.limited == true
                      ? Radius.zero
                      : Radius.circular(LemonRadius.normal),
                  bottomLeft: state.limited == true
                      ? Radius.zero
                      : Radius.circular(LemonRadius.normal),
                  topRight: Radius.circular(LemonRadius.normal),
                  topLeft: Radius.circular(LemonRadius.normal),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.event.ticketTierSetting.lockTicket,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.87),
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Text(
                        state.limited == true
                            ? t.event.ticketTierSetting.onlyWhitelisted
                            : t.event.ticketTierSetting.anyoneCanBuy,
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
                    value: state.limited ?? false,
                    onToggle: (value) {
                      context.read<ModifyTicketTypeBloc>().add(
                            ModifyTicketTypeEvent.onLimitedChanged(
                              limited: value,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
            if (state.limited == true)
              Container(
                padding: EdgeInsets.all(Spacing.smMedium),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.06),
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.onSecondary,
                      width: 0.2.w,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(LemonRadius.normal),
                    bottomLeft: Radius.circular(LemonRadius.normal),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${t.event.ticketTierSetting.whitelistSetting.whitelistedUser} (${ticketType?.limitedWhitelistUsers?.length ?? 0})',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (colorFilter) => Assets.icons.icArrowRight.svg(
                        colorFilter: colorFilter,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
