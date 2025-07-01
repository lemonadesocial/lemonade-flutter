import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/sub_pages/event_ticket_tier_whitelist_form_page/event_ticket_tier_whitelist_form_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/sub_pages/event_ticket_tier_whitelist_form_page/widgets/add_email_to_whitelist_bottomsheet.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LimitedTicketSetting extends StatelessWidget {
  final EventTicketType? ticketType;
  const LimitedTicketSetting({
    super.key,
    this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;

    return BlocBuilder<ModifyTicketTypeBloc, ModifyTicketTypeState>(
      builder: (context, state) {
        final modifyTicketTypeBloc = context.read<ModifyTicketTypeBloc>();
        if (state.active == false || state.private == true) {
          return TicketSettingLockedItem(
            label: t.event.ticketTierSetting.lockTicket,
          );
        }
        final displayWhitelistEmails = <String>{
          // current ticket white list emails,
          ...(ticketType?.limitedWhitelistUsers
                  ?.map((item) => item.email ?? '')
                  .toList() ??
              []),
          // added whitelist email in bloc
          ...state.addedWhitelistEmails,
          // filter email which is in removed whitelist
        }
            .where((element) => !state.removedWhitelistEmails.contains(element))
            .toList();

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                color: appColors.cardBg,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ThemeSvgIcon(
                        color: appColors.textTertiary,
                        builder: (filter) => Assets.icons.icLock.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.xSmall),
                      Text(
                        t.event.ticketTierSetting.lockTicket,
                        style: Typo.medium.copyWith(
                          color: appColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Text(
                        state.limited == true
                            ? t.event.ticketTierSetting.onlyWhitelisted
                            : t.event.ticketTierSetting.anyoneCanBuy,
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
                    value: state.limited ?? false,
                    onToggle: (value) {
                      context.read<ModifyTicketTypeBloc>().add(
                            ModifyTicketTypeEvent.onLimitedChanged(
                              limited: value,
                            ),
                          );
                      if (value == true &&
                          (ticketType?.limitedWhitelistUsers == null ||
                              ticketType?.limitedWhitelistUsers?.isEmpty ==
                                  true)) {
                        showCupertinoModalBottomSheet(
                          bounce: true,
                          backgroundColor: appColors.pageBg,
                          barrierColor: Colors.black.withOpacity(0.5),
                          context: context,
                          builder: (newContext) {
                            return AddEmailToWhiteListBottomSheet(
                              onSubmit: (addedEmails) =>
                                  context.read<ModifyTicketTypeBloc>().add(
                                        ModifyTicketTypeEvent.onWhitelistAdded(
                                          emails: addedEmails,
                                        ),
                                      ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            if (state.limited == true)
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (newContext) => BlocProvider.value(
                        value: modifyTicketTypeBloc,
                        child: const EventTicketTierWhitelistFormPage(),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(Spacing.smMedium),
                  decoration: BoxDecoration(
                    color: appColors.cardBg,
                    border: Border(
                      top: BorderSide(
                        color: appColors.pageDivider,
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
                        '${t.event.ticketTierSetting.whitelistSetting.whitelistedUser} (${displayWhitelistEmails.length})',
                        style: Typo.medium.copyWith(
                          color: appColors.textPrimary,
                        ),
                      ),
                      ThemeSvgIcon(
                        color: appColors.textTertiary,
                        builder: (colorFilter) => Assets.icons.icArrowRight.svg(
                          colorFilter: colorFilter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
