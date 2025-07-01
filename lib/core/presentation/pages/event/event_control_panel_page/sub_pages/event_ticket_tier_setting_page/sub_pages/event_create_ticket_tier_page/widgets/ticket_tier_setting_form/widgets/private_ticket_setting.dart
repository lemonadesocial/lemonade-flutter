import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/ticket_tier_setting_form/widgets/ticket_setting_locked_item.dart';
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

class PrivateTicketSetting extends StatelessWidget {
  const PrivateTicketSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;

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
            color: appColors.cardBg,
            borderRadius: BorderRadius.circular(LemonRadius.normal),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (filter) {
                      return state.private == true
                          ? Assets.icons.icPrivate.svg(
                              colorFilter: filter,
                            )
                          : Assets.icons.icEyeOutline.svg(
                              colorFilter: filter,
                            );
                    },
                  ),
                  SizedBox(width: Spacing.xSmall),
                  Text(
                    t.event.ticketTierSetting.listTicket,
                    style: Typo.medium.copyWith(
                      color: appColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: Spacing.superExtraSmall),
                  Text(
                    state.private == true
                        ? t.event.ticketTierSetting.canOnlyAssigned
                        : t.event.ticketTierSetting.visibleToEveryone,
                    style: Typo.small.copyWith(
                      color: appColors.textTertiary,
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
