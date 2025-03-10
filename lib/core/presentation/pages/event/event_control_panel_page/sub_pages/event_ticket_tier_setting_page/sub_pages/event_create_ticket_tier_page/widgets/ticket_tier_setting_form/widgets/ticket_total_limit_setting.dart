import 'package:app/core/application/event_tickets/modify_ticket_type_bloc/modify_ticket_type_bloc.dart';
import 'package:app/core/presentation/widgets/common/set_limit_bottomsheet/set_limit_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketTotalLimitSetting extends StatelessWidget {
  const TicketTotalLimitSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final modifyTicketTypeBloc = context.watch<ModifyTicketTypeBloc>();
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () async {
        final result = await SetLimitBottomSheet.show(
          context,
          title: t.event.ticketTierSetting.totalTickets,
          description: t.event.ticketTierSetting.totalTickets,
          initialValue: modifyTicketTypeBloc.state.ticketLimit?.toInt() ?? 100,
        );
        if (result != null) {
          context.read<ModifyTicketTypeBloc>().add(
                ModifyTicketTypeEvent.onTicketTotalLimitChanged(
                  ticketLimit: result.toDouble(),
                ),
              );
        }
      },
      child: Column(
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) =>
                                Assets.icons.icArrowUpToLine.svg(
                              width: 18.w,
                              height: 18.w,
                              colorFilter: filter,
                            ),
                          ),
                          SizedBox(width: Spacing.xSmall),
                          Text(
                            t.event.ticketTierSetting.totalTickets,
                            style: Typo.medium.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            modifyTicketTypeBloc.state.ticketLimit != null
                                ? (modifyTicketTypeBloc.state.ticketLimit ?? 0)
                                    .toInt()
                                    .toString()
                                : t.event.ticketTierSetting.unlimited,
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(width: Spacing.extraSmall),
                          ThemeSvgIcon(
                            color: colorScheme.onSecondary,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
