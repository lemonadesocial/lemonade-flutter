import 'package:app/core/application/event/modify_reward_bloc/modify_reward_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class EventRewardListTicketTypes extends StatelessWidget {
  final List<EventTicketType> eventTicketTypes;
  final Function(EventTicketType eventTicketType) onTapTicketType;
  const EventRewardListTicketTypes({
    super.key,
    required this.eventTicketTypes,
    required this.onTapTicketType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<String> selectedEventTicketTypeIds =
        context.watch<ModifyRewardBloc>().state.selectedEventTicketTypeIds;
    bool isValid = context.watch<ModifyRewardBloc>().state.isValid;
    final isInitialStatus =
        context.watch<ModifyRewardBloc>().state.status.isInitial;
    bool isErrorValidation = isInitialStatus == false &&
        selectedEventTicketTypeIds.isEmpty &&
        isValid == false;
    return SliverList.separated(
      itemCount: eventTicketTypes.length,
      itemBuilder: (context, index) {
        final item = eventTicketTypes[index];
        return InkWell(
          onTap: () => onTapTicketType(item),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.extraSmall,
            ),
            child: Row(
              children: [
                BlocBuilder<ModifyRewardBloc, ModifyRewardState>(
                  builder: (context, state) {
                    if (state.selectedEventTicketTypeIds.contains(item.id)) {
                      return Assets.icons.icChecked.svg(
                        width: Sizing.regular,
                        height: Sizing.regular,
                      );
                    }
                    if (isErrorValidation) {
                      return Assets.icons.icUncheck.svg(
                        color: Colors.red,
                        width: Sizing.regular,
                        height: Sizing.regular,
                      );
                    }
                    return Assets.icons.icUncheck.svg(
                      width: Sizing.regular,
                      height: Sizing.regular,
                    );
                  },
                ),
                SizedBox(
                  width: Spacing.smMedium,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      style: Typo.medium,
                    ),
                    Text(
                      item.ticketLimit == null
                          ? t.event.ticketTierSetting.unlimitedGuests
                          : t.event.ticketTierSetting.guestsCount(
                              n: (item.ticketLimit ?? 0).toInt(),
                            ),
                      style:
                          Typo.small.copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Theme.of(context).colorScheme.outline,
        );
      },
    );
  }
}
